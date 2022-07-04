import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences{
  static late SharedPreferences _preferences;

  static const _language = 'language';

  static const _theme = 'theme';


  static const _token = 'token';

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
  static Future setToken(String token) async {
    return await _preferences.setString(_token, token);
  }

  static String getTokenPreference(){
    String? Token =_preferences.getString(_token).toString();
    return Token;
  }

  static bool isLoggedIn(){
    return _preferences.containsKey(_token);
  }

  static Future removeUser()async{
    if(_preferences.containsKey(_token)) {
      return await _preferences.remove(_token);
    }
    return Future(() => null);
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