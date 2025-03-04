import 'package:buai/models/article_language_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

part 'news_article_model.g.dart';

@HiveType(typeId: 3)
class NewsArticleModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String author;

  @HiveField(3)
  final String url;

  @HiveField(4)
  final String imageUrl;

  @HiveField(5)
  final String description;

  @HiveField(6)
  final ArticleLanguageModel content;

  @HiveField(7)
  final DateTime publishedAt;

  @HiveField(8)
  final String? category;

  @HiveField(9)
  final String source;

  NewsArticleModel({
    required this.id,
    required this.title,
    required this.author,
    required this.url,
    required this.imageUrl,
    required this.description,
    required this.content,
    required this.publishedAt,
    this.category,
    required this.source,
  });

  factory NewsArticleModel.fromJson(Map<String, dynamic> json) {
    return NewsArticleModel(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      url: json['url'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      content: ArticleLanguageModel.fromJson(json['content']),
      publishedAt: json['publishedAt'],
      category: json['category'],
      source: json['source'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'author': author,
      'url': url,
      'imageUrl': imageUrl,
      'description': description,
      'content': content.toJson(),
      'publishedAt': publishedAt,
      'category': category,
      'source': source,
    };
  }

  factory NewsArticleModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;
    return NewsArticleModel(
      id: doc.id,
      title: data['title'],
      author: data['author'],
      url: data['url'],
      imageUrl: data['imageUrl'],
      description: data['description'],
      content: ArticleLanguageModel.fromJson(data['content']),
      publishedAt: DateTime.parse(data['publishedAt']),
      category: data['category'],
      source: data['source'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'author': author,
      'url': url,
      'imageUrl': imageUrl,
      'description': description,
      'content': content.toJson(),
      'publishedAt': publishedAt,
      'category': category,
      'source': source,
    };
  }
}
