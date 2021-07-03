import 'package:meta/meta.dart';

@immutable
abstract class MasterState {}

class InitialMasterState extends MasterState {}

class ShowLoading extends MasterState {}

class ConnectionError extends MasterState {}

class TokenError extends MasterState {}

class OtherError extends MasterState {}

class NotFound extends MasterState {}

class NOData extends MasterState {}

class ShowData extends MasterState {}
