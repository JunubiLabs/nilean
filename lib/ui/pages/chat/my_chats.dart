import 'dart:math';

import 'package:buai/models/chat_model.dart';
import 'package:buai/ui/pages/chat/chat_page.dart';
import 'package:buai/ui/widgets/app_buttons.dart';
import 'package:buai/ui/widgets/app_cards.dart';
import 'package:buai/ui/widgets/app_texts.dart';
import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MyChats extends StatefulWidget {
  const MyChats({super.key});

  @override
  State<MyChats> createState() => _MyChatsState();
}

class _MyChatsState extends State<MyChats> {
  Future<List<ChatModel>> getRecentChatSessionsFromStorage() async {
    final chatsBox = await Hive.openBox<ChatModel>('chats');
    List<ChatModel> chats = chatsBox.values.toList();
    return chats;
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
              AppButtons.backButton(onPressed: () => Navigator.pop(context)),
              const SizedBox(height: 20),
              AppTexts.sectionTitle(
                title: 'My Chats',
                subtitle: 'History',
                context: context,
              ),
              const SizedBox(height: 20),
              FutureBuilder(
                future: getRecentChatSessionsFromStorage(),
                builder: (context, snapshot) {
                  var chats = snapshot.data ?? [];

                  return Column(
                    children: [
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) ...[
                        StaggeredGrid.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 10,
                          children: [
                            for (var i = 1; i < 10; i++) ...[
                              CardLoading(
                                height: 110 * Random(100).nextDouble() / 100,
                              ),
                            ],
                          ],
                        ),
                      ],
                      if (snapshot.connectionState == ConnectionState.done) ...[
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
                                    begin: 1,
                                    duration: const Duration(milliseconds: 500),
                                    delay: Duration(
                                      milliseconds: chats.indexOf(chat) * 100,
                                    ),
                                    curve: Curves.fastOutSlowIn,
                                  )
                                  .fade(),
                            ]
                          ],
                        ),
                      ]
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
