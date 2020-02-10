import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quizz_provider.dart';

class CountryCard extends StatelessWidget {
  const CountryCard({this.code, Key key}) : super(key: key);

  final String code;

  @override
  Widget build(BuildContext context) {
    QuizzProvider quizzProvider = Provider.of<QuizzProvider>(context);

    return Container(
      height: 80,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white10,
        elevation: 8,
        child: InkWell(
          onTap: () {
            quizzProvider.setLanguage(code);
            Navigator.of(context).pop();
          },
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Image(image: AssetImage('assets/images/$code.jpg')),
            SizedBox(height: 20),
            Text(code),
          ]),
        ),
      ),
    );
  }
}
