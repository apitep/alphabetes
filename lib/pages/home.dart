import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/app_state.dart';
import '../models/animal.dart';
import '../models/quizz_animals.dart';
import '../components/chooser/ArcChooser.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;
  static const routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int slideValue = 0;
  int lastAnimPosition = 0;
  int answer = 0;

  List<Animal> animals = [];
  int currentCorrect;
  List<String> currentCandidates;
  Color startColor;
  Color endColor;
  AnimationController animation;
  QuizzAnimals currentQuestion;

  @override
  void initState() {
    super.initState();

    currentCorrect = 0;
    currentCandidates = [
      "1-réponse1\nxxxxgggg",
      "2-1234567890\n12345678901",
      "reponse3",
      "reponse4",
      "réponse5",
      "réponse6",
      "reponse7",
      "reponse8"
    ];

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

  itemSelected(int pos) {
    if (currentQuestion != null && currentQuestion.candidates[pos].name == currentQuestion.goodAnswer.name) {
      print("good answer");
    } else {
      print("wrong answer");
    }

    _animPosition = pos;
    animation.animateTo(_animPosition * 100.0);

    lastAnimPosition = _animPosition;

    chooseNewQuestion();

    setState(() {
      answer = lastAnimPosition;
    });
  }

  void chooseNewQuestion() {
    if (animals != null && animals.length > 7) {
      Animal randomAnimal = (animals..shuffle()).first;
      animals.removeAt(0);
      currentQuestion = QuizzAnimals(randomAnimal, animals);
      setState(() {
        currentCandidates = currentQuestion.chooserCandidates();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AppState appState = Provider.of<AppState>(context);
    animals = appState.animals;
    chooseNewQuestion();

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
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: currentQuestion == null ? null : Image.network(currentQuestion.goodAnswer.imageUrl),
                ),
              ),
            ),
            Container(
              color: Colors.transparent,
              width: size.width,
              child: ArcChooser(
                arcNames: currentCandidates,
                arcSelectedCallback: itemSelected,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
