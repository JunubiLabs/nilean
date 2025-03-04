abstract class NewsEvent {}

class LoadNewsEvent extends NewsEvent {}

class LoadBreakingNewsEvent extends NewsEvent {}

class LoadNewsByCategoryEvent extends NewsEvent {}

class SaveNewsEvent extends NewsEvent {}

class ChangeLanguageNewsEvent extends NewsEvent {
  final String language;

  ChangeLanguageNewsEvent(this.language);
}
