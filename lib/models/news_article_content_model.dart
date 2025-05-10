import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'news_article_content_model.g.dart';

@HiveType(typeId: 4)
class NewsArticleContentModel {
  @HiveField(0)
  final String contentEn;

  @HiveField(1)
  final String? contentNus;

  @HiveField(2)
  final String? contentDin;

  @HiveField(3)
  final String newsId;

  NewsArticleContentModel({
    required this.newsId,
    required this.contentEn,
    this.contentNus,
    this.contentDin,
  });

  factory NewsArticleContentModel.fromJson(Map<String, dynamic> json) {
    return NewsArticleContentModel(
      newsId: json['newsId'],
      contentEn: json['content_en'],
      contentNus: json['content_nus'],
      contentDin: json['content_din'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'news_id': newsId,
      'content_en': contentEn,
      'content_nus': contentNus,
      'content_din': contentDin,
    };
  }

  factory NewsArticleContentModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;
    return NewsArticleContentModel(
      newsId: doc.id,
      contentEn: data['contentEn'],
      contentDin: data['contentDin'],
      contentNus: data['contentNus'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      'newsid': newsId,
      'contentEn': contentEn,
      'contentDin': contentDin,
      'contentNus': contentNus,
    };
  }
}
