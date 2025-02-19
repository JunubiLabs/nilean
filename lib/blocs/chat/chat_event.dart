abstract class ChatEvent {}

class SendPromptEvent extends ChatEvent {
  final String prompt;
  final String language;

  SendPromptEvent(this.prompt, this.language);
}

class SendImagePromptEvent extends ChatEvent {
  final String image;
  final String prompt;
  final String language;

  SendImagePromptEvent(this.image, this.prompt, this.language);
}

class ResetChatEvent extends ChatEvent {}
