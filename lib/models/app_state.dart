import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info/package_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'constants.dart';
import 'animal.dart';

class AppState with ChangeNotifier {
  AppState() {
    getAppInfo();
    fetchData();
  }

  PackageInfo packageInfo;
  String appVersion;

  List<Animal> animals = List<Animal>();

  int currentBottomTabIndex = 0;

  bool _isFetching = true;
  bool get isFetching => _isFetching;
  set isFetching(bool newValue) {
    _isFetching = newValue;
    notifyListeners();
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
