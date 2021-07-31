import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:human_resources/base/bloc/master_state.dart';
import 'package:human_resources/base/error/error.dart';
import 'package:human_resources/database/models/answers_db.dart';
import 'package:human_resources/database/models/question_db.dart';
import 'package:human_resources/database/models/store_db.dart';
import 'package:human_resources/features/review/repository/review_repository.dart';
import 'package:human_resources/models/check_item.dart';
import 'package:meta/meta.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, MasterState> {
  ReviewBloc() : super(ReviewInitial());

  ReviewRepository _repository = ReviewRepository();

  @override
  Stream<MasterState> mapEventToState(
    ReviewEvent event,
  ) async* {
    if (event is GetCheckListData) {
      yield ShowLoading();
      try {
        await _repository.getChecklistData(event.checkItem);
        if (_repository.answers.answer == 0) {
          yield NOData();
        } else {
          yield ShowCheckListData(
              store: _repository.store,
              question: _repository.question,
              answers: _repository.answers);
        }
      } catch (e) {
        if (e is ConnectionException) {
          yield ConnectionError();
        } else if (e is TokenException) {
          yield TokenError();
        } else if (e is PublicException) {
          yield OtherError();
        }
        print(e);
      }
    }
  }
}
