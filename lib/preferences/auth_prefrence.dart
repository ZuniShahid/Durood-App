import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPrefrence {
  AuthPrefrence._();
  static final AuthPrefrence _instance = AuthPrefrence._();
  static AuthPrefrence get instance => _instance;

  void setUserLoggedIn(bool key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLoggedIn", key);
  }

  Future getUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var log = prefs.getBool("isLoggedIn") ?? false;
    return log;
  }

  void saveUserDataToken({@required token}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("token", token);
  }

  Future getUserDataToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String result = pref.getString("token") ?? '';
    return result;
  }

  void saveUserRefreshToken({@required token}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("refresh_token", token);
  }

  Future getUserRefreshToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String result = pref.getString("refresh_token") ?? '';
    return result;
  }

  void saveUserData({@required token}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("userData", token);
  }

  Future getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String result = pref.getString("userData") ?? '';
    return result;
  }
}
