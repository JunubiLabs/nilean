import 'package:buai/blocs/translate/translate_bloc.dart';
import 'package:buai/blocs/translate/translate_event.dart';
import 'package:buai/blocs/translate/translate_state.dart';
import 'package:buai/ui/pages/translate/translate_display.dart';
import 'package:buai/ui/pages/translate/translate_input.dart';
import 'package:buai/ui/widgets/app_buttons.dart';
import 'package:buai/ui/widgets/app_texts.dart';
import 'package:buai/utils/colors.dart';
import 'package:buai/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TranslatePage extends StatefulWidget {
  const TranslatePage({super.key});

  @override
  State<TranslatePage> createState() => _TranslatePageState();
}

class _TranslatePageState extends State<TranslatePage> {
  List<String> languages = AppConstants.languages.map((l) => l.name).toList();

  getLanguageCode(String language) {
    return AppConstants.languages
        .firstWhere((element) => element.name == language)
        .code;
  }

  String translateToLanguage = 'English';
  String translateFromLanguage = 'English';

  TextEditingController inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TranslateBloc, TranslateState>(
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppButtons.backButton(onPressed: () {
                    Navigator.pop(context);
                  }),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      AppButtons.ellipsisButton(
                        onPressed: () {},
                        color: AppColors.primaryOrange,
                        context: context,
                        text: 'Recent Translations ',
                        icon: Icons.arrow_outward,
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  AppTexts.sectionTitle(
                    title: "Let's translate to",
                    subtitle: 'your mother tongue',
                    context: context,
                    size: DisplaySize.large,
                  ),
                  AppTexts.sectionTitle(
                    title: "",
                    subtitle: 'to',
                    context: context,
                    size: DisplaySize.large,
                  ),
                  const SizedBox(height: 5),
                  TranslateDisplay(
                    displayText:
                        state is TranslateLoaded ? state.translatedText : '',
                    isLoading: state is TranslateLoading,
                    onLanguagePressed: (String ste) {
                      setState(() {
                        translateToLanguage = ste;
                      });
                      if (inputController.value.text.isNotEmpty) {
                        context.read<TranslateBloc>().add(
                              TranslateRequestedEvent(
                                inputController.value.text,
                                getLanguageCode(translateFromLanguage),
                                getLanguageCode(translateToLanguage),
                              ),
                            );
                      }
                    },
                    items: languages,
                    activeItem: translateToLanguage,
                  ),
                  AppTexts.sectionTitle(
                    title: "",
                    subtitle: 'from',
                    context: context,
                    size: DisplaySize.large,
                  ),
                  const SizedBox(height: 5),
                  TranslateInput(
                    inputController: inputController,
                    onSend: () {
                      context.read<TranslateBloc>().add(
                            TranslateRequestedEvent(
                              inputController.value.text,
                              getLanguageCode(translateFromLanguage),
                              getLanguageCode(translateToLanguage),
                            ),
                          );
                    },
                    onLanguagePressed: (String ste) {
                      setState(() {
                        translateFromLanguage = ste;
                      });
                    },
                    items: languages,
                    activeItem: translateFromLanguage,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
