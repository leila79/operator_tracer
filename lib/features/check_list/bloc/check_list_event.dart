part of 'check_list_bloc.dart';

@immutable
abstract class CheckListEvent {}

class GetItemData extends CheckListEvent {}

class GetSearchedData extends CheckListEvent {}
