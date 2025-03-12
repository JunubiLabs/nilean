import 'package:nilean/models/text_translate_model.dart';
import 'package:dio/dio.dart';

class AiServices {
  static Future<TextTranslateModel> translateText({
    required String from,
    required String to,
    required String text,
  }) async {
    try {
      const String url = 'https://translate.neurollect.africa/api/translate';

      final dio = Dio();

      final formData = FormData.fromMap({
        "engine": "google",
        "from": from,
        "to": to,
        "text": text,
      });

      final response = await dio.post(
        url,
        data: formData,
      );

      Map<String, dynamic> responseData = response.data;
      final result = TextTranslateModel.fromJson(responseData);

      return result;
    } catch (e) {
      throw Exception(e);
    }
  }
}
