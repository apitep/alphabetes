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
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: InkWell(
        onTap: () {
          quizzProvider.setLanguage(code);
          Navigator.of(context).pop();
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(image: AssetImage('assets/images/$code.jpg'), fit: BoxFit.cover)),
        ),
      ),
    );
  }
}
