import 'package:dio/dio.dart';

Future<Response> fetchAll(Dio dio) {
  return dio.get("/data/items");
}

Future<Response> fetch(Dio dio, String objectId) {
  return dio.get("/data/frameworks/$objectId");
}

Future<Response> add(Dio dio, Map<String, dynamic> data) {
  return dio.post("/data/frameworks", data: data);
}

Future<Response> delete(Dio dio, String objectId) {
  return dio.delete("/data/frameworks/$objectId");
}

Future<Response> update(Dio dio, String objectId, Map<String, dynamic> data) {
  return dio.put("/data/frameworks/$objectId", data: data);
}

Future<Response> postImage(Dio dio, String path, String fileName) {
// https://api.backendless.com/<application-id><REST-api-key>/files/<path>/<filename>?overwrite=true
  return dio.post("/files/$path/$fileName?overwrite=true");
}
