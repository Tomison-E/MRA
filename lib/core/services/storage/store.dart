import 'dart:convert';

import 'package:mra/app/authentication/data/models/user.dart';
import 'package:mra/core/services/storage/storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

class Store {
  static Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Store._();

  static void saveUserInfo(User user) =>
      prefs.setString(kUserKey, json.encode(user.toJson()));

  static User? fetchUserInfo() => prefs.containsKey(kUserKey)
      ? User.fromJson(json.decode(prefs.getString(kUserKey)!))
      : null;

  static void saveTokenInfo(String token) =>
      prefs.setString(kAccessTokenKey, token);

  static String? fetchTokenInfo() => prefs.containsKey(kAccessTokenKey)
      ? prefs.getString(kAccessTokenKey)
      : null;

  static void saveOnBoardingInfo() => prefs.setBool(kOnBoardingKey, true);

  static bool fetchOnBoardingInfo() => prefs.containsKey(kOnBoardingKey);

  static void removeToken() => prefs.remove(kAccessTokenKey);

  static void removeUser() => prefs.remove(kUserKey);
}
