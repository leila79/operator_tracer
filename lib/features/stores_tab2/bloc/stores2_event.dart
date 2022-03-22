part of 'stores2_bloc.dart';

@immutable
abstract class Stores2Event {}

class GetChecklistData extends Stores2Event {}

class AddData extends Stores2Event {
  CheckItem item;
  AddData({required this.item});
}

class DeleteData extends Stores2Event {}
