import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:human_resources/base/bloc/master_state.dart';
import 'package:human_resources/base/error/error.dart';
import 'package:human_resources/features/stores_tab2/repository/tab2_repository.dart';
import 'package:human_resources/models/checkList.dart';
import 'package:human_resources/models/check_item.dart';
import 'package:meta/meta.dart';

part 'stores2_event.dart';
part 'stores2_state.dart';

class Stores2Bloc extends Bloc<Stores2Event, MasterState> {
  Stores2Bloc() : super(Stores2Initial());
  Tab2Repository tab2repository = Tab2Repository();
  @override
  Stream<MasterState> mapEventToState(
    Stores2Event event,
  ) async* {
    if (event is GetChecklistData) {
      yield ShowLoading();
      try {
        await tab2repository.getItemData();
        if (tab2repository.items.length == 0) {
          yield NOData();
        } else {
          yield ShowChecklistData(checkList: tab2repository.items);
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
    }
    if (event is AddData) {
      try {
        await tab2repository.addItemData(event.items);
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
