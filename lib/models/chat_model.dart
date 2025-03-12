import 'package:nilean/models/chat_content_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'chat_model.g.dart';

@HiveType(typeId: 0)
class ChatModel {
  @HiveField(0)
  String? id;

  @HiveField(1)
  DateTime? date;

  @HiveField(2)
  String? title;

  @HiveField(3)
  List<ChatContentModel> chatcontent;

  ChatModel({
    this.id,
    this.date,
    this.title,
    required this.chatcontent,
  });

  static ChatModel fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      date: json['date'],
      title: json['title'],
      chatcontent: json['chat_content'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'date': date,
      'title': title,
      'chat_content': chatcontent,
    };
  }
}
