import 'dart:typed_data';

import 'package:hive/hive.dart';

part 'chat_content_model.g.dart';

@HiveType(typeId: 1)
class ChatContentModel {
  @HiveField(0)
  String? date;

  @HiveField(1)
  String? chat;

  @HiveField(2)
  String? translatedChat;

  @HiveField(3)
  String? response;

  @HiveField(4)
  String? translatedResponse;

  @HiveField(5)
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
