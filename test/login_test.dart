import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter_example/providers/auth_provider.dart';
import 'package:flutter_example/screens/login.dart';
import 'package:flutter_example/layouts/main_layout.dart';

void main() {
  group('LoginScreen Tests', () {
    late AuthProvider authProvider;

    setUp(() {
      authProvider = AuthProvider();
    });

    testWidgets('Successful login redirects to MainLayout', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => authProvider),
          ],
          child: const MaterialApp(
            home: LoginScreen(),
          ),
        ),
      );

      // Verify initial state
      expect(find.text('Kullanıcı Adı'), findsOneWidget);
      expect(find.text('Şifre'), findsOneWidget);
      expect(find.text('Giriş Yap'), findsOneWidget);

      // Simulate user input
      await tester.enterText(find.byType(TextField).at(0), 'mor_2314');
      await tester.enterText(find.byType(TextField).at(1), '83r5^_');

      // Simulate button press
      await tester.tap(find.text('Giriş Yap'));
      await tester.pumpAndSettle();

      // Verify navigation to MainLayout
      expect(find.byType(MainLayout), findsOneWidget);
    });
  });
}
