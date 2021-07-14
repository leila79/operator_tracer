import 'package:dio/dio.dart';
import 'client.dart';

class UserApi {
  late Dio dio;
  Client client = Client();

  UserApi() {
    client.init();
  }

  Future<Response> Authenticate(
      String email, String password, String devid, String devmodel) async {
    return await client.post('/authenticate', {
      'email': email,
      'password': password,
      'devid': devid,
      'devmodel': devmodel,
      'verapp': 1,
    });
  }

  Future<Response> fetchUserInfo(int token, String devid) async {
    return await client.post('/getUserInfo', {
      'authkey': token,
      'devid': devid,
    });
  }

  // Future<Response> add(Dio dio, Map<String, dynamic> data) {
  //   return dio.post("/data/frameworks", data: data);
  // }

  // Future<Response> delete(Dio dio, String objectId) {
  //   return dio.delete("/data/frameworks/$objectId");
  // }

  // Future<Response> update(Dio dio, String objectId, Map<String, dynamic> data) {
  //   return dio.put("/data/frameworks/$objectId", data: data);
  // }

  // Future<Response> postImage(Dio dio, String path, String fileName) {
  //   // https://api.backendless.com/<application-id><REST-api-key>/files/<path>/<filename>?overwrite=true
  //   return dio.post("/files/$path/$fileName?overwrite=true");
  // }
}
