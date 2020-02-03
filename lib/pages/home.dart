import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/app_state.dart';
import '../components/chooser/ArcChooser.dart';
import '../pages/transition_route_observer.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;
  static const routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin, TransitionRouteAware {
  final routeObserver = TransitionRouteObserver<PageRoute>();

  int slideValue = 0;
  int lastAnimPosition = 0;
  int answer = 0;

  AppState appState;
  List<String> candidates = ['', '', '', '', '', '', '', ''];
  int currentCorrect;

  Color startColor;
  Color endColor;
  AnimationController animation;

  @override
  void initState() {
    super.initState();

    currentCorrect = 0;

    startColor = Color(0xFF21e1fa);
    endColor = Color(0xff3bb8fd);

    animation = AnimationController(
      value: 0.0,
      lowerBound: 0.0,
      upperBound: 400.0,
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..addListener(() {
        setState(() {
          slideValue = animation.value.toInt();
        });
      });

    animation.animateTo(slideValue.toDouble());
  }

  int _animPosition = 0;

  checkAnswer(int pos) {
    if (appState == null) {
      return;
    }

    if (appState.currentQuestion != null &&
        appState.currentQuestion.candidates[pos].name == appState.currentQuestion.goodAnswer.name) {
      print("good answer");
    } else {
      print("wrong answer");
    }

    _animPosition = pos;
    animation.animateTo(_animPosition * 100.0);

    lastAnimPosition = _animPosition;
    appState.chooseQuestion();

    candidates = appState.currentQuestion.chooserCandidates;
    answer = lastAnimPosition;
    
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    super.dispose();
    routeObserver.unsubscribe(this);
  }

  @override
  void didPushAfterTransition() {
    appState.chooseQuestion();
  }

  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppState>(context);

    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                    child: appState.currentQuestion == null
                        ? CircularProgressIndicator()
                        : FadeInImage.assetNetwork(
                            placeholder: 'assets/images/throbber.gif',
                            image: appState.currentQuestion.goodAnswer.imageUrl,
                          )),
              ),
            ),
            Container(
              color: Colors.transparent,
              width: size.width,
              child: ArcChooser(
                arcNames: candidates,
                arcSelectedCallback: checkAnswer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
