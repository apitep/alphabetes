import 'package:flutter/material.dart';

final Color kColorBlueMedincell = Color(0xFF4d9cd5);
final Color kColorLightGray = Color(0xFFececec);

const String kTitle = "Alphabêtes";

const String kUrlRemoteData = "https://raw.githubusercontent.com/apitep/alphabetes/master/remotedata/data/";
const String kUrlImages = "https://raw.githubusercontent.com/apitep/alphabetes/master/remotedata/images/";
const String kDefaultUrlReward = "https://raw.githubusercontent.com/EricNahon/pikatchuTesOu/master/remotedata/images/Bulbasaur.gif";

final Widget kApitepLogo = Image.asset(
  'assets/images/ApitepBearLogo.png',
  height: 100,
);
final Widget kVictoryBadge = Image.asset(
  'assets/images/VictoryBadge.png',
  height: 35,
);

const kLabelTextStyle = TextStyle (
  fontSize: 18.0,
  color: Color(0xFF8D8E98),
);
