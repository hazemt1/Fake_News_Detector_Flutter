part of 'setting_bloc.dart';

@immutable
abstract class SettingState {
  final Settings settings;
  const SettingState({required this.settings});
}

class SettingInitial extends SettingState{
  const SettingInitial({required Settings settings}) : super(settings: settings);
}
class ThemeToggle extends SettingState {
  const ThemeToggle({required Settings settings}) : super(settings: settings);
}
class LanguageChange extends SettingState {
  const LanguageChange({required Settings settings}) : super(settings: settings);
}
