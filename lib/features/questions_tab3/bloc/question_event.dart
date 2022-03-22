part of 'question_bloc.dart';

@immutable
abstract class QuestionEvent {}

class GetQuestionsData extends QuestionEvent {
  final int pageNum;
  GetQuestionsData({required this.pageNum});
}

class AddAnswerData extends QuestionEvent {
  final Map<String, dynamic> answer;
  AddAnswerData({required this.answer});
}

class AddPageData extends QuestionEvent {
  final Map<String, dynamic> answer;
  final int pageNum;
  AddPageData({required this.answer, required this.pageNum});
}

class DeleteFile extends QuestionEvent {
  final int pageNum;
  DeleteFile({required this.pageNum});
}
