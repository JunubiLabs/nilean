import 'dart:typed_data';

class ChatContentModel {
  String? date;
  String? chat;
  String? translatedChat;
  String? response;
  String? translatedResponse;
  Uint8List? image;

  ChatContentModel({
    this.date,
    this.chat,
    this.response,
    this.image,
    this.translatedChat,
    this.translatedResponse,
  });

  static ChatContentModel fromJson(Map<String, dynamic> json) {
    return ChatContentModel(
      date: json['date'],
      chat: json['chat'],
      response: json['response'],
      image: json['image'],
      translatedChat: json['translated_chat'],
      translatedResponse: json['translated_response'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'date': date,
      'chat': chat,
      'response': response,
      'image': image,
      'translated_chat': translatedChat,
      'translated_response': translatedResponse,
    };
  }
}
