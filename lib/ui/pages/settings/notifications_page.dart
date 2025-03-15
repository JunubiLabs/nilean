import 'package:flutter/material.dart';
import 'package:nilean/ui/widgets/app_buttons.dart';
import 'package:nilean/ui/widgets/app_texts.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool isNotificationsOn = true;
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
              AppButtons.backButton(onPressed: () {}),
              const SizedBox(height: 20),
              AppTexts.sectionTitle(
                title: 'Notifications',
                subtitle: '',
                context: context,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Turn on Notifications'),
                  Transform.scale(
                    scale: 0.5,
                    child: Switch(
                      value: isNotificationsOn,
                      onChanged: (onChanged) {
                        setState(() => isNotificationsOn = !isNotificationsOn);
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
