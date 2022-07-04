import 'package:bloc/bloc.dart';
import 'package:fake_news/Api/AuthAPI.dart';
import 'package:fake_news/utils/preferences.dart';
import 'package:meta/meta.dart';

import '../../models/User.dart';

part 'user_event.dart';
part 'user_state.dart';

class LogInfo {
  User? user;
  String? token;
  bool isLoggedIn;

  LogInfo({required this.isLoggedIn, this.user, this.token});
}

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc()
      : super (
          UserInitial(
            logInfo: LogInfo(
              isLoggedIn: Preferences.isLoggedIn(),
              token: Preferences.isLoggedIn()
                  ? Preferences.getTokenPreference()
                  : null,
              user: Preferences.isLoggedIn()
                  ? AuthAPI.getMe(Preferences.getTokenPreference())
                  : null,
            ),
          ),
        ) {
    on<UserLogin>(_onLogin);
    on<UserLogout>(_onLogOut);
  }

  _onLogin(UserLogin event, emit) {
    emit(UserInitial(
        logInfo:
            LogInfo(isLoggedIn: true, user: event.user, token: event.token)));
  }

  _onLogOut(UserLogout event, emit) {
    emit(UserInitial(logInfo: LogInfo(isLoggedIn: false)));
  }
}
