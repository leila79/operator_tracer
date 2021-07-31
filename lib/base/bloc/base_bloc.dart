import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:human_resources/base/bloc/master_state.dart';
import 'package:human_resources/base/error/error.dart';
import 'package:human_resources/database/models/user_db.dart';
import 'package:human_resources/models/user.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'base_event.dart';
part 'base_state.dart';

class BaseBloc extends Bloc<BaseEvent, MasterState> {
  BaseBloc() : super(InitialMasterState());

  Future<User> getUserInfo() async {
    var loginData = await SharedPreferences.getInstance();
    return User(
      loginData.getString('status')!,
      loginData.getString('id')!,
      loginData.getString('email')!,
      loginData.getString('name')!,
      loginData.getString('img')!,
    );
  }

  Future<User> getUserInfofromDB() async {
    // var loginData = await SharedPreferences.getInstance();
    final Box<UserDB> userBox = Hive.box('user');
    UserDB userDB = userBox.getAt(0)!;
    return User(
      userDB.status,
      userDB.id,
      userDB.email,
      userDB.name,
      userDB.img,
    );
  }

  @override
  Stream<MasterState> mapEventToState(
    BaseEvent event,
  ) async* {
    if (event is GetUserInfo) {
      yield ShowLoading();
      try {
        // User user = await getUserInfo();
        User user = await getUserInfofromDB();
        if (user.name == '') {
          yield NOData();
        } else {
          yield ShowUserInfo(
              name: user.name, email: user.email, avatar: user.img);
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
