part of 'user_bloc.dart';

@immutable
abstract class UserState {
  final LogInfo logInfo;
  const UserState({required this.logInfo});
}

class UserInitial extends UserState {
  UserInitial({required LogInfo logInfo}) : super(logInfo: logInfo);
}
