import 'package:buai/models/news_article_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NewsRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<NewsArticleModel>> fetchNews(String languageCode) async {
    final querySnapshot = await _firestore
        .collection('articles')
        .orderBy('timestamp', descending: true)
        .get();

    return querySnapshot.docs
        .map((doc) => NewsArticleModel.fromFirestore(doc))
        .toList();
  }

  Future<NewsArticleModel> fetchNewsById(String id) async {
    final doc = await _firestore.collection('articles').doc(id).get();
    return NewsArticleModel.fromFirestore(doc);
  }

  Future<NewsArticleModel> saveArticle(NewsArticleModel news) async {
    final articleStorage = Hive.box<NewsArticleModel>('articles');
    await articleStorage.put(news.id, news);
    return news;
  }
}
