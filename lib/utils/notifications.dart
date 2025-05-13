import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings(
          '@mipmap/ic_launcher'), // Utilizamos la app icon predeterminada
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> showNotification(
      int id, String title, String body) async {
    const notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'channel_id', // Identificador de canal de notificación
        'channel_name', // Nombre del canal
        importance: Importance.max, // Importancia de la notificación
        priority: Priority.high, // Prioridad alta
      ),
    );
    await flutterLocalNotificationsPlugin.show(
        id, title, body, notificationDetails);
  }
}
