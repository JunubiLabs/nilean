import 'package:nilean/models/news_article_content_model.dart';
import 'package:nilean/models/news_article_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nilean/models/news_response.dart';

class NewsRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<NewsArticleResponse> fetchNews({
    int limit = 10,
    DocumentSnapshot? startAfter,
  }) async {
    try {
      // Start with the base query
      Query<Map<String, dynamic>> query = _firestore
          .collection('news_titles')
          .orderBy('publishedAt', descending: true)
          .limit(limit);

      // Add startAfter if we're paginating
      if (startAfter != null) {
        query = query.startAfterDocument(startAfter);
      }

      // Execute the query
      final querySnapshot = await query.get();

      // Get the articles
      final articles = querySnapshot.docs
          .map((doc) => NewsArticleModel.fromFirestore(doc))
          .toList();

      // Return response with articles and last document for pagination
      return NewsArticleResponse(
        items: articles,
        lastDocument:
            querySnapshot.docs.isNotEmpty ? querySnapshot.docs.last : null,
      );
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
    final doc = await _firestore.collection('news_titles').doc(id).get();
    return NewsArticleModel.fromFirestore(doc);
  }

  Future<NewsArticleModel> fetchNewsByUrl({required String url}) async {
    try {
      final doc = await _firestore
          .collection('news_titles')
          .where('imageUrl', isEqualTo: url)
          .get();
      return NewsArticleModel.fromFirestore(doc.docs.first);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<NewsArticleContentModel> fetchNewsContent(
      {required String newsId}) async {
    final doc = await _firestore.collection('news_content').doc(newsId).get();
    return NewsArticleContentModel.fromFirestore(doc);
  }

  Future<NewsArticleModel> saveArticle(NewsArticleModel news) async {
    final articleStorage = Hive.box<NewsArticleModel>('news_titles');
    await articleStorage.put(news.id, news);
    return news;
  }
}
