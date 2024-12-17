/*
import 'dart:convert';

import 'package:mra/app/authentication/data/models/user.dart';
import 'package:mra/core/services/storage/storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  Storage(this.prefs);

  final SharedPreferences prefs;


  void saveUserInfo(User user) =>
      prefs.setString(kUserKey, json.encode(user.toJson()));

  User? fetchUserInfo() => prefs.containsKey(kUserKey)
      ? User.fromJson(json.decode(prefs.getString(kUserKey)!))
      : null;

  void saveTokenInfo(String token) => prefs.setString(kAccessTokenKey, token);

  String? fetchTokenInfo() =>
      prefs.containsKey(kAccessTokenKey) ? prefs.getString(kUserKey) : null;

  void saveOnBoardingInfo() => prefs.setBool(kOnBoardingKey, true);

  bool fetchOnBoardingInfo()  => prefs.containsKey(kOnBoardingKey);

  void removeToken() => prefs.remove(kAccessTokenKey);

  void removeUser() => prefs.remove(kUserKey);
}
*/
