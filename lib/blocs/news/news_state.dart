import 'package:buai/models/news_article_model.dart';

abstract class NewsState {}

class NewsInitial extends NewsState {
  final String language;
  NewsInitial({required this.language});
}

class NewsLoaded extends NewsState {
  final List<NewsArticleModel> news;
  final String language;
  NewsLoaded({required this.news, required this.language});
}

class NewsError extends NewsState {
  final String message;
  NewsError(this.message);
}

class NewsLoading extends NewsState {}
