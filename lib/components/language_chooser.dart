import 'package:alphabetes/models/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/country_card.dart';
import '../providers/quizz_provider.dart';

final PageController viewController = PageController(viewportFraction: 0.8, initialPage: 0);

class LanguageChooser extends StatefulWidget {
  LanguageChooser({Key key}) : super(key: key);

  @override
  _LanguageChooserState createState() => _LanguageChooserState();
}

class _LanguageChooserState extends State<LanguageChooser> {
  QuizzProvider quizzProvider;

  @override
  Widget build(BuildContext context) {
    quizzProvider = Provider.of<QuizzProvider>(context);

    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .5,
      child: Center(
        child: PageView(
          controller: viewController,
          children: 
            _buildCountryCards()
          ,
        ),
      ),
    );
  }

  List<Widget> _buildCountryCards() {
    var list = [];
    Constants.languages.entries.forEach((e) => list.add(e.key));
    return list.map((lang) => CountryCard(code: lang)).toList();
  }
}
