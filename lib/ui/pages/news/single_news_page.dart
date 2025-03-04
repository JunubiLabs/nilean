import 'package:buai/models/news_article_model.dart';
import 'package:buai/ui/widgets/app_buttons.dart';
import 'package:buai/utils/colors.dart';
import 'package:buai/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:jiffy/jiffy.dart';

class SingleNewsPage extends StatefulWidget {
  const SingleNewsPage({super.key, required this.news});

  final NewsArticleModel news;

  @override
  State<SingleNewsPage> createState() => _SingleNewsPageState();
}

class _SingleNewsPageState extends State<SingleNewsPage> {
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
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppButtons.ellipsisButton(
                    onPressed: () {},
                    color: AppColors.primaryOrange,
                    context: context,
                    text: Jiffy.parseFromDateTime(widget.news.publishedAt)
                        .MMMMEEEEd,
                  ),
                  const SizedBox(width: 10),
                  AppButtons.ellipsisButton(
                    onPressed: () {},
                    color: AppColors.sourceColors(widget.news.source),
                    context: context,
                    text: widget.news.source,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                widget.news.title,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 20),
              Container(
                height: 140,
                decoration: BoxDecoration(
                  color: AppColors.primaryGrey,
                  image: DecorationImage(
                    image: NetworkImage(widget.news.imageUrl),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(height: 20),
              MarkdownBody(
                data: widget.news.content.en,
                shrinkWrap: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
