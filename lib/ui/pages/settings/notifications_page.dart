import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:nilean/ui/widgets/app_buttons.dart';
import 'package:nilean/ui/widgets/app_texts.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  String info = """
**"To turn on or off notifications for this app, go to your device's Settings > Apps > [App Name] > Notifications. Alternatively, you can also access notification settings from within the app by navigating to Settings > Notifications."**
""";
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
              AppButtons.backButton(onPressed: () {
                Navigator.pop(context);
              }),
              const SizedBox(height: 20),
              AppTexts.sectionTitle(
                title: 'Notifications',
                subtitle: '',
                context: context,
              ),
              const SizedBox(height: 20),
              MarkdownBody(data: info),
            ],
          ),
        ),
      ),
    );
  }
}
