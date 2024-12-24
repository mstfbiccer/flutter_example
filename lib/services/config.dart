  import 'package:dio/dio.dart';
  class Config {
    static final Dio dio = Dio(BaseOptions(
      baseUrl: 'https://fakestoreapi.com/products'
    ));
  }

