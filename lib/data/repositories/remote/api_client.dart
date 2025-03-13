import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(String baseUrl)
    : _dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      );

  Future<Response> get(String path) => _dio.get(path);

  Future<Response> post(String path, {dynamic data}) =>
      _dio.post(path, data: data);
}
