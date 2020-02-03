import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info/package_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'constants.dart';
import 'animal.dart';
import 'quizz_animals.dart';

class AppState with ChangeNotifier {
  AppState() {
    getAppInfo();
    fetchData();
  }

  PackageInfo packageInfo;
  String appVersion;
  int currentBottomTabIndex = 0;

  List<Animal> animals = List<Animal>();

  QuizzAnimals _currentQuestion;
  QuizzAnimals get currentQuestion => _currentQuestion;
  set currentQuestion(QuizzAnimals newValue) {
    _currentQuestion = newValue;
    notifyListeners();
  }

  bool _isFetching = true;
  bool get isFetching => _isFetching;
  set isFetching(bool newValue) {
    _isFetching = newValue;
    notifyListeners();
  }

  //
  void chooseQuestion() {
    if (animals != null && animals.length > 7) {
      Animal randomAnimal = (animals..shuffle()).first;
      //var selectedAnimals = animals.toList().removeAt(0);
      currentQuestion = QuizzAnimals(randomAnimal, animals);
    }
  }

  //
  Future<void> fetchData() async {
    isFetching = true;
    animals = await getAnimalsList('fr', 'animals');
    isFetching = false;
  }

  Future<List<Animal>> getAnimalsList(String language, String categ) async {
    String url = kUrlRemoteData + language + '/' + categ + '.json';
    String jsondata;
    dynamic _response;

    _response = await http.get(url);
    if (_response.statusCode == 200) {
      jsondata = _response.body;
    }

    return parseAnimals(jsondata);
  }

  List<Animal> parseAnimals(String jsondata) {
    if (jsondata == null) {
      return [];
    }
    final parsed = json.decode(jsondata.toString()).cast<Map<String, dynamic>>();
    return parsed.map<Animal>((json) => Animal.fromJson(json)).toList();
  }

  Future getAppInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
    notifyListeners();
  }
}
