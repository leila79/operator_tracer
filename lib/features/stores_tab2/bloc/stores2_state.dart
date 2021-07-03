part of 'stores2_bloc.dart';


class Stores2Initial extends MasterState {}

class ShowChecklistData extends MasterState {
  List<CheckList> checkList;
  ShowChecklistData({required this.checkList});
}
