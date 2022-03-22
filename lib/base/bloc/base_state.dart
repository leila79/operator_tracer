part of 'base_bloc.dart';

@immutable
abstract class BaseState {}

class BaseInitial extends MasterState {}

class ShowUserInfo extends MasterState {
  String name;
  String email;
  String avatar;
  ShowUserInfo({required this.name, required this.email, required this.avatar});
}
