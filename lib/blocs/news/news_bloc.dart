import 'package:buai/repositories/news_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buai/blocs/news/news_event.dart';
import 'package:buai/blocs/news/news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository = NewsRepository();

  NewsBloc() : super(NewsInitial(language: 'en')) {
    on<LoadNewsEvent>(_loadNews);
    on<LoadBreakingNewsEvent>(_loadBreakingsNews);
    on<LoadNewsByCategoryEvent>(_loadNewsByCategory);
    on<SaveNewsEvent>(_saveNews);
    on<ChangeLanguageNewsEvent>(_changeLanguage);
  }

  Future<void> _loadNews(LoadNewsEvent event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
  }

  Future<void> _loadBreakingsNews(
    LoadBreakingNewsEvent event,
    Emitter<NewsState> emit,
  ) async {
    emit(NewsLoading());
    try {} catch (e) {
      emit(NewsError('Failed to load news'));
    }
  }

  Future<void> _saveNews(SaveNewsEvent event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    try {} catch (e) {
      emit(NewsError('Failed to save news'));
    }
  }

  Future<void> _changeLanguage(
    ChangeLanguageNewsEvent event,
    Emitter<NewsState> emit,
  ) async {
    emit(NewsInitial(language: event.language));
  }

  Future<void> _loadNewsByCategory(
    LoadNewsByCategoryEvent event,
    Emitter<NewsState> emit,
  ) async {
    emit(NewsLoading());
    try {} catch (e) {
      emit(NewsError('Failed to load news'));
    }
  }
}
