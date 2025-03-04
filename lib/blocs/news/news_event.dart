abstract class NewsEvent {}

class LoadNewsEvent extends NewsEvent {}

class LoadNewsByIdEvent extends NewsEvent {}

class SaveNewsEvent extends NewsEvent {}

class ChangeLanguageNewsEvent extends NewsEvent {
  final String language;

  ChangeLanguageNewsEvent(this.language);
}
