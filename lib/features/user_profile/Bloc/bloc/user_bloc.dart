import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:human_resources/base/bloc/master_state.dart';
import 'package:human_resources/base/error/error.dart';
import 'package:human_resources/features/user_profile/repository/user_repository.dart';
import 'package:human_resources/models/user.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, MasterState> {
  UserBloc() : super(UserInitial());

  UserRepository _repository = UserRepository();

  @override
  Stream<MasterState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is GetUserInfo) {
      yield ShowLoading();
      try {
        bool error = await _repository.getUserInfoFromDB();
        print(error);
        if (error == false) {
          yield NOData();
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
    } else if (event is CheckCurrentPassword) {
      yield ShowLoading();
      try {
        bool error = await _repository.checkUserPassword(event.password);
        print(error);
        if (error == true) {
          yield NOData();
        } else {
          yield ConformPassword();
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
        bool error = await _repository.getUserNewPassword(event.password);
        print(error);
        if (error == false) {
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
    } else if (event is UploadImage) {
      yield ShowLoading();
      try {
        bool error = await _repository.uploadUserImage(event.file);
        print(error);
        if (error == false) {
          yield NOData();
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
    }
  }
}
