abstract class ChatEvent {}

class SendPromptEvent extends ChatEvent {
  final String prompt;

  SendPromptEvent(this.prompt);
}

class SendImagePromptEvent extends ChatEvent {
  final String image;
  final String prompt;

  SendImagePromptEvent(this.image, this.prompt);
}
