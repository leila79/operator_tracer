part of 'question_bloc.dart';

class QuestionInitial extends MasterState {}

class ShowPageData extends MasterState {
  // String pageNum;
  final List<QuestionItem> questions;
  final Map<String, dynamic> answers;

  ShowPageData({required this.questions, required this.answers});
}
