part of 'check_list_bloc.dart';

// @immutable
// abstract class CheckListState {}

class CheckListInitial extends MasterState {}

class ShowItems extends MasterState {
  final List<CheckItem> items;
  ShowItems({required this.items});
}

class ShowSearchedItems extends MasterState {
  final List<CheckItem> items;
  ShowSearchedItems(this.items);
}
