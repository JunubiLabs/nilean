class TextTranslateModel {
  String? sourceLanguage;
  dynamic definitions;
  dynamic translations;
  String? translatedText;
  String? pronunciation;

  TextTranslateModel({
    required this.sourceLanguage,
    this.definitions,
    this.translations,
    this.translatedText,
    this.pronunciation,
  });

  static TextTranslateModel fromJson(Map<String, dynamic> json) {
    return TextTranslateModel(
      sourceLanguage: json['source_language'] ?? "",
      definitions: json['definitions'],
      translations: json['translations'],
      translatedText: json['translated_text'],
      pronunciation: json['pronunciation'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'source_language': sourceLanguage,
      'definitions': definitions,
      'translations': translations,
      'translated_text': translatedText,
      'pronunciation': pronunciation,
    };
  }
}
