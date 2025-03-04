import 'package:buai/models/news_article_model.dart';
import 'package:buai/ui/widgets/app_buttons.dart';
import 'package:buai/utils/colors.dart';
import 'package:buai/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:jiffy/jiffy.dart';
import 'package:url_launcher/url_launcher.dart';

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

  loadInitialLanguage() {
    Hive.openBox('settings').then((box) {
      if (box.get('language') != null) {
        setState(() {
          newsLanguage = box.get('language');
        });
      }
    });
  }

  setLanguage(String language) {
    Hive.openBox('settings').then((box) {
      box.put('language', language);
    });
  }

  String newsData() {
    if (getLanguageCode(newsLanguage) == 'en') {
      return widget.news.content.en;
    } else if (getLanguageCode(newsLanguage) == 'nus') {
      return widget.news.content.nus ?? widget.news.content.en;
    } else {
      return widget.news.content.din ?? widget.news.content.en;
    }
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

  @override
  void initState() {
    loadInitialLanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue.shade700,
        onPressed: () async {
          final Uri url = Uri.parse(widget.news.url);

          if (await canLaunchUrl(url)) {
            await launchUrl(url, mode: LaunchMode.externalApplication);
          } else {
            throw 'Could not launch $url';
          }
        },
        label: Text(
          'Read',
          style: GoogleFonts.lato(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        icon: const Icon(
          Icons.arrow_outward_rounded,
          color: Colors.white,
          size: 20,
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppButtons.backButton(
                    onPressed: () => Navigator.pop(context),
                  ),
                  AppButtons.dropdownButton(
                    onPressed: (String lang) {
                      setState(() => newsLanguage = lang);
                      setLanguage(lang);
                    },
                    context: context,
                    items: languages,
                    activeItem: newsLanguage,
                    color: AppColors.primaryBlue,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                        const SizedBox(width: 5),
                        AppButtons.ellipsisButton(
                          onPressed: () {},
                          color: AppColors.sourceColors(widget.news.source),
                          context: context,
                          text: widget.news.source,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      newsTitle(widget.news),
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 200,
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
                      data: newsData(),
                      selectable: true,
                      shrinkWrap: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
