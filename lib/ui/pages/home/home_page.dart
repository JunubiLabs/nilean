import 'package:buai/main.dart';
import 'package:buai/ui/pages/home/main_section.dart';
import 'package:buai/ui/pages/home/recent_chats.dart';
import 'package:buai/ui/pages/home/recommended_news.dart';
import 'package:buai/ui/widgets/header.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

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

  handleMessage() async {
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      handleMessageNotification(initialMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
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
    );
  }
}
