import 'package:buai/ui/widgets/app_cards.dart';
import 'package:buai/ui/widgets/app_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class RecentChats extends StatefulWidget {
  const RecentChats({super.key});

  @override
  State<RecentChats> createState() => _RecentChatsState();
}

class _RecentChatsState extends State<RecentChats> {
  List chats = [
    'Ɛŋu mi göörä kɛ ɣöö bä ko̱r joc',
    'Kä ji̱ South Sudan ti ŋuan ti ci li̱w rɛy köör Sudan in rɛwdɛ?',
    'Yeŋö ye ɣɛn wïc ba dɔ̈ɔ̈r bɛ̈i në piny ciɛɛm de Sudan yic në thaa thiɔ̈kic?',
    'Kä ji̱ South Sudan ti ŋuan ti ci li̱w rɛy köör Sudan in rɛwdɛ?',
  ];
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
    );
  }
}
