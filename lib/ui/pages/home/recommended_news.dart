import 'package:buai/ui/widgets/app_cards.dart';
import 'package:buai/ui/widgets/app_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class RecommendedNews extends StatefulWidget {
  const RecommendedNews({super.key});

  @override
  State<RecommendedNews> createState() => _RecommendedNewsState();
}

class _RecommendedNewsState extends State<RecommendedNews> {
  List news = [
    [
      'Kä ji̱ South Sudan ti ŋuan ti ci li̱w rɛy köör Sudan in rɛwdɛ?',
      'https://i0.wp.com/www.nyamile.com/wp-content/uploads/2024/10/nasirprotests.jpg?w=960&ssl=1'
    ],
    [
      'Yeŋö ye ɣɛn wïc ba dɔ̈ɔ̈r bɛ̈i në piny ciɛɛm de Sudan yic në thaa thiɔ̈kic?',
      'https://i0.wp.com/www.nyamile.com/wp-content/uploads/2021/05/South-Sudan-Humanitarian-Catastrophe.jpg?w=1024&ssl=1'
    ],
    [
      'Yeŋö ye ɣɛn wïc ba dɔ̈ɔ̈r bɛ̈i në piny ciɛɛm de Sudan yic në thaa thiɔ̈kic?',
      'https://i0.wp.com/www.nyamile.com/wp-content/uploads/2021/05/South-Sudan-Humanitarian-Catastrophe.jpg?w=1024&ssl=1'
    ],
    [
      'Yeŋö ye ɣɛn wïc ba dɔ̈ɔ̈r bɛ̈i në piny ciɛɛm de Sudan yic në thaa thiɔ̈kic?',
      'https://i0.wp.com/www.nyamile.com/wp-content/uploads/2021/05/South-Sudan-Humanitarian-Catastrophe.jpg?w=1024&ssl=1'
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTexts.sectionTitle(
          title: 'News curated',
          subtitle: 'for you',
          context: context,
        ),
        const SizedBox(height: 20),
        StaggeredGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 10,
          children: [
            for (var n in news) ...[
              AppCards.curatedNewsCard(
                context: context,
                news: n[0],
                image: n[1],
                onPressed: () {},
              )
                  .animate()
                  .slideY(
                    curve: Curves.ease,
                    duration: const Duration(milliseconds: 700),
                    delay: Duration(milliseconds: news.indexOf(n) * 100),
                    begin: 0.5,
                  )
                  .fade(),
            ]
          ],
        ),
      ],
    );
  }
}
