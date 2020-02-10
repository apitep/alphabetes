import 'package:alphabetes/components/country_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quizz_provider.dart';

final List<String> languagesList = [
  'fr',
  'nl',
  'es',
  'uk',
];

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
      height: size.height * .6,
      child: Center(
        child: PageView(
          controller: viewController,
          children: [
            CountryCard(code: 'fr-FR'),
            CountryCard(code: 'nl-NL'),
            CountryCard(code: 'es-ES'),
            CountryCard(code: 'gb-GB'),
          ],
        ),
      ),
    );
  }
}
