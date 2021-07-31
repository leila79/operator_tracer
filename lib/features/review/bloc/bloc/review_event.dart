part of 'review_bloc.dart';

@immutable
abstract class ReviewEvent {}

class GetCheckListData extends ReviewEvent {
  CheckItem checkItem;
  GetCheckListData({required this.checkItem});
}
