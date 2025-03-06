import 'package:buai/models/news_article_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NewsRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<NewsArticleModel>> fetchNews() async {
    try {
      final querySnapshot = await _firestore.collection('articles').get();

      final articles = querySnapshot.docs
          .map((doc) => NewsArticleModel.fromFirestore(doc))
          .toList();

      return articles;
    } catch (e) {
      throw Error();
    }
  }

  Future<List<NewsArticleModel>> fetchBreakingNews() async {
    try {
      final querySnapshot = await _firestore.collection('breaking_news').get();

      return querySnapshot.docs
          .map((doc) => NewsArticleModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Error();
    }
  }

  Future<NewsArticleModel> fetchNewsById(String id) async {
    final doc = await _firestore.collection('articles').doc(id).get();
    return NewsArticleModel.fromFirestore(doc);
  }

  Future<NewsArticleModel> fetchNewsByUrl({required String url}) async {
    final doc = await _firestore
        .collection('articles')
        .where('url', isEqualTo: url)
        .get();
    return NewsArticleModel.fromFirestore(doc.docs.first);
  }

  Future<NewsArticleModel> saveArticle(NewsArticleModel news) async {
    final articleStorage = Hive.box<NewsArticleModel>('articles');
    await articleStorage.put(news.id, news);
    return news;
  }
}
