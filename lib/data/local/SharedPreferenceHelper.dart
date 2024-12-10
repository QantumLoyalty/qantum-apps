import 'dart:convert';

import 'package:qantum_apps/data/models/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static SharedPreferences? _sharedPreferences;
  static SharedPreferenceHelper? _instance;

  SharedPreferenceHelper._internal();

  static String USER = "user";

  static Future<SharedPreferenceHelper> getInstance() async {
    _instance ??= SharedPreferenceHelper._internal();
    _sharedPreferences = await SharedPreferences.getInstance();
    return _instance!;
  }

  saveUserData(UserModel user) {
    _sharedPreferences!.setString(USER, jsonEncode(user.toJson()));
  }

  UserModel? getUserData() {
    if (_sharedPreferences!.containsKey(USER)) {
      return UserModel.fromJson(
          jsonDecode(_sharedPreferences!.getString(USER)!));
    }
    return null;
  }

  clearAll() {
    _sharedPreferences!.clear();
  }
}
