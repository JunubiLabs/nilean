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
    on<ResetChatEvent>(resetChat);
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
      response:
          "The South Sudanese Civil War, which lasted from 2013 to 2020, was a multi-sided conflict between government and opposition forces. While a political quarrel sparked the war, its roots are in a weakly institutionalized state and ethnic divisions. Key factors that contributed to the conflict: Political Disputes: The civil war began with a political dispute between President Salva Kiir and his former deputy Riek Machar, after Kiir accused Machar of plotting a coup Resource Control: The conflict started out as a struggle within the elite over control of the oil revenue",
      translatedChat: 'Yeeŋö yenë tɔŋ de kɔc tɔ̈ në piny ciɛɛm de Sudan bɛ̈i?',
      translatedResponse:
          "The South Sudanese Civil War, which lasted from 2013 to 2020, was a multi-sided conflict between government and opposition forces. While a political quarrel sparked the war, its roots are in a weakly institutionalized state and ethnic divisions. Key factors that contributed to the conflict: Political Disputes: The civil war began with a political dispute between President Salva Kiir and his former deputy Riek Machar, after Kiir accused Machar of plotting a coup Resource Control: The conflict started out as a struggle within the elite over control of the oil revenue",
    ));

    await Future.delayed(const Duration(seconds: 3)).then((x) {
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

  Future<void> resetChat(
    ResetChatEvent event,
    Emitter<ChatState> emit,
  ) async {
    chat = null;
    emit(ChatInitial());
  }
}
