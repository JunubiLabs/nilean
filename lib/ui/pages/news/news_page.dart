import 'package:buai/repositories/news_repository.dart';
import 'package:buai/ui/widgets/app_buttons.dart';
import 'package:buai/ui/widgets/app_cards.dart';
import 'package:buai/ui/widgets/app_texts.dart';
import 'package:buai/utils/colors.dart';
import 'package:buai/utils/constants.dart';
import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final NewsRepository _newsRepository = NewsRepository();

  String newsLanguage = 'English';
  List<String> languages = AppConstants.languages.map((l) => l.name).toList();

  getLanguageCode(String language) {
    return AppConstants.languages.firstWhere((l) => l.name == language).code;
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppButtons.backButton(
                    onPressed: () => Navigator.pop(context),
                  ),
                  AppButtons.dropdownButton(
                    onPressed: (String lang) {
                      setState(() => newsLanguage = lang);
                    },
                    context: context,
                    items: languages,
                    activeItem: newsLanguage,
                    color: AppColors.primaryBlue,
                  ),
                ],
              ),
              SizedBox(height: 20),
              AppTexts.sectionTitle(
                title: 'Breaking News',
                subtitle: 'Happening Now',
                context: context,
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: FutureBuilder(
                  future: _newsRepository.fetchNews(),
                  builder: (context, snapshot) {
                    return Row(
                      children: [
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) ...[
                          for (var i = 0; i < 3; i++) ...[
                            CardLoading(
                              height: 150,
                              width: MediaQuery.of(context).size.width * 0.3,
                            ),
                            const SizedBox(width: 10),
                          ],
                        ],
                        if (snapshot.hasData) ...[
                          for (var news in snapshot.data!) ...[
                            AppCards.curatedNewsCard(
                              context: context,
                              news: news.title,
                              image: news.imageUrl,
                              onPressed: () {},
                            ),
                            const SizedBox(width: 10),
                          ],
                        ]
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
