import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:human_resources/base/bloc/master_state.dart';
import 'package:human_resources/base/error/error.dart';
import 'package:human_resources/features/questions_tab3/repository/question_repository.dart';
import 'package:human_resources/models/question_item.dart';
import 'package:meta/meta.dart';

part 'question_event.dart';
part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, MasterState> {
  QuestionBloc() : super(QuestionInitial());

  QuestionRepository questionRepository = QuestionRepository();
  bool done = false;

  @override
  Stream<MasterState> mapEventToState(
    QuestionEvent event,
  ) async* {
    if (event is GetQuestionsData) {
      yield ShowLoading();
      try {
        // await questionRepository.getItemData(event.pageNum);
        await questionRepository.getItemDataQ(
            event.pageNum, event.checklistNum);
        if (questionRepository.numberOfPages != event.pageNum) {
          done = false;
        } else {
          done = true;
        }
        if (questionRepository.items.length == 0) {
          yield NOData();
        } else {
          yield ShowPageData(
              questions: questionRepository.items,
              answers: questionRepository.answers);
        }
      } catch (e) {
        if (e is ConnectionException) {
          yield ConnectionError();
        } else if (e is TokenException) {
          yield TokenError();
        } else if (e is PublicException) {
          yield OtherError();
        }
      }
    } else if (event is AddAnswerData) {
      try {
        await questionRepository.addItemData(event.answer);
      } catch (e) {
        if (e is ConnectionException) {
          yield ConnectionError();
        } else if (e is TokenException) {
          yield TokenError();
        } else if (e is PublicException) {
          yield OtherError();
        }
      }
    } else if (event is AddPageData) {
      try {
        print('answer : ${event.answer}');
        print('page num: ${event.pageNum}');
        await questionRepository.addTempData(event.answer, event.pageNum);
      } catch (e) {
        if (e is ConnectionException) {
          yield ConnectionError();
        } else if (e is TokenException) {
          yield TokenError();
        } else if (e is PublicException) {
          yield OtherError();
        }
      }
    } else if (event is DeleteFile) {
      try {
        await questionRepository.deleteFiles(event.pageNum);
      } catch (e) {
        if (e is ConnectionException) {
          yield ConnectionError();
        } else if (e is TokenException) {
          yield TokenError();
        } else if (e is PublicException) {
          yield OtherError();
        }
      }
    }
  }
}
