import 'package:dio/dio.dart';


class DioHelper {
  static Dio? dio;

  static initialDio() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {'Content-Type': 'application/json'},
      ),
    );
  }

  static Future<Response> post({
    required String method,
    required Map data,
    Map<String, dynamic>? parameters,
    Map<String, dynamic>? headers,
  }) async {
    dio!.options.headers = headers;
    return await dio!.post(
      method,
      data: data,
      queryParameters: parameters,
    );
  }

  static Future<Response> get({
    required String path,
    Map<String, dynamic>? parameters,
    Map<String, dynamic>? headers,
  }) async {
    dio!.options.headers = headers;
    return await dio!.get(
      path,
      queryParameters: parameters,
    );
  }

  static Future<Response> put({
    required String path,
    Map<String, dynamic>? headers,
    required Map<String, dynamic> data,
  }) async {
    dio!.options.headers = headers;
    return await dio!.put(
      path,
      data: data,
    );
  }
}
