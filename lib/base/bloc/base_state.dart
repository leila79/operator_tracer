part of 'base_bloc.dart';

@immutable
abstract class BaseState {}

class BaseInitial extends MasterState {}

class ShowUserInfo extends MasterState {
  final String name;
  final String email;
  final String avatar;
  ShowUserInfo({required this.name, required this.email, required this.avatar});
}
