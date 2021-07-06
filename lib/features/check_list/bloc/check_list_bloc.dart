import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:human_resources/base/bloc/master_state.dart';
import 'package:human_resources/base/error/error.dart';
import 'package:human_resources/features/check_list/repository/item_repository.dart';
import 'package:human_resources/models/check_item.dart';
import 'package:meta/meta.dart';

part 'check_list_event.dart';
part 'check_list_state.dart';

class CheckListBloc extends Bloc<CheckListEvent, MasterState> {
  CheckListBloc() : super(CheckListInitial());

  ItemRepository itemRepository = ItemRepository();

  @override
  Stream<MasterState> mapEventToState(
    CheckListEvent event,
  ) async* {
    if (event is GetItemData) {
      yield ShowLoading();
      try {
        await itemRepository.getItemData();
        if (itemRepository.items.length == 0) {
          yield NOData();
        } else {
          yield ShowItems(items: itemRepository.items);
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
    } else if (event is GetSearchedData) {
      yield ShowLoading();
      try {
        await itemRepository.getItemData();
        if (itemRepository.items.length == 0) {
          yield NOData();
        } else {
          yield ShowSearchedItems(itemRepository.items);
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
