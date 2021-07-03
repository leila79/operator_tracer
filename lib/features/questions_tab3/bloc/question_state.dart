part of 'question_bloc.dart';

class QuestionInitial extends MasterState {}

class ShowPageData extends MasterState {
  // String pageNum;
  List<QuestionItem> questions;
  Map<String, dynamic> answers;

  ShowPageData({required this.questions, required this.answers});
}
