import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nilean/models/news_article_model.dart';
import 'package:nilean/repositories/news_repository.dart';
import 'package:nilean/ui/pages/news/single_news_page.dart';
import 'package:nilean/ui/widgets/app_buttons.dart';
import 'package:nilean/ui/widgets/app_cards.dart';
import 'package:nilean/ui/widgets/app_texts.dart';
import 'package:nilean/utils/colors.dart';
import 'package:nilean/utils/constants.dart';
import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final NewsRepository _newsRepository = NewsRepository();
  final ScrollController _scrollController = ScrollController();

  // Pagination variables
  List<NewsArticleModel> _newsList = [];
  bool _isLoadingMore = false;
  bool _hasMoreData = true;
  DocumentSnapshot? _lastDocument;
  static const int _pageSize = 10;

  String newsLanguage = 'English';
  List<String> languages = AppConstants.languages.map((l) => l.name).toList();

  String getLanguageCode(String language) {
    return AppConstants.languages.firstWhere((l) => l.name == language).code;
  }

  void loadInitialLanguage() {
    Hive.openBox('settings').then((box) {
      if (box.get('language') != null) {
        setState(() {
          newsLanguage = box.get('language');
        });
      }
    });
  }

  void setLanguage(String language) {
    Hive.openBox('settings').then((box) {
      box.put('language', language);
    });
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
    super.initState();
    loadInitialLanguage();
    _loadInitialNews();

    // Add scroll listener
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  // Scroll listener for pagination
  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      if (!_isLoadingMore && _hasMoreData) {
        _loadMoreNews();
      }
    }
  }

  // Load initial news
  Future<void> _loadInitialNews() async {
    setState(() {
      _isLoadingMore = true;
    });

    try {
      final articles = await _newsRepository.fetchNews(limit: _pageSize);

      setState(() {
        _newsList = articles.items;
        _lastDocument = articles.lastDocument;
        _hasMoreData = articles.items.length >= _pageSize;
        _isLoadingMore = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingMore = false;
      });
    }
  }

  // Load more news when scrolling
  Future<void> _loadMoreNews() async {
    if (_isLoadingMore || !_hasMoreData) return;

    setState(() {
      _isLoadingMore = true;
    });

    try {
      final moreArticles = await _newsRepository.fetchNews(
        limit: _pageSize,
        startAfter: _lastDocument,
      );

      setState(() {
        _newsList.addAll(moreArticles.items);
        _lastDocument = moreArticles.lastDocument;
        _hasMoreData = moreArticles.items.length >= _pageSize;
        _isLoadingMore = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingMore = false;
      });
    }
  }

  // Pull to refresh implementation
  Future<void> _refreshNews() async {
    setState(() {
      _lastDocument = null;
      _hasMoreData = true;
    });
    await _loadInitialNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refreshNews,
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            physics: const AlwaysScrollableScrollPhysics(),
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
                const SizedBox(height: 20),
                AppTexts.sectionTitle(
                  title: 'Breaking News',
                  subtitle: 'Happening Now',
                  context: context,
                ),
                const SizedBox(height: 20),
                FutureBuilder(
                  future: _newsRepository.fetchBreakingNews(),
                  builder: (context, snapshot) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) ...[
                            for (var i = 0; i < 3; i++) ...[
                              const CardLoading(
                                height: 120,
                                width: 200,
                              ),
                              const SizedBox(width: 10),
                            ],
                          ],
                          if (snapshot.hasData) ...[
                            for (var news in snapshot.data!) ...[
                              AppCards.curatedNewsCard(
                                context: context,
                                news: newsTitle(news),
                                image: news.imageUrl,
                                source: news.source,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SingleNewsPage(
                                        news: news,
                                      ),
                                    ),
                                  );
                                },
                                width: 200,
                              ),
                              const SizedBox(width: 10),
                            ],
                          ]
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 25),
                AppTexts.sectionTitle(
                  title: 'Latest News',
                  subtitle: 'Curated for you',
                  context: context,
                ),
                const SizedBox(height: 20),

                // Latest news - paginated
                Column(
                  children: [
                    if (_newsList.isEmpty && _isLoadingMore) ...[
                      for (var i = 0; i < 6; i++) ...[
                        const CardLoading(
                          height: 100,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ],
                    if (_newsList.isNotEmpty) ...[
                      for (var news in _newsList) ...[
                        AppCards.newsCard(
                          context: context,
                          news: newsTitle(news),
                          image: news.imageUrl,
                          source: news.source,
                          author: news.author,
                          date: news.publishedAt.toString(),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    SingleNewsPage(news: news),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ],
                    if (_isLoadingMore && _newsList.isNotEmpty) ...[
                      for (var i = 0; i < 6; i++) ...[
                        const CardLoading(
                          height: 100,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ],
                    if (!_hasMoreData && _newsList.isNotEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Center(
                          child: Text("No more news to load"),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
