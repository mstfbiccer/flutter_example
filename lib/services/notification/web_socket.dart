import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketListener {
  final String url;
  late WebSocketChannel _channel;
  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  bool _connected = false;

  WebSocketListener({required this.url});

  void init() {
    initializeNotificationChannel();
  }

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

void connect({
  Function(String)? onMessage,
  Function(dynamic)? onError,
  Function()? onDone,
}) {
  if (_connected) {
    print('WebSocket already connected.');
    return;
  }

  try {
    _channel = WebSocketChannel.connect(Uri.parse(url));
    _connected = true;

    print('WebSocket connected.');

    _channel.stream.listen(
      (message) {
        print('Received: $message');
        if (message != null && message.isNotEmpty) {
          _showNotification('New Message', message);
          onMessage?.call(message);
        } else {
          print('Empty or null message received.');
        }
      },
      onError: (error) {
        print('WebSocket Error: $error');
        onError?.call(error);
      },
      onDone: () {
        print('WebSocket connection closed.');
        _connected = false;
        reconnect();
        onDone?.call();
      },
      cancelOnError: false, // Dinleme devam etsin
    );
  } catch (e) {
    print('Failed to connect: $e');
    onError?.call(e);
  }
}

  void reconnect() {
    print('Reconnecting...');
    disconnect();
    Future.delayed(Duration(seconds: 5), () {
      connect();
    });
  }

  void disconnect() {
    if (!_connected) {
      print('WebSocket is not connected.');
      return;
    }
    _channel.sink.close();
    _connected = false;
    print('WebSocket disconnected.');
  }

  bool get isConnected => _connected;
}
