import 'package:alphabetes/components/language_chooser.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:lottie/lottie.dart';

import '../models/constants.dart';
import '../models/custom_popup_menu.dart';
import '../providers/quizz_provider.dart';
import '../components/chooser/ArcChooser.dart';
import '../pages/transition_route_observer.dart';

enum DialogAction {
  success,
  failure,
}

const List<Key> Giffykeys = [
  Key("success"),
  Key("failure"),
];

List<CustomPopupMenu> choices = <CustomPopupMenu>[
  CustomPopupMenu(title: 'Français', language: 'fr', icon: Icons.home),
  CustomPopupMenu(title: 'Néerlandais', language: 'nl', icon: Icons.bookmark),
];

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;
  static const routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin, TransitionRouteAware {
  final routeObserver = TransitionRouteObserver<PageRoute>();

  int slideValue = 0;
  int lastAnimPosition = 0;

  QuizzProvider quizzProvider;

  Color startColor;
  Color endColor;
  AnimationController animation;
  AnimationController lottieController;
  Future<LottieComposition> composition;

  static AudioPlayer audio = AudioPlayer();

  @override
  void initState() {
    super.initState();

    lottieController = AnimationController(vsync: this);

    startColor = Color(0xFF21e1fa);
    endColor = Color(0xff3bb8fd);

    animation = AnimationController(
      value: 0.0,
      lowerBound: 0.0,
      upperBound: 400.0,
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..addListener(() {
        setState(
          () {
            slideValue = animation.value.toInt();
          },
        );
      });

    animation.animateTo(slideValue.toDouble());
  }

  int _animPosition = 0;

  checkAnswer(int pos) {
    if (quizzProvider == null) {
      return;
    }

    int points = quizzProvider.points;
    int score = quizzProvider.quizzpictCurrentScore;

    _animPosition = pos;
    animation.animateTo(_animPosition * 100.0);
    lastAnimPosition = _animPosition;

    if (quizzProvider.currentQuestion != null &&
        quizzProvider.currentQuestion.candidates[pos].name == quizzProvider.currentQuestion.goodAnswer.name) {
      audio.play(Constants.kUrlApplause);
      audio.onPlayerCompletion.listen((event) {});

      if (points > 0) {
        score = score + points;
      }
      lottieController.stop();
      var reward = quizzProvider.getRandomReward();
      displaySuccess(points, score, reward);
    } else {
      String speech = quizzProvider.currentQuestion.candidates[pos].name.replaceAll('\n', ' ');
      quizzProvider.read(speech);

      if (points > 0) {
        score = score - points;

        if (score <= 0) {
          score = 0;
        }
      }
      displayFailure(score, quizzProvider.currentQuestion.candidates[pos].name);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    animation.dispose();
    lottieController.dispose();
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPushAfterTransition() {}

  @override
  Widget build(BuildContext context) {
    quizzProvider = Provider.of<QuizzProvider>(context);

    var size = MediaQuery.of(context).size;
    var flagimage = quizzProvider.language + '.jpg';

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Image.asset('assets/images/$flagimage'),
            iconSize: 50,
            onPressed: () {
              _showModalSheet();
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(height: 10),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  quizzProvider.readQuestion(quizzProvider.currentQuestion);
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: quizzProvider.currentQuestion == null
                      ? Container()
                      : FutureBuilder<LottieComposition>(
                          future: quizzProvider.loadComposition(quizzProvider.currentQuestion.goodAnswer.imageUrl),
                          builder: (context, snapshot) {
                            var composition = snapshot.data;
                            if (composition != null) {
                              var lottie = Lottie(composition: composition, controller: lottieController);
                              lottieController
                                ..duration = composition.duration
                                ..repeat();
                              return lottie;
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        ),
                ),
              ),
            ),
            Container(
              color: Colors.transparent,
              width: size.width,
              child: ArcChooser(
                arcNames: quizzProvider.currentCandidates,
                arcSelectedCallback: checkAnswer,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<DialogAction> displaySuccess(int points, int score, String urlReward) async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => NetworkGiffyDialog(
        image: Image.network(urlReward, fit: BoxFit.cover),
        key: Key("success"),
        onlyCancelButton: true,
        buttonCancelColor: Colors.green,
        buttonCancelText: Text(
          'OK',
          style: TextStyle(
            fontFamily: 'Montserrat-SemiBold',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        title: points <= 0
            ? Text('')
            : Text(
                "Bravo !",
                style: TextStyle(
                  fontFamily: 'Montserrat-SemiBold',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
        description: points <= 0
            ? null
            : Text(
                "+ $points pt!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Montserrat-SemiBold',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
        entryAnimation: EntryAnimation.DEFAULT,
        onCancelButtonPressed: () {
          Navigator.pop(context, DialogAction.success);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (BuildContext context) => HomePage(title: Constants.appName)));
          quizzProvider.quizzpictCurrentScore = score;
          quizzProvider.currentQuestion = quizzProvider.chooseQuestion();
        },
      ),
    );
  }

  Future<DialogAction> displayFailure(int score, String description) async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => AssetGiffyDialog(
        image: Image.asset('assets/animations/failed.gif', fit: BoxFit.cover),
        key: Key("failure"),
        onlyCancelButton: true,
        buttonCancelText: Text(
          'OK',
          style: TextStyle(
            fontFamily: 'Montserrat-SemiBold',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Oops!',
          style: TextStyle(
            fontFamily: 'Montserrat-SemiBold',
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        description: Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Montserrat-SemiBold',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        entryAnimation: EntryAnimation.TOP,
        onCancelButtonPressed: () {
          Navigator.pop(context, DialogAction.failure);
          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => HomePage(title: Constants.appName)));
          quizzProvider.quizzpictCurrentScore = score;
        },
      ),
    );
  }

  void _showModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return LanguageChooser();
        });
  }
}
