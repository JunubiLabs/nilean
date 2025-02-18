import 'package:buai/blocs/chat/chat_event.dart';
import 'package:buai/blocs/chat/chat_state.dart';
import 'package:buai/models/chat_content_model.dart';
import 'package:buai/models/chat_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatModel? chat;

  ChatBloc() : super(ChatInitial()) {
    on<SendPromptEvent>(_sendPrompt);
    on<SendImagePromptEvent>(_sendImagePrompt);
  }

  Future _sendPrompt(
    SendPromptEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());
    chat ??= ChatModel(
      title: '',
      chatcontent: [],
      date: DateTime.now(),
      id: Uuid().v4(),
    );

    chat?.chatcontent.add(ChatContentModel(
      date: DateTime.now(),
      chat: event.prompt,
      response: '',
      translatedChat: '',
      translatedResponse: '',
    ));

    Future.delayed(const Duration(seconds: 3)).then((x) {
      emit(ChatLoaded(chat: chat!));
    });
  }

  Future _sendImagePrompt(
    SendImagePromptEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());
    chat = ChatModel(
      title: '',
      chatcontent: [],
      date: DateTime.now(),
      id: Uuid().v4(),
    );
    Future.delayed(const Duration(seconds: 3)).then((x) {
      emit(ChatLoaded(chat: chat!));
    });
  }
}
