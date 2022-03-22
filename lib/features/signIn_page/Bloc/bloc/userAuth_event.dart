part of 'userAuth_bloc.dart';

@immutable
abstract class UserAuthblocEvent {}

class CheckUserInfo extends UserAuthblocEvent {
  String email;
  String password;
  CheckUserInfo({required this.email, required this.password});
}

class GetNewPassword extends UserAuthblocEvent {
  String email;
  GetNewPassword({required this.email});
}
