import 'dart:typed_data';

import 'package:hive/hive.dart';

part 'chat_content_model.g.dart';

@HiveType(typeId: 1)
class ChatContentModel {
  @HiveField(0)
  DateTime? date;

  @HiveField(1)
  String? chat;

  @HiveField(2)
  String? enChat;

  @HiveField(3)
  String? response;

  @HiveField(4)
  String? enResponse;

  @HiveField(5)
  Uint8List? image;

  ChatContentModel({
    this.date,
    this.chat,
    this.response,
    this.image,
    this.enChat,
    this.enResponse,
  });

  static ChatContentModel fromJson(Map<String, dynamic> json) {
    return ChatContentModel(
      date: json['date'],
      chat: json['chat'],
      response: json['response'],
      image: json['image'],
      enChat: json['en_chat'],
      enResponse: json['en_response'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'date': date,
      'chat': chat,
      'response': response,
      'image': image,
      'en_chat': enChat,
      'en_response': enResponse,
    };
  }
}
