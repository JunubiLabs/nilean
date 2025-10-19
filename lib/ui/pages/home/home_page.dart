import 'package:nilean/main.dart';
import 'package:nilean/ui/pages/home/main_section.dart';
import 'package:nilean/ui/pages/home/recent_chats.dart';
import 'package:nilean/ui/pages/home/recommended_news.dart';
import 'package:nilean/ui/widgets/header.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    handleMessage();
  }

  Future<void> handleMessage() async {
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      showOerlay(true); // Show the loading overlay
      await handleMessageNotification(initialMessage);
      showOerlay(false); // Hide the loading overlay
    }
  }

  void showOerlay(bool show) {
    show ? context.loaderOverlay.show() : context.loaderOverlay.hide();
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppHeader(),
                const SizedBox(height: 20),
                MainSection(),
                const SizedBox(height: 25),
                RecommendedNews(),
                const SizedBox(height: 25),
                RecentChats(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
