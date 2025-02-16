import 'package:buai/models/chat_content_model.dart';

class ChatModel {
  String? id;
  DateTime? date;
  String? title;
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
