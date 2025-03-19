import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nilean/models/news_article_model.dart';

class NewsArticleResponse {
  final List<NewsArticleModel> items;
  final DocumentSnapshot? lastDocument;

  NewsArticleResponse({
    required this.items,
    this.lastDocument,
  });
}
