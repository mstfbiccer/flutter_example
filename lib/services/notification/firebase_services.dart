import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_example/firebase_options.dart';

class FirebaseService {
  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    print("Handling a background message: ${message.messageId}");
  }

  static Future<String?> getToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    print("Firebase Messaging Token: $token");
    return token;
  }

  static void listenToMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Foreground message received: ${message.notification?.title}');
    });
  }
}
