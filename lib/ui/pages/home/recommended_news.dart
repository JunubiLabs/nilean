import 'package:nilean/models/news_article_model.dart';
import 'package:nilean/repositories/news_repository.dart';
import 'package:nilean/ui/pages/news/single_news_page.dart';
import 'package:nilean/ui/widgets/app_cards.dart';
import 'package:nilean/ui/widgets/app_texts.dart';
import 'package:nilean/utils/constants.dart';
import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive/hive.dart';

class RecommendedNews extends StatefulWidget {
  const RecommendedNews({super.key});

  @override
  State<RecommendedNews> createState() => _RecommendedNewsState();
}

class _RecommendedNewsState extends State<RecommendedNews> {
  String newsLanguage = 'English';
  List<String> languages = AppConstants.languages.map((l) => l.name).toList();

  getLanguageCode(String language) {
    return AppConstants.languages.firstWhere((l) => l.name == language).code;
  }

  String newsTitle(NewsArticleModel news) {
    if (getLanguageCode(newsLanguage) == 'en') {
      return news.title.en;
    } else if (getLanguageCode(newsLanguage) == 'nus') {
      return news.title.nus ?? news.title.en;
    } else {
      return news.title.din ?? news.title.en;
    }
  }

  loadInitialLanguage() {
    Hive.openBox('settings').then((box) {
      if (box.get('language') != null) {
        setState(() {
          newsLanguage = box.get('language');
        });
      }
    });
  }

  @override
  void initState() {
    loadInitialLanguage();
    super.initState();
  }

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
                      news: newsTitle(news),
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
