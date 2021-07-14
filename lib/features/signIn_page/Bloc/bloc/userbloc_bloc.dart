import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:human_resources/base/bloc/master_state.dart';
import 'package:meta/meta.dart';

part 'userbloc_event.dart';
part 'userbloc_state.dart';

class UserblocBloc extends Bloc<UserblocEvent, MasterState> {
  UserblocBloc() : super(UserblocInitial());

  @override
  Stream<MasterState> mapEventToState(
    UserblocEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
