import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:human_resources/base/bloc/master_state.dart';
import 'package:meta/meta.dart';

part 'base_event.dart';
part 'base_state.dart';

class BaseBloc extends Bloc<BaseEvent, MasterState> {
  BaseBloc(MasterState initialState) : super(initialState);

  @override
  Stream<MasterState> mapEventToState(
    BaseEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
