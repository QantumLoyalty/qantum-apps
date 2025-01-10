import 'dart:convert';

import 'package:qantum_apps/data/models/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static SharedPreferences? _sharedPreferences;
  static SharedPreferenceHelper? _instance;

  SharedPreferenceHelper._internal();

  static String USER = "user";
  static String AUTH_TOKEN = "authToken";

  static Future<SharedPreferenceHelper> getInstance() async {
    _instance ??= SharedPreferenceHelper._internal();
    _sharedPreferences = await SharedPreferences.getInstance();
    return _instance!;
  }

  saveUserData(UserModel user) async {
   await _sharedPreferences!.setString(USER, jsonEncode(user.toJson()));
  }

  UserModel? getUserData() {
    if (_sharedPreferences!.containsKey(USER)) {
      return UserModel.fromJson(
          jsonDecode(_sharedPreferences!.getString(USER)!));
    }
    return null;
  }

  saveAuthToken(String authToken) {
    _sharedPreferences!.setString(AUTH_TOKEN, authToken);
  }

  String? getAuthToken() {
    if (_sharedPreferences!.containsKey(AUTH_TOKEN)) {
      return _sharedPreferences!.getString(AUTH_TOKEN)!;
    }
    return null;
  }

  clearAll() {
    _sharedPreferences!.clear();
  }
}
