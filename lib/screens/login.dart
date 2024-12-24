import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: LoginContent()),
    );
  }
}

class LoginContent extends StatelessWidget {
  const LoginContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: 
        [
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Kullanıcı Adı',
            ),
          ),
          TextField(
              obscureText: true,
              decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Parola',
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Giriş Yap'),
          ),
        ],
      ),
    );
  }
}
