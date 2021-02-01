import 'dart:convert';

import 'package:projectilelaundryapp/models/active_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  SharedPreferences prefs;
  String fieldName = 'userData';

  Future<void> saveToPrefs(ActiveUserModel userData) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString(fieldName, jsonEncode(userData.toJson()));
  }

  Future<ActiveUserModel> loadFromPrefs() async {
    prefs = await SharedPreferences.getInstance();
    return ActiveUserModel.fromJson(jsonDecode(prefs.getString(fieldName)));
  }

  Future<bool> checkPrefs() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(fieldName);
  }

  Future<void> clearPrefs() async {
    prefs = await SharedPreferences.getInstance();
    prefs.remove(fieldName);
  }
}
