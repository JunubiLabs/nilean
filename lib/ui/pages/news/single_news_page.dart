import 'package:nilean/models/news_article_content_model.dart';
import 'package:nilean/models/news_article_model.dart';
import 'package:nilean/repositories/news_repository.dart';
import 'package:nilean/ui/widgets/app_buttons.dart';
import 'package:nilean/ui/widgets/app_texts.dart';
import 'package:nilean/utils/colors.dart';
import 'package:nilean/utils/constants.dart';
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

  late NewsArticleContentModel newsContent;
  bool loading = true;

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

  loadNewsContent() async {
    final content = await NewsRepository().fetchNewsContent(
      newsId: widget.news.id,
    );

    setState(() {
      newsContent = content;
      loading = false;
    });
  }

  setLanguage(String language) {
    Hive.openBox('settings').then((box) {
      box.put('language', language);
    });
  }

  String newsData() {
    if (getLanguageCode(newsLanguage) == 'en') {
      return newsContent.contentEn;
    } else if (getLanguageCode(newsLanguage) == 'nus') {
      return newsContent.contentNus ?? newsContent.contentEn;
    } else {
      return newsContent.contentDin ?? newsContent.contentEn;
    }
  }

  String newsTitle(NewsArticleModel news) {
    if (getLanguageCode(newsLanguage) == 'en') {
      return news.titleEn;
    } else if (getLanguageCode(newsLanguage) == 'nus') {
      return news.titleNus ?? news.titleEn;
    } else {
      return news.titleDin ?? news.titleEn;
    }
  }

  @override
  void initState() {
    loadInitialLanguage();
    loadNewsContent();
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
                    displaySize: DisplaySize.large,
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
