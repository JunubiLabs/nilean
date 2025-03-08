import 'package:buai/app.dart';
import 'package:buai/gemini_options.dart';
import 'package:buai/models/chat_content_model.dart';
import 'package:buai/models/chat_model.dart';
import 'package:buai/repositories/news_repository.dart';
import 'package:buai/services/firebase_notification_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';

final firebaseNotificationServices = FirebaseNotificationServices();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await firebaseNotificationServices.initializeNotifications(
    handler: firebaseMessagingBackgroundHandler,
    onNotificationTap: onNotificationTap,
    handleMessageNotification: handleMessageNotification,
  );

  await FirebaseMessaging.instance.subscribeToTopic('articles');

  Gemini.init(apiKey: GeminiOptions.googleApiKey);

  await Hive.initFlutter();

  Hive.registerAdapter(ChatModelAdapter());
  Hive.registerAdapter(ChatContentModelAdapter());

  runApp(const App());
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

onNotificationTap(NotificationResponse notificationResponse) {
  if (notificationResponse.payload != null) {
    final payload = notificationResponse.payload!;
    NewsRepository().fetchNewsByUrl(url: payload).then((news) {
      App.navigatorKey.currentState!.pushNamed(
        '/article',
        arguments: news,
      );
    });
  }
}

handleMessageNotification(RemoteMessage message) async {
  if (message.notification != null) {
    final news = await NewsRepository().fetchNewsByUrl(
      url: message.data['url'],
    );
    navigatorKey.currentState!.pushNamed(
      '/article',
      arguments: news,
    );
  }
}
