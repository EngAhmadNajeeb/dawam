import 'dart:convert';

import 'package:dawam/models/auth_data.dart';
import 'package:dawam/models/month.dart';
import 'package:dawam/utilities/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataStore {
  static final DataStore _dataStore = DataStore._internal();
  DataStore._internal();
  factory DataStore() {
    return _dataStore;
  }
  String lang = 'en';
  String baseUrl = "192.168.1.4:8080";
  ProjectType proType = ProjectType.staging;
  AuthData? authData;
  Month? current;

  setProjectType(ProjectType type) {
    proType = type;
    switch (type) {
      case ProjectType.production:
        baseUrl = "192.168.1.112:8080";
        break;
      case ProjectType.staging:
        baseUrl = "192.168.1.4:8080";
        break;
      default:
    }
  }

  Future<bool> setLang(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    lang = value;
    return prefs.setString('Lang', value);
  }

  Future<void> getLang() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    lang = prefs.getString('Lang') ?? 'ar';
  }

  Future<bool> saveAuthData(String json) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('AuthData', json);
  }

  Future<AuthData?> loadAuthData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getString("AuthData") == null) {
      return null;
    } else {
      var authDataJson = json.decode(preferences.getString("AuthData")!);
      authData = AuthData.fromMap(authDataJson);
      return authData;
    }
  }

  Future<bool> deletAuthData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    authData = null;
    return prefs.remove('AuthData');
  }
}

final dataStore = DataStore();
