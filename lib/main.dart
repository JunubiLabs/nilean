import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:nilean/app.dart';
import 'package:nilean/gemini_options.dart';
import 'package:nilean/models/chat_content_model.dart';
import 'package:nilean/models/chat_model.dart';
import 'package:nilean/models/user_model.dart';
import 'package:nilean/repositories/news_repository.dart';
import 'package:nilean/services/firebase_notification_services.dart';
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

  if (await InternetConnectionChecker.instance.hasConnection) {
    await FirebaseMessaging.instance.subscribeToTopic('news_titles');
  }

  await firebaseNotificationServices.initializeNotifications(
    handler: firebaseMessagingBackgroundHandler,
    onNotificationTap: onNotificationTap,
    handleMessageNotification: handleMessageNotification,
  );

  await FirebaseAppCheck.instance.activate();

  checkForUpdate();
  Gemini.init(apiKey: GeminiOptions.googleApiKey);

  await Hive.initFlutter();

  Hive.registerAdapter(ChatModelAdapter());
  Hive.registerAdapter(ChatContentModelAdapter());
  Hive.registerAdapter(UserModelAdapter());

  runApp(const App());
}

void checkForUpdate() async {
  try {
    final updateInfo = await InAppUpdate.checkForUpdate();
    if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
      await InAppUpdate.startFlexibleUpdate();
      // Optionally, call InAppUpdate.completeFlexibleUpdate() later
    }
  } catch (e) {
    // Handle error if needed
  }
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.subscribeToTopic('news_titles');
}

void onNotificationTap(NotificationResponse notificationResponse) {
  if (notificationResponse.payload != null) {
    final payload = notificationResponse.payload!;
    NewsRepository().fetchNewsByUrl(url: payload).then((news) {
      App.navigatorKey.currentState!.pushNamed('/article', arguments: news);
    });
  }
}

Future<void> handleMessageNotification(RemoteMessage message) async {
  if (message.notification != null) {
    final news = await NewsRepository().fetchNewsByUrl(
      url: message.notification?.android?.imageUrl ?? '',
    );
    await Future.delayed(const Duration(milliseconds: 500));
    if (!App.navigatorKey.currentState!.mounted) return;
    App.navigatorKey.currentState!.pushNamed('/article', arguments: news);
  }
}
