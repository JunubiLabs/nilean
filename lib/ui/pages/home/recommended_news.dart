import 'package:buai/repositories/news_repository.dart';
import 'package:buai/ui/pages/news/single_news_page.dart';
import 'package:buai/ui/widgets/app_cards.dart';
import 'package:buai/ui/widgets/app_texts.dart';
import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class RecommendedNews extends StatefulWidget {
  const RecommendedNews({super.key});

  @override
  State<RecommendedNews> createState() => _RecommendedNewsState();
}

class _RecommendedNewsState extends State<RecommendedNews> {
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
        FutureBuilder(
          future: NewsRepository().fetchNews(),
          builder: (context, snapshot) {
            return StaggeredGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 10,
              children: [
                if (snapshot.connectionState == ConnectionState.waiting) ...[
                  for (var i = 0; i < 3; i++) ...[
                    CardLoading(
                      height: 120,
                    ),
                  ],
                ],
                if (snapshot.hasData) ...[
                  for (var news in snapshot.data!.sublist(0, 4)) ...[
                    AppCards.curatedNewsCard(
                      context: context,
                      news: news.title,
                      image: news.imageUrl,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                SingleNewsPage(news: news),
                          ),
                        );
                      },
                    )
                        .animate()
                        .slideY(
                          curve: Curves.ease,
                          duration: const Duration(milliseconds: 700),
                          delay: Duration(
                              milliseconds:
                                  (snapshot.data?.indexOf(news) ?? 0) * 100),
                          begin: 0.5,
                        )
                        .fade(),
                  ],
                ]
              ],
            );
          },
        )
      ],
    );
  }
}
