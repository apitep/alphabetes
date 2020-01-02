import 'package:flutter/material.dart';

import '../components/chooser/ArcChooser.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  int slideValue = 0;
  int lastAnimPosition = 0;
  int answer = 0;

  int currentCorrect;
  List<String> currentCandidates;
  Color startColor;
  Color endColor;
  AnimationController animation;

  @override
  void initState() {
    super.initState();

    currentCorrect = 0;
    currentCandidates = ["réponse1", "réponse2", "reponse3", "reponse4", "réponse5", "réponse6", "reponse7", "reponse8"];

    startColor = Color(0xFF21e1fa);
    endColor = Color(0xff3bb8fd);

    animation = new AnimationController(
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

  ArcItem _selectedItem;
  int _animPosition;
  _arcItemSelected(int pos, ArcItem item) {
    if (item == null) { return; }
    print(item.text);
    _animPosition = pos;
    animation.animateTo(_animPosition * 100.0);

    lastAnimPosition = _animPosition;
    setState(() {
      answer = lastAnimPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(

            ),
            Container(
              color: Colors.transparent,
              width: size.width,
              child: ArcChooser(
                arcNames: currentCandidates,
                arcSelectedCallback: _arcItemSelected(_animPosition, _selectedItem),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
