import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_example/layouts/main_layout.dart';
import 'package:flutter_example/providers/auth_provider.dart';
import 'package:flutter_example/services/auth/login.dart';
import 'package:flutter_example/services/database/crud.dart';
import 'package:flutter_example/services/database/orm.dart';
import 'package:provider/provider.dart';
import 'package:local_auth/local_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _isAuthenticated = false;

  // usernamecontroller with default value
  final TextEditingController _usernameController = TextEditingController(text: 'mor_2314');
  final TextEditingController _passwordController = TextEditingController(text: '83r5^_');
  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 2));
  bool _isLoading = false;
  String? _errorMessage;

  final AppDb _database = AppDb(); // Veritabanı nesnesini oluşturduk

Future<void> _authenticate() async {
  try {
    // Check for available biometric types
    final List<BiometricType> availableBiometrics =
        await _localAuth.getAvailableBiometrics();

    if (availableBiometrics.contains(BiometricType.face)) {
      // Face/iris recognition supported
      print("Göz ve yüz tanıma mevcut.");
    } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
      // Fingerprint supported
      print("Parmak izi tanıma mevcut.");
    } else {
      // No biometrics available
      print("Biometrik tanıma mevcut değil.");
    }

    // Authenticate using available biometrics
    final bool authenticated = await _localAuth.authenticate(
      localizedReason: 'Lütfen kimlik doğrulaması yapın.',
      
      options: const AuthenticationOptions(
        biometricOnly: true,
        stickyAuth: true,
      ),
    );

    setState(() {
      _isAuthenticated = authenticated;
    });

    if (authenticated) {
      // Add any additional success logic here
      print("Authenticated successfully!");
    } else {
      print("Authentication failed.");
    }
  } catch (e) {
    print("Authentication error: $e");
  }
}

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confettiController.dispose();
    _database.close(); // Veritabanını kapatmayı unutma
    super.dispose();
  }



  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Kullanıcıyı doğrula
      final token = await Login.login(
        _usernameController.text.trim(),
        _passwordController.text.trim(),
      );

      // Kullanıcı bilgilerini Drift'e kaydet
      await _database.insertUser(_usernameController.text.trim());

      // Token başarılıysa veriyi AuthProvider'a kaydet
      Provider.of<AuthProvider>(context, listen: false).setToken(token);

      // Konfeti patlat
      _confettiController.play();

      // Ana ekrana yönlendir
      Future.delayed(const Duration(seconds: 2), () {
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainLayout()),
          );
        }
      });
    } catch (e) {
      print(e);
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
      body: Stack(
        children: [
          Padding(
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
                    _errorMessage!,
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
                ElevatedButton(
                    onPressed: _authenticate,
                    child: const Text('Parmak İzi ile Giriş Yap')),
              ],
            ),
          ),
          // Confetti widget
          Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                Colors.red,
                Colors.blue,
                Colors.green,
                Colors.yellow
              ],
            ),
          ),
        ],
      ),
    );
  }
}
