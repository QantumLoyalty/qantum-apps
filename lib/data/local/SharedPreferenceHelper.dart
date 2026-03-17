import 'dart:convert';

import 'package:qantum_apps/data/local/AppSecureStore.dart';
import 'package:qantum_apps/data/models/UserModel.dart';
import 'package:qantum_apps/data/models/MembershipModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static SharedPreferences? _sharedPreferences;
  static AppSecureStore? _appSecureStore;
  static SharedPreferenceHelper? _instance;

  SharedPreferenceHelper._internal();

  static const String USER = "user";
  static const String MEMBERSHIP = "membership";
  static const String AUTH_TOKEN = "authToken";
  static const String COUNTRY_CODE = "countryCode";

  static Future<SharedPreferenceHelper> getInstance() async {
    _instance ??= SharedPreferenceHelper._internal();
    _sharedPreferences ??= await SharedPreferences.getInstance();
    _appSecureStore ??= AppSecureStore();
    return _instance!;
  }

  /// ---------------- USER ----------------

  Future<void> saveUserData(UserModel user) async {
    try {
      await _appSecureStore!
          .write(key: USER, value: jsonEncode(user.toJson()));
    } catch (e) {
      print("Error while saving user: $e");
    }
  }

  Future<UserModel?> getUserData() async {
    try {
      /// 1️⃣ Check secure storage first
      if (await _appSecureStore!.containsKey(key: USER)) {
        final data = await _appSecureStore!.read(key: USER);
        return UserModel.fromJson(jsonDecode(data!));
      }

      /// 2️⃣ Fallback to SharedPref (existing users)
      if (_sharedPreferences!.containsKey(USER)) {
        UserModel user = UserModel.fromJson(
            jsonDecode(_sharedPreferences!.getString(USER)!));

        /// migrate to secure storage
        await saveUserData(user);

        /// remove old data
        await _sharedPreferences!.remove(USER);

        return user;
      }
    } catch (e) {
      print("Error while reading user: $e");
    }

    return null;
  }

  /// ---------------- AUTH TOKEN ----------------

  Future<void> saveAuthToken(String authToken) async {
    await _appSecureStore!.write(key: AUTH_TOKEN, value: authToken);
  }

  Future<String?> getAuthToken() async {
    /// 1️⃣ Check secure storage
    if (await _appSecureStore!.containsKey(key: AUTH_TOKEN)) {
      return await _appSecureStore!.read(key: AUTH_TOKEN);
    }

    /// 2️⃣ Fallback for existing users
    if (_sharedPreferences!.containsKey(AUTH_TOKEN)) {
      String authToken = _sharedPreferences!.getString(AUTH_TOKEN)!;

      /// migrate
      await _appSecureStore!.write(key: AUTH_TOKEN, value: authToken);

      /// remove old
      await _sharedPreferences!.remove(AUTH_TOKEN);

      return authToken;
    }

    return null;
  }

  /// ---------------- MEMBERSHIP ----------------
  /// Not sensitive → keep in SharedPreferences

  Future<void> saveSelectedMembership(MembershipModel membership) async {
    await _appSecureStore!
        .write(key: MEMBERSHIP, value: jsonEncode(membership.toJson()));
  }

  Future<MembershipModel?> getSelectedMembership() async {

    /// 1️⃣ Check secure storage first
    if (await _appSecureStore!.containsKey(key: MEMBERSHIP)) {
      final data = await _appSecureStore!.read(key: MEMBERSHIP);
      if (data != null) {
        return MembershipModel.fromJson(jsonDecode(data));
      }
    }

    /// 2️⃣ Fallback to SharedPreferences (old users)
    if (_sharedPreferences!.containsKey(MEMBERSHIP)) {
      final membershipData = _sharedPreferences!.getString(MEMBERSHIP);

      if (membershipData != null) {
        await _appSecureStore!.write(key: MEMBERSHIP, value: membershipData);
        await _sharedPreferences!.remove(MEMBERSHIP);

        return MembershipModel.fromJson(jsonDecode(membershipData));
      }
    }

    return null;
  }

  /// ---------------- COUNTRY CODE ----------------

  Future<void> saveCountryCode(String countryCode) async {
    await _appSecureStore!.write(key: COUNTRY_CODE, value: countryCode);
  }

  Future<String?> getCountryCode() async {

    /// 1️⃣ Check secure storage
    if (await _appSecureStore!.containsKey(key: COUNTRY_CODE)) {
      return await _appSecureStore!.read(key: COUNTRY_CODE);
    }

    /// 2️⃣ Fallback to SharedPreferences
    if (_sharedPreferences!.containsKey(COUNTRY_CODE)) {
      final code = _sharedPreferences!.getString(COUNTRY_CODE);

      if (code != null) {
        await _appSecureStore!.write(key: COUNTRY_CODE, value: code);
        await _sharedPreferences!.remove(COUNTRY_CODE);
        return code;
      }
    }

    return null;
  }

  /// ---------------- CLEAR ----------------

  Future<void> clearAll() async {
    await _sharedPreferences!.clear();
    await _appSecureStore!.deleteAll();
  }

  Future<void> migrateOldStorage() async {
    try {
      /// migrate user
      if (!await _appSecureStore!.containsKey(key: USER) &&
          _sharedPreferences!.containsKey(USER)) {

        final userData = _sharedPreferences!.getString(USER);
        if (userData != null) {
          await _appSecureStore!.write(key: USER, value: userData);
          await _sharedPreferences!.remove(USER);
        }
      }

      /// migrate token
      if (!await _appSecureStore!.containsKey(key: AUTH_TOKEN) &&
          _sharedPreferences!.containsKey(AUTH_TOKEN)) {

        final token = _sharedPreferences!.getString(AUTH_TOKEN);
        if (token != null) {
          await _appSecureStore!.write(key: AUTH_TOKEN, value: token);
          await _sharedPreferences!.remove(AUTH_TOKEN);
        }
      }

    } catch (e) {
      print("Migration error: $e");
    }
  }
}