import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:human_resources/base/bloc/master_state.dart';
import 'package:human_resources/base/error/error.dart';
import 'package:human_resources/features/stores_tab1/repository/stores_repositort.dart';
import 'package:human_resources/models/store.dart';
import 'package:meta/meta.dart';

part 'stores_event.dart';
part 'stores_state.dart';

class StoresBloc extends Bloc<StoresEvent, MasterState> {
  StoresBloc() : super(StoresInitial());
  StoreRepository storeRepository = StoreRepository();
  @override
  Stream<MasterState> mapEventToState(
    StoresEvent event,
  ) async* {
    if (event is GetStoresData) {
      yield ShowLoading();
      try {
        await storeRepository.getItemData();
        if (storeRepository.items.length == 0) {
          yield NOData();
        } else {
          yield ShowStores(storeRepository.items);
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
  }
}
