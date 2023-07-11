import 'package:dio/dio.dart';

class ApiService {
  static late Dio _dio;

  static init() {
    _dio = Dio(BaseOptions(
      baseUrl: 'http://54.90.160.187:8000/api/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
    required String url,
    String? token,
  }) async {
    _dio.options.headers['Authorization'] = 'token $token';
    return await _dio.get(
      url,
    );
  }

  static Future<Response?> postData({
    required String url,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    _dio.options.headers['Authorization'] = 'token $token';
    return _dio.post(
      url,
      data: data,
    );
  }

  static Future<Response?> deleteData({
    required String url,
    String? token,
  }) async {
    _dio.options.headers['Authorization'] = 'token $token';
    return _dio.delete(url);
  }
}
