import 'package:firebase_auth/firebase_auth.dart';
import 'package:nilean/blocs/chat/chat_bloc.dart';
import 'package:nilean/blocs/chat/chat_event.dart';
import 'package:nilean/blocs/chat/chat_state.dart';
import 'package:nilean/models/chat_content_model.dart';
import 'package:nilean/ui/pages/chat/chat_bubble.dart';
import 'package:nilean/ui/pages/chat/chat_input.dart';
import 'package:nilean/ui/widgets/app_buttons.dart';
import 'package:nilean/ui/widgets/app_texts.dart';
import 'package:nilean/models/chat_model.dart';
import 'package:nilean/ui/widgets/auth_dialog.dart';
import 'package:nilean/utils/colors.dart';
import 'package:nilean/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, this.chat});

  final ChatModel? chat;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ScrollController _scrollController = ScrollController();
  TextEditingController inputController = TextEditingController();

  String prompt = '';
  String chatLanguage = 'English';
  List<String> languages = AppConstants.languages.map((l) => l.name).toList();

  String getLanguageCode(String language) {
    return AppConstants.languages.firstWhere((l) => l.name == language).code;
  }

  void scrollToTheBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 1250),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.chat != null) {
        context.read<ChatBloc>().add(LoadChatEvent(widget.chat!));
      }
    });
  }

  @override
  void didChangeDependencies() {
    context.read<ChatBloc>().add(ResetChatEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            if (state is ChatLoaded) {
              scrollToTheBottom();
            }
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AppButtons.backButton(
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      const Spacer(),
                      if (state is ChatLoaded || state is ChatError)
                        AppButtons.ellipsisButton(
                          onPressed: () {
                            context.read<ChatBloc>().add(ResetChatEvent());
                          },
                          color: AppColors.primaryBlue,
                          context: context,
                          text: '+ New Chat',
                          displaySize: DisplaySize.large,
                        )
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (state is ChatInitial) ...[
                    const Spacer(),
                    Row(
                      children: [
                        AppButtons.ellipsisButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/my-chats');
                          },
                          color: AppColors.primaryOrange,
                          context: context,
                          text: 'Recent Chats ',
                          icon: Icons.arrow_outward_sharp,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    AppTexts.sectionTitle(
                      title: "Let's chat in",
                      subtitle: "your mother tongue",
                      context: context,
                      size: DisplaySize.large,
                    ),
                    const Spacer(),
                  ],
                  if (state is ChatLoading) ...[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(width: double.maxFinite),
                          LoadingAnimationWidget.inkDrop(
                            color: AppColors.primaryOrange,
                            size: 40,
                          )
                        ],
                      ),
                    ),
                  ],
                  if (state is ChatLoaded) ...[
                    Expanded(
                      child: ListView(
                        controller: _scrollController,
                        shrinkWrap: true,
                        children: [
                          for (var chat in state.chat.chatcontent) ...[
                            ChatBubble(
                              chat: chat,
                            ),
                            const SizedBox(height: 25),
                          ],
                        ],
                      ),
                    ),
                  ],
                  if (state is ChatError) ...[
                    Expanded(
                      child: ListView(
                        controller: _scrollController,
                        shrinkWrap: true,
                        children: [
                          ChatBubble(
                            chat: ChatContentModel(
                              date: DateTime.now(),
                              chat: prompt,
                              response: state.message,
                            ),
                            isError: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                  ChatInput(
                    inputController: inputController,
                    onSend: () {
                      if (FirebaseAuth.instance.currentUser != null) {
                        setState(() {
                          prompt = inputController.value.text;
                        });
                        inputController.clear();
                        BlocProvider.of<ChatBloc>(context).add(
                          SendPromptEvent(
                              prompt, getLanguageCode(chatLanguage)),
                        );
                        Future.delayed(const Duration(seconds: 1)).then((x) {
                          scrollToTheBottom();
                        });
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AuthDialog();
                          },
                        );
                      }
                    },
                    onLanguagePressed: (String language) {
                      setState(() {
                        chatLanguage = language;
                      });
                    },
                    items: languages,
                    activeItem: chatLanguage,
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
