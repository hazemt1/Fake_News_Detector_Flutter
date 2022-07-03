part of 'setting_bloc.dart';

@immutable
abstract class SettingEvent {
  const SettingEvent();
}

class SetSetting extends SettingEvent{
  final Settings settings;
  const SetSetting({required this.settings}) ;
}
class ToggleTheme extends SettingEvent{
  final Settings settings;

  const ToggleTheme({required this.settings}) ;
}

class ChangeLang extends SettingEvent{
  final Settings settings;
  const ChangeLang({required this.settings});
}
