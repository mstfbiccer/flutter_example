import 'package:flutter/material.dart';
import 'package:flutter_example/layouts/main_layout.dart';
import 'package:flutter_example/providers/theme_provider.dart';
import 'package:flutter_example/providers/auth_provider.dart';
import 'package:flutter_example/screens/login.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final authProvider = AuthProvider();
  await authProvider.loadToken();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => authProvider),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    print('Token: ${authProvider.token}');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce App',
      theme: themeProvider.currentTheme,
      home: authProvider.isAuthenticated
          ? const MainLayout()
          : const LoginScreen(),
    );
  }
}
