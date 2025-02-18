abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final String response;
  final String translatedResponse;

  ChatLoaded({
    required this.response,
    required this.translatedResponse,
  });
}

class ChatError extends ChatState {
  final String message;
  ChatError(this.message);
}
