import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class FirebaseNotificationServices {
  Future<void> initializeNotifications({
    required Future<void> Function(RemoteMessage) handler,
    required onNotificationTap,
    required handleMessageNotification,
  }) async {
    const initializationSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: DarwinInitializationSettings(),
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onNotificationTap,
      onDidReceiveBackgroundNotificationResponse: onNotificationTap,
    );

    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    FirebaseMessaging.onBackgroundMessage(handler);
    FirebaseMessaging.onMessage.listen(showFlutterNotification);

    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      handleMessageNotification(initialMessage);
    }
  }

  void showFlutterNotification(RemoteMessage message) {
    final notification = message.notification;
    if (notification != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'channel_id',
            'New Articles',
            channelDescription: 'Channel for new article notifications',
            importance: Importance.max,
            priority: Priority.high,
            styleInformation: BigPictureStyleInformation(
              FilePathAndroidBitmap(message.data['imageUrl']),
              contentTitle: message.notification!.title,
              htmlFormatContentTitle: true,
              summaryText: message.notification!.body,
            ),
          ),
          iOS: const DarwinNotificationDetails(),
        ),
        payload: message.data['url'],
      );
    }
  }
}
