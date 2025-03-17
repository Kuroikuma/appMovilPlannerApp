import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(String baseUrl)
      : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            contentType: 'application/json',
            responseType: ResponseType.json,
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
            sendTimeout: const Duration(seconds: 30),
            // Agregando headers CORS
            headers: {
              'Accept': 'application/json',
              'Access-Control-Allow-Origin': '*',
            },
          ),
        ) {
    // Agregando interceptor para logs
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
    ));
  }

  Future<Response> get(String path) async {
    try {
      print('Intentando GET request a: ${_dio.options.baseUrl}$path');
      final response = await _dio.get(path);
      print('Response exitosa: ${response.statusCode}');
      return response;
    } on DioException catch (e) {
      print('Error en GET request:');
      print('Type: ${e.type}');
      print('Message: ${e.message}');
      print('URL: ${e.requestOptions.uri}');
      rethrow;
    }
  }

  Future<Response> post(String path, {dynamic data}) async {
    try {
      print('Intentando POST request a: ${_dio.options.baseUrl}$path');
      final response = await _dio.post(path, data: data);
      print('Response exitosa: ${response.statusCode}');
      return response;
    } on DioException catch (e) {
      print('Error en POST request:');
      print('Type: ${e.type}');
      print('Message: ${e.message}');
      print('URL: ${e.requestOptions.uri}');
      rethrow;
    }
  }
}
