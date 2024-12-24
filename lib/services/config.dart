import 'package:dio/dio.dart';

class Config {
  // Dio örneği
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://fakestoreapi.com/',
      connectTimeout: const Duration(seconds: 30), 
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  )..interceptors.addAll([
      // Request interceptor
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('🟡 Request: [${options.method}] ${options.uri}');
          // options.headers['Authorization'] = 'Bearer <TOKEN>';
          return handler.next(options);
        },
      ),

      // Response interceptor
      InterceptorsWrapper(
        onResponse: (response, handler) {
          print('🟢 Response [${response.statusCode}]: ${response.data}');
          return handler.next(response);
        },
      ),

      // Error interceptor
      InterceptorsWrapper(
        onError: (error, handler) {
          print('🔴 Dio Error: ${error.message}');
          if (error.response != null) {
            print('🔴 Response Data: ${error.response?.data}');
          }
          return handler.next(error);
        },
      ),
    ]);
}
