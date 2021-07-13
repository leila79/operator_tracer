import 'package:dio/dio.dart';

class Client {
  Dio init() {
    Dio _dio = Dio();
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, handler) =>
            requestInterceptor(options),
        onResponse: (Response response, handler) =>
            responseInterceptor(response),
        onError: (DioError error, handler) => errorInterceptor(error),
      ),
    );
    _dio.options.baseUrl = 'movi.amwajco.net/index.php/api';
    return _dio;
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
}
