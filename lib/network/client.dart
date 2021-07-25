import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';

// class RetryOnConnectionChangeInterceptor extends Interceptor {
//   final DioConnectivityRequestRetrier requestRetrier;

//   RetryOnConnectionChangeInterceptor({
//     @required this.requestRetrier,
//   });

//   @override
//   Future onError(DioError err) async {
//     if (_shouldRetry(err)) {
//       try {
//         return requestRetrier.scheduleRequestRetry(err.request);
//       } catch (e) {
//         // Let any new error from the retrier pass through
//         return e;
//       }
//     }
//     // Let the error pass through if it's not the error we're looking for
//     return err;
//   }

bool _shouldRetry(DioError err) {
  return err.type == DioErrorType.other &&
      err.error != null &&
      err.error is SocketException;
}

class Client {
  Dio _dio = Dio();
  String _baseurl = 'https://movi.amwajco.net/index.php/api';

  void init() {
    // _dio.options.baseUrl = _baseurl;
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, handler) =>
            requestInterceptor(options),
        onResponse: (Response response, handler) =>
            responseInterceptor(response),
        onError: (DioError error, handler) => errorInterceptor(error),
      ),
    );
    BaseOptions options = new BaseOptions(
        baseUrl: _baseurl,
        receiveDataWhenStatusError: true,
        connectTimeout: 60 * 1000, // 60 seconds
        receiveTimeout: 60 * 1000 // 60 seconds
        );
    _dio.options = options;
  }

  requestInterceptor(RequestOptions options) {
    return options;
  }

  responseInterceptor(Response response) {
    return response;
  }

  errorInterceptor(DioError error) {
    // if (_shouldRetry(error)) {
    //   try {
    //     return DioConnectivityRequestRetrier(
    //       dio: _dio,
    //       connectivity: Connectivity(),
    //     ).scheduleRequestRetry(error.requestOptions);
    //   } catch (e) {
    //     // Let any new error from the retrier pass through
    //     return e;
    //   }
    // }
    // Let the error "pass through" if it's not the error we're looking for
    // return err;
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
      var dio = Dio(
        BaseOptions(
          baseUrl: _baseurl,
          connectTimeout: 5 * 1000, // 5 seconds
          receiveTimeout: 3 * 1000,
        ),
      );
      response = await dio.post("$url", data: formData);
      return response;
    } on DioError catch (e) {
      // throw SocketException(e.toString());
      if (e.type == DioErrorType.connectTimeout) {
        throw Exception("Connection  Timeout Exception");
      }
      if (e.type == DioErrorType.other) {
        throw Exception("Connection Exception");
      }
      throw Exception(e.message);
    }
    // return response;
  }

  Future<Response> postImage(String url, Map<String, dynamic> data) async {
    late Response response;
    try {
      String fileName = data['cont'].path.split('/').last;
      FormData formData = FormData.fromMap({
        "authkey": data['authkey'],
        "devid": data['devid'],
        "cont":
            await MultipartFile.fromFile(data['cont'].path, filename: fileName),
      });
      var dio = Dio();
      response = await _dio.post("$url", data: formData);
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
