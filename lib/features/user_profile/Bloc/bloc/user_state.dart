part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends MasterState {}

class ShowUserInfo extends MasterState {
  User user;
  ShowUserInfo({required this.user});
}

class NewPassword extends MasterState {}

class ConformPassword extends MasterState {}
