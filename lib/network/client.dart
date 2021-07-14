import 'package:dio/dio.dart';

class Client {
  Dio _dio = Dio();
  String _baseurl = 'movi.amwajco.net/index.php/api';

  void init() {
    _dio.options.baseUrl = _baseurl;
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, handler) =>
            requestInterceptor(options),
        onResponse: (Response response, handler) =>
            responseInterceptor(response),
        onError: (DioError error, handler) => errorInterceptor(error),
      ),
    );
  }

  requestInterceptor(RequestOptions options) {
    return options;
  }

  responseInterceptor(Response response) {
    return response;
  }

  errorInterceptor(DioError error) {
    return error;
  }

  Future<Response> get(String url) async {
    late Response response;
    try {
      response = await _dio.get("$_baseurl$url");
      return response;
    } on DioError catch (e) {
      // Handle error
      print(e);
    }
    return response;
  }

  Future<Response> post(String url, Map<String, dynamic> data) async {
    late Response response;
    try {
      FormData formData = FormData.fromMap(data);
      response = await _dio.post("$_baseurl$url", data: formData);
      return response;
    } on DioError catch (e) {
      // Handle error
      print(e);
    }
    return response;
  }

  Future<Response> delete(String url, dynamic data) async {
    late Response response;
    try {
      response = await _dio.delete("$_baseurl$url", data: data);
      return response;
    } on DioError catch (e) {
      // Handle error
      print(e);
    }
    return response;
  }

  Future<Response> put(String url, dynamic data) async {
    late Response response;
    try {
      response = await _dio.put("$_baseurl$url", data: data);
      return response;
    } on DioError catch (e) {
      // Handle error
      print(e);
    }
    return response;
  }
}
