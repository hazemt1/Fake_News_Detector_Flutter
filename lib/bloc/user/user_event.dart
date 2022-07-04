part of 'user_bloc.dart';

@immutable
abstract class UserEvent {
  const UserEvent();
}

class UserLogin extends UserEvent{
  final User user;
  final String token;
  const UserLogin({required this.user,required this.token});
}

class UserLogout extends UserEvent{
  const UserLogout();
}
