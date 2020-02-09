import 'package:alphabetes/models/rewards.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

import '../models/constants.dart';
import '../models/animal.dart';
import '../models/quizz_animals.dart';

class QuizzProvider with ChangeNotifier {
  QuizzProvider() {
    setLanguage('fr');
  }

  Map<String, String> languageNames = Constants.languageNames;

  FlutterTts flutterTts;
  List<String> languages = List<String>();
  String language;

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
  String getRandomReward() {
    String urlReward = '';
    if (rewards != null && rewards.animUrls.length > 0) {
      final _random = Random();
      urlReward = rewards.animUrls[_random.nextInt(rewards.animUrls.length)];
    }

    return urlReward;
  }

  //
  Future<void> fetchData() async {
    isFetching = true;
    animals = await getAnimalsList(language, 'animals');
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

  void initTts() async {
    flutterTts = FlutterTts();
    flutterTts.setLanguage(language);
    await flutterTts.isLanguageAvailable(language);
    flutterTts.setSpeechRate(.4);
    flutterTts.setVolume(1.0);
    flutterTts.setPitch(.8);

    flutterTts = FlutterTts();
    _getLanguages();
  }

  Future _getLanguages() async {
    dynamic sysLanguages = await flutterTts.getLanguages;
    if (sysLanguages != null) {
      for (String lang in sysLanguages) {
        languages.add(lang);
      }
      languages.sort();
    }
  }

  Future read(String text) async {
    await flutterTts.stop();
    if (text != null && text.isNotEmpty) {
      await flutterTts.speak(text.toLowerCase());
    }
  }

  void setLanguage(String lang) {
    language = Constants.languages[lang];
    initTts();
    fetchData();
  }
}
