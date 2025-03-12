import 'package:nilean/models/chat_model.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final ChatModel chat;

  ChatLoaded({required this.chat});
}

class ChatError extends ChatState {
  final String message;
  ChatError(this.message);
}
