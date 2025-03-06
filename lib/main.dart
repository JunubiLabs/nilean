import 'package:buai/app.dart';
import 'package:buai/gemini_options.dart';
import 'package:buai/models/chat_content_model.dart';
import 'package:buai/models/chat_model.dart';
import 'package:buai/services/firebase_notification_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:hive_flutter/hive_flutter.dart';

final firebaseNotificationServices = FirebaseNotificationServices();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await firebaseNotificationServices.initializeNotifications(
    handler: firebaseMessagingBackgroundHandler,
  );

  await FirebaseMessaging.instance.subscribeToTopic('new_articles');

  Gemini.init(apiKey: GeminiOptions.googleApiKey);

  await Hive.initFlutter();

  Hive.registerAdapter(ChatModelAdapter());
  Hive.registerAdapter(ChatContentModelAdapter());

  runApp(const App());
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  firebaseNotificationServices.showFlutterNotification(message);
}
