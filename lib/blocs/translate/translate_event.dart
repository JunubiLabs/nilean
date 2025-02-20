abstract class TranslateEvent {}

class TranslateRequestedEvent extends TranslateEvent {
  final String text;
  final String fromLanguage;
  final String toLanguage;

  TranslateRequestedEvent(this.text, this.fromLanguage, this.toLanguage);
}

class TranslateResetEvent extends TranslateEvent {}
