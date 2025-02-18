import 'package:buai/models/chat_content_model.dart';
import 'package:buai/utils/colors.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.chat});
  final ChatContentModel chat;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.secondaryWhite,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 1.5, color: Colors.black),
      ),
      child: Column(
        children: [],
      ),
    );
  }
}
