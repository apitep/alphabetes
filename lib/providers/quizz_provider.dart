import 'package:alphabetes/models/rewards.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/constants.dart';
import '../models/animal.dart';
import '../models/quizz_animals.dart';

class QuizzProvider with ChangeNotifier {
  QuizzProvider() {
    fetchData();
  }

  int points = 1;
  int quizzpictCurrentScore = 0;

  List<Animal> animals = List<Animal>();
  List<String> currentCandidates = ['', '', '', '', '', '', '', ''];
  Rewards rewards;

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
  QuizzAnimals chooseQuestion() {
    QuizzAnimals question;
    if (animals != null && animals.length > 7) {
      Animal randomAnimal = (animals..shuffle()).first;
      question = QuizzAnimals(randomAnimal, animals);
      currentCandidates = question.chooserCandidates;
    }
    return question;
  }

  //
  Future<void> fetchData() async {
    isFetching = true;
    animals = await getAnimalsList('fr', 'animals');
    currentQuestion = chooseQuestion();
    rewards = await getRewards();
    isFetching = false;
  }

  // load awards
  Future<Rewards> getRewards() async {
    dynamic _response;

    _response = await http.get(Constants.kUrlRewards);
    if (_response.statusCode == 200) {
      var decodedJson = jsonDecode(_response.body);
      return Rewards.fromJson(decodedJson);
    } else {
      return Rewards();
    }
  }

  Future<List<Animal>> getAnimalsList(String language, String categ) async {
    String url = Constants.kUrlRemoteData + language + '/' + categ + '.json';
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
}
