part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class GetUserInfo extends UserEvent {}

class GetNewPassword extends UserEvent {
  String password;
  GetNewPassword({required this.password});
}

class CheckCurrentPassword extends UserEvent {
  String password;
  CheckCurrentPassword({required this.password});
}

class UploadImage extends UserEvent {
  File file;
  UploadImage({required this.file});
}
