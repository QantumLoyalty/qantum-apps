import 'dart:convert';

import 'package:qantum_apps/data/local/AppSecureStore.dart';
import 'package:qantum_apps/data/models/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static SharedPreferences? _sharedPreferences;

  // static AppSecureStore? _appSecureStore;
  static SharedPreferenceHelper? _instance;

  SharedPreferenceHelper._internal();

  static String USER = "user";
  static String AUTH_TOKEN = "authToken";
  static String COUNTRY_CODE = "countryCode";

  static Future<SharedPreferenceHelper> getInstance() async {
    _instance ??= SharedPreferenceHelper._internal();
    _sharedPreferences = await SharedPreferences.getInstance();
    //  _appSecureStore = AppSecureStore();

    return _instance!;
  }

  saveUserData(UserModel user) async {
    await _sharedPreferences!.setString(USER, jsonEncode(user.toJson()));
    //   await _appSecureStore!.write(key: USER, value: jsonEncode(user.toJson()));
  }

  UserModel? getUserData() {
    if (_sharedPreferences!.containsKey(USER)) {
      return UserModel.fromJson(
          jsonDecode(_sharedPreferences!.getString(USER)!));
    }
    return null;

    /*if (_sharedPreferences!.containsKey(USER)) {
      UserModel user =
          UserModel.fromJson(jsonDecode(_sharedPreferences!.getString(USER)!));
      await saveUserData(user);
      await _sharedPreferences!.remove(USER);
      return user;
    } else {
      if (await _appSecureStore!.containsKey(key: USER)) {
        return UserModel.fromJson(
            jsonDecode(_appSecureStore!.read(key: USER) as String));
      }
      return null;
    }*/
  }

  saveAuthToken(String authToken) {
    _sharedPreferences!.setString(AUTH_TOKEN, authToken);
    // _appSecureStore!.write(key: AUTH_TOKEN, value: authToken);
  }

  saveCountryCode(String countryCode) {
    _sharedPreferences!.setString(COUNTRY_CODE, countryCode);
  }

  getCountryCode() {
    if (_sharedPreferences!.containsKey(COUNTRY_CODE)) {
      return _sharedPreferences!.getString(COUNTRY_CODE)!;
    }
    return null;
  }

  String? getAuthToken() {
    if (_sharedPreferences!.containsKey(AUTH_TOKEN)) {
      return _sharedPreferences!.getString(AUTH_TOKEN)!;
    }
    return null;

    /*if (_sharedPreferences!.containsKey(AUTH_TOKEN)) {
      String authToken = _sharedPreferences!.getString(AUTH_TOKEN)!;
      await saveAuthToken(authToken);
      await _sharedPreferences!.remove(AUTH_TOKEN);
      return authToken;
    } else {
      if (await _appSecureStore!.containsKey(key: AUTH_TOKEN)) {
        return _appSecureStore!.read(key: AUTH_TOKEN);
      }
      return null;
    }*/
  }

  clearAll() async {
    await _sharedPreferences!.clear();
    //_appSecureStore!.deleteAll();
  }
}
