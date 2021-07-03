part of 'question_bloc.dart';

@immutable
abstract class QuestionEvent {}

class GetQuestionsData extends QuestionEvent {
  int pageNum;
  GetQuestionsData({required this.pageNum});
}

class AddAnswerData extends QuestionEvent {
  Map<String, dynamic> answer;
  AddAnswerData({required this.answer});
}

class AddPageData extends QuestionEvent {
  Map<String, dynamic> answer;
  int pageNum;
  AddPageData({required this.answer, required this.pageNum});
}

class DeleteFile extends QuestionEvent {
  int pageNum;
  DeleteFile({required this.pageNum});
}
