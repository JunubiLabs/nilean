import 'package:nilean/models/article_language_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

part 'news_article_model.g.dart';

@HiveType(typeId: 4)
class NewsArticleModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String titleEn;

  @HiveField(2)
  final String author;

  @HiveField(3)
  final String url;

  @HiveField(4)
  final String imageUrl;

  @HiveField(5)
  final String description;

  @HiveField(6)
  final DateTime publishedAt;

  @HiveField(7)
  final String? category;

  @HiveField(8)
  final String source;

  @HiveField(9)
  final String? titleNus;

  @HiveField(10)
  final String? titleDin;

  NewsArticleModel({
    required this.id,
    required this.author,
    required this.url,
    required this.imageUrl,
    required this.description,
    required this.publishedAt,
    this.category,
    required this.source,
    required this.titleEn,
    required this.titleDin,
    required this.titleNus,
  });

  factory NewsArticleModel.fromJson(Map<String, dynamic> json) {
    return NewsArticleModel(
      id: json['id'],
      author: json['author'],
      url: json['url'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      publishedAt: json['publishedAt'],
      category: json['category'],
      source: json['source'],
      titleEn: json['title_en'],
      titleDin: json['title_din'],
      titleNus: json['title_nus'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title_en': titleEn,
      'title_din': titleDin,
      'title_nus': titleNus,
      'author': author,
      'url': url,
      'imageUrl': imageUrl,
      'description': description,
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
      titleEn: data['title_en'],
      titleDin: data['title_din'],
      titleNus: data['title_nus'],
      author: data['author'],
      url: data['url'],
      imageUrl: data['imageUrl'],
      description: data['description'],
      publishedAt: DateTime.parse(data['publishedAt']),
      category: data['category'],
      source: data['source'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      'id': id,
      'title_en': titleEn,
      'title_din': titleDin,
      'title_nus': titleNus,
      'author': author,
      'url': url,
      'imageUrl': imageUrl,
      'description': description,
      'publishedAt': publishedAt,
      'category': category,
      'source': source,
    };
  }
}
