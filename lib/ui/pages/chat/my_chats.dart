import 'package:buai/ui/widgets/app_buttons.dart';
import 'package:buai/ui/widgets/app_cards.dart';
import 'package:buai/ui/widgets/app_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MyChats extends StatefulWidget {
  const MyChats({super.key});

  @override
  State<MyChats> createState() => _MyChatsState();
}

class _MyChatsState extends State<MyChats> {
  @override
  Widget build(BuildContext context) {
    List chats = [
      'Ɛŋu mi göörä kɛ ɣöö bä ko̱r joc',
      'Kä ji̱ South Sudan ti ŋuan ti ci li̱w rɛy köör Sudan in rɛwdɛ?',
      'Yeŋö ye ɣɛn wïc ba dɔ̈ɔ̈r bɛ̈i në piny ciɛɛm de Sudan yic në thaa thiɔ̈kic?',
      'Kä ji̱ South Sudan ti ŋuan ti ci li̱w rɛy köör Sudan in rɛwdɛ?',
    ];
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppButtons.backButton(onPressed: () => Navigator.pop(context)),
              const SizedBox(height: 10),
              AppTexts.sectionTitle(
                title: 'My Chats',
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
                      chat: chat,
                      onPressed: () {},
                    ),
                  ]
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
