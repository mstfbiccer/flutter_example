import 'package:flutter/material.dart';
import 'package:flutter_example/layouts/main_layout.dart';
import 'package:flutter_example/providers/auth_provider.dart';
import 'package:flutter_example/services/auth/login.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final token = await Login.login(
        _usernameController.text.trim(),
        _passwordController.text.trim(),
      );

      // Token başarılıysa veriyi AuthProvider'a kaydet
      Provider.of<AuthProvider>(context, listen: false).setToken(token);
      print('Token: $token');
      // Ana ekrana yönlendir
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainLayout()),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Bilgileriniz doğru değil. Lütfen tekrar deneyin.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Kullanıcı Adı',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Şifre',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            if (_errorMessage != null) ...[
              Text(
                "Bilgileriniz Doğru Değil. Lütfen Tekrar Deneyin.",
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 16.0),
            ],
            ElevatedButton(
              onPressed: _isLoading ? null : _handleLogin,
              child: _isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Text('Giriş Yap'),
            ),
          ],
        ),
      ),
    );
  }
}
