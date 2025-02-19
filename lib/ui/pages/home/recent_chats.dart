import 'dart:math';

import 'package:buai/models/chat_model.dart';
import 'package:buai/ui/pages/chat/chat_page.dart';
import 'package:buai/ui/widgets/app_cards.dart';
import 'package:buai/ui/widgets/app_texts.dart';
import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive/hive.dart';

class RecentChats extends StatefulWidget {
  const RecentChats({super.key});

  @override
  State<RecentChats> createState() => _RecentChatsState();
}

class _RecentChatsState extends State<RecentChats> {
  Future<List<ChatModel>> getRecentChatSessionsFromStorage() async {
    final chatsBox = await Hive.openBox<ChatModel>('chats');
    await chatsBox.clear();
    List<ChatModel> chats = chatsBox.values.toList();
    return chats;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getRecentChatSessionsFromStorage(),
      builder: (context, snapshot) {
        var chats = snapshot.data ?? [];

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (snapshot.connectionState == ConnectionState.waiting) ...[
              AppTexts.sectionTitle(
                title: 'Your Chats',
                subtitle: 'History',
                context: context,
              ),
              const SizedBox(height: 20),
              StaggeredGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 10,
                children: [
                  for (var i = 1; i < 5; i++) ...[
                    CardLoading(
                      height: (Random().nextInt(80) + 40).toDouble(),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 25),
            ],
            if (snapshot.connectionState == ConnectionState.done) ...[
              if (chats.isNotEmpty) ...[
                AppTexts.sectionTitle(
                  title: 'Your Chats',
                  subtitle: 'History',
                  context: context,
                ),
                const SizedBox(height: 20),
                StaggeredGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 10,
                  children: [
                    for (var chat in chats) ...[
                      AppCards.chatCard(
                        context: context,
                        chat: chat.title ?? '',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatPage(
                                chat: chat,
                              ),
                            ),
                          );
                        },
                      )
                          .animate()
                          .slideY(
                            curve: Curves.ease,
                            duration: const Duration(milliseconds: 700),
                            begin: 0.5,
                          )
                          .fade(),
                    ]
                  ],
                ),
                const SizedBox(height: 25),
              ],
            ]
          ],
        );
      },
    );
  }
}
