import 'package:flutter_example/services/config.dart';

class Login {
  // Login işlemi
  static Future<String> login(String username, String password) async {
    try {
      final response = await Config.dio.post(
        '/auth/login',
        data: {
          'username': username,
          'password': password,
        },
      );

      // API'den dönen token'ı al
      if (response.statusCode == 200) {
        final token = response.data['token'];
        return token; // Başarılı girişte token döndür
      } else {
        throw Exception('Giriş başarısız: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Login sırasında hata oluştu: $e');
    }
  }
}
