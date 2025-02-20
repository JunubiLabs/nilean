abstract class TranslateState {}

class TranslateInitial extends TranslateState {}

class TranslateLoading extends TranslateState {}

class TranslateLoaded extends TranslateState {
  final String translatedText;
  TranslateLoaded({required this.translatedText});
}

class TranslateError extends TranslateState {
  final String message;
  TranslateError(this.message);
}

class TranslateReset extends TranslateState {}

class TranslateClear extends TranslateState {}
