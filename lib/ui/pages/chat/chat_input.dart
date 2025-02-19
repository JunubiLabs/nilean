import 'package:buai/ui/widgets/app_buttons.dart';
import 'package:buai/utils/colors.dart';
import 'package:buai/utils/input_themes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatInput extends StatelessWidget {
  const ChatInput({
    super.key,
    required this.inputController,
    required this.onSend,
    required this.onLanguagePressed,
    required this.items,
    required this.activeItem,
  });

  final TextEditingController inputController;
  final void Function() onSend;
  final Function(String) onLanguagePressed;
  final List<String> items;
  final String activeItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.secondaryWhite,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1.5, color: Colors.black),
      ),
      child: Column(
        children: [
          TextFormField(
            controller: inputController,
            style: GoogleFonts.inter(color: Colors.black, fontSize: 16),
            decoration: InputThemes.chatBubbleTheme(context),
            showCursor: true,
            cursorColor: Colors.black,
            maxLines: 3,
            minLines: 1,
            cursorHeight: 17,
            autocorrect: false,
            autofocus: false,
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              AppButtons.dropdownButton(
                onPressed: onLanguagePressed,
                context: context,
                items: items,
                activeItem: activeItem,
                color: AppColors.primaryBlue,
              ),
              const SizedBox(width: 5),
              AppButtons.circularButton(
                onPressed: () {},
                color: AppColors.primaryOrange,
                context: context,
                icon: Icons.attach_file_sharp,
              ),
              const Spacer(),
              AppButtons.ellipsisButton(
                onPressed: onSend,
                color: AppColors.primaryYellow,
                context: context,
                text: 'Send ',
                icon: Icons.send,
              ),
            ],
          )
        ],
      ),
    );
  }
}
