import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:human_resources/base/bloc/master_state.dart';
import 'package:human_resources/base/error/error.dart';
import 'package:human_resources/features/signIn_page/repository/user_auth_repo.dart';
import 'package:human_resources/models/user.dart';
import 'package:human_resources/models/user_auth.dart';
import 'package:meta/meta.dart';

part 'userAuth_event.dart';
part 'userAuth_state.dart';

class UserAuthblocBloc extends Bloc<UserAuthblocEvent, MasterState> {
  UserAuthblocBloc() : super(UserAuthblocInitial());

  UserAuthRepository _repository = UserAuthRepository();

  @override
  Stream<MasterState> mapEventToState(
    UserAuthblocEvent event,
  ) async* {
    if (event is CheckUserInfo) {
      yield ShowLoading();
      try {
        String error =
            await _repository.getUserInfo(event.email, event.password);
        print(error);
        if (error == 'true') {
          yield NOData();
        } else if (error == 'connection error') {
          yield ConnectionError();
        } else {
          yield ShowUserInfo(user: _repository.user);
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
    } else if (event is GetNewPassword) {
      yield ShowLoading();
      try {
        bool done = await _repository.getUserPassword(event.email);
        if (done == false) {
          yield NOData();
        } else {
          yield NewPassword();
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
