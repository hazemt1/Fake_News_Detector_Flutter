import 'dart:convert';

import 'package:fake_news/models/User.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences{
  static late SharedPreferences _preferences;

  static const _language = 'language';

  static const _theme = 'theme';

  static const _user = 'user';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();


//_______________________________________________________________________________
//LANGUAGE PREFERENCES
  static Future setLanguage(String language) async =>
      await _preferences.setString(_language, language);


  static String getLanguage() =>
      _preferences.getString(_language)??"en";


//_______________________________________________________________________________
//USER PREFERENCES
  static Future setUser(User user) async {
    String userString = jsonEncode(user.toJson());
    return await _preferences.setString(_user, userString);
  }

  static User getUserPreference(){
    String userString =_preferences.getString(_user).toString();

    if(userString==null||userString=="") {
      return User();
    }

    User user = User.fromJsonMap(jsonDecode(userString));
    return user;
  }

  static Future removeUser()async{
    return await _preferences.remove(_user);
  }

//_______________________________________________________________________________
//THEME PREFERENCES
  static Future saveThemePreference(ThemeMode themeMode) async {
    String name;
    if(themeMode == ThemeMode.light) {
      name='light';
    } else {
      name = 'dark';
    }
    _preferences.setString(_theme, name);
  }
  static ThemeMode getThemePreference(){
    String theme =_preferences.getString(_theme).toString();

    if(theme=='light') {
      return ThemeMode.light;
    } else {
      return ThemeMode.dark;
    }
  }


}