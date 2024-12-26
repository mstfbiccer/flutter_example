import 'package:flutter/material.dart';
import 'package:flutter_example/layouts/main_layout.dart';
import 'package:flutter_example/providers/theme_provider.dart';
import 'package:flutter_example/providers/auth_provider.dart';
import 'package:flutter_example/screens/login.dart';
import 'package:flutter_example/services/notification/firebase_services.dart';
import 'package:flutter_example/services/notification/web_socket.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.initializeFirebase();

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
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late WebSocketListener webSocketListener;

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    webSocketListener.disconnect();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    FirebaseService.getToken();
    FirebaseService.listenToMessages();
    print('Token: ${authProvider.token}');
    webSocketListener = WebSocketListener(url: 'wss://ws.postman-echo.com/raw');
    webSocketListener.connect();

    print("WebSocket called: ${webSocketListener.isConnected}");

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
