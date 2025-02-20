import 'package:buai/ui/widgets/app_buttons.dart';
import 'package:buai/ui/widgets/app_texts.dart';
import 'package:buai/utils/colors.dart';
import 'package:flutter/material.dart';

class TranslatePage extends StatefulWidget {
  const TranslatePage({super.key});

  @override
  State<TranslatePage> createState() => _TranslatePageState();
}

class _TranslatePageState extends State<TranslatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
