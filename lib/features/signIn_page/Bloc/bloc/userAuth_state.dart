part of 'userAuth_bloc.dart';

class UserAuthblocInitial extends MasterState {}

class ShowUserInfo extends MasterState {
  User user;
  ShowUserInfo({required this.user});
}

class NewPassword extends MasterState {}

// class ConnectionError extends MasterState {}
