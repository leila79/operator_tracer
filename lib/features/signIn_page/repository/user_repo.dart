import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:human_resources/database/items_db.dart';
import 'package:human_resources/models/check_item.dart';
import 'package:human_resources/models/user.dart';
import 'package:human_resources/models/user_auth.dart';
import 'package:human_resources/network/check_item_api.dart';
import 'package:human_resources/network/client.dart';
import 'package:human_resources/network/local.dart';
import 'package:human_resources/network/user_api_provider.dart';

class UserRepository {
  late UserAuth userAuth;
  late User user;
  late Dio client;

  Future<User> getUserInfo(String email, String password) async {
    Response res =
        await UserApi().Authenticate(email, password, devid, devmodel);
    userAuth = UserAuth.fromJson(res.data);

    Response userres = await UserApi().fetchUserInfo(userAuth.t, devid);
    user = User.fromJson(userres.data);
    return user;
  }
}
