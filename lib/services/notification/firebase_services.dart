import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_example/firebase_options.dart';

class FirebaseService {
  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initializeFirebase() async {
    // Firebase'i başlat
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Arka plan mesajları için handler tanımla
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Bildirim kanalı oluştur
    await initializeNotificationChannel();

    // Token al ve ekrana yazdır
    final token = await getToken();
    print("Firebase Messaging Token: $token");
  }

  // Arka plan mesajları için handler
  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    print("Handling a background message: ${message.messageId}");
  }

  // Firebase token alma
  static Future<String?> getToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    print("Firebase Messaging Token: $token");
    return token;
  }

  // Foreground mesajlarını dinle
  static void listenToMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Foreground message received: ${message.notification?.title}');

      // Yerel bildirim tetikle
      _showNotification(
        message.notification?.title ?? 'No Title',
        message.notification?.body ?? 'No Body',
      );
    });
  }

  // Yerel bildirim gösterme
static Future<void> _showNotification(String title, String body) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'default_notification_channel', // Kanal ID'si
    'Genel Bildirimler', // Kanal Adı
    channelDescription: 'Uygulamanız için genel bildirimler.', // Kanal Açıklaması
    importance: Importance.max, // Bildirimin önceliği
    priority: Priority.high, // Bildirimin öncelik sırası
    showWhen: true, // Gönderim zamanı gösterilsin
    icon: '@mipmap/ic_launcher', // Doğru bir simge tanımlayın
  );

  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await _localNotificationsPlugin.show(
    0, // Bildirim ID'si
    title,
    body,
    platformChannelSpecifics,
  );
}


  // Bildirim kanalı oluşturma
  static Future<void> initializeNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'default_notification_channel', // Kanal ID'si
      'Genel Bildirimler', // Kanal Adı
      description: 'Uygulamanız için genel bildirimler.', // Kanal Açıklaması
      importance: Importance.max,
    );

    await _localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    print('Notification channel created!');
  }
}
