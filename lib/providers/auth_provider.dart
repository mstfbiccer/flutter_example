import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String? _token;

  String? get token => _token;

  bool get isAuthenticated => _token != null;

  Future<void> setToken(String token) async {
    _token = token;
    notifyListeners();

    // Token'ı SharedPreferences ile sakla
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('auth_token');
    notifyListeners();
  }

  Future<void> clearToken() async {
    _token = null;
    notifyListeners();

    // Token'ı SharedPreferences'tan sil
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }
}
