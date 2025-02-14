import 'package:buai/ui/widgets/app_texts.dart';
import 'package:flutter/material.dart';

class RecentChats extends StatefulWidget {
  const RecentChats({super.key});

  @override
  State<RecentChats> createState() => _RecentChatsState();
}

class _RecentChatsState extends State<RecentChats> {
  List chats = [''];
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTexts.sectionTitle(
          title: 'Your Chats',
          subtitle: 'History',
          context: context,
        ),
      ],
    );
  }
}
