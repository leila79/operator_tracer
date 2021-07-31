part of 'review_bloc.dart';

class ReviewInitial extends MasterState {}

class ShowCheckListData extends MasterState {
  StoreDB store;
  QuestionDB question;
  AnswersDB answers;
  ShowCheckListData(
      {required this.store, required this.question, required this.answers});
}
