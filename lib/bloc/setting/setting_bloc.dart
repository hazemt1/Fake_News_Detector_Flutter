import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class Settings {
  final String currentLocale;
  final ThemeMode themeMode;
  Settings({required this.currentLocale, required this.themeMode});
}

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc()
      : super(SettingInitial(
            settings:
                Settings(currentLocale: "en", themeMode: ThemeMode.light))) {
    on<SetSetting>(_onSetSetting);
    on<ToggleTheme>(_onToggleTheme);
    on<ChangeLang>(_onChangeLang);

  }

  void _onSetSetting(SetSetting event, Emitter emit) {
    emit(
      SettingInitial(
        settings: Settings(
          currentLocale: event.settings.currentLocale,
          themeMode: event.settings.themeMode,
        ),
      ),
    );
  }

  void _onToggleTheme(ToggleTheme event, Emitter emit) {
    ThemeMode themeMode = event.settings.themeMode;
    if (themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }
    emit(ThemeToggle(
        settings: Settings(
            currentLocale: event.settings.currentLocale,
            themeMode: themeMode)));
  }

  void _onChangeLang(ChangeLang event, Emitter emit) {
    String currentLocale = event.settings.currentLocale;
    if (currentLocale == "en") {
      currentLocale = "ar";
    } else {
      currentLocale = "en";
    }
    emit(LanguageChange(
        settings: Settings(
            currentLocale: currentLocale,
            themeMode: event.settings.themeMode)));
  }
}
