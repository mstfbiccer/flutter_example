import 'package:flutter_example/services/config.dart';

class FetchProducts {
  static Future<Map<String, dynamic>> productById(int productId) async {
      try {
        final response = await Config.dio.get('/products/$productId');
        return response.data;
      } catch (e) {
        throw Exception('Ürünler alınamadı: $e');
      }
    }

  static Future<List<Map<String, dynamic>>> products() async {
    try {
      final response = await Config.dio.get('/products');
      return List<Map<String, dynamic>>.from(response.data);
    } catch (e) {
      throw Exception('Ürünler alınamadı: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> productsByCategory(int categoryId) async {
    try {
      final response = await Config.dio.get('/products?category=$categoryId');
      return List<Map<String, dynamic>>.from(response.data);
    } catch (e) {
      throw Exception('Ürünler alınamadı: $e');
    }
  }
}