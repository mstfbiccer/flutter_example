import 'package:flutter_example/services/config.dart';

class FetchProducts {
  static Future<Map<String, dynamic>> productById(int productId) async {

      try {
        final response = await Config.dio.get('photos/2');
        return response.data;
      } catch (e) {
        throw Exception('Ürünler alınamadı: $e');
      }
    }
}