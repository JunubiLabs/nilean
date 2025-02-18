import 'package:buai/ui/widgets/app_buttons.dart';
import 'package:buai/utils/colors.dart';
import 'package:buai/utils/input_themes.dart';
import 'package:flutter/material.dart';

class ChatInput extends StatelessWidget {
  const ChatInput({
    super.key,
    required this.inputController,
    required this.onSend,
  });

  final TextEditingController inputController;
  final void Function() onSend;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.secondaryWhite,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 1.5, color: Colors.black),
      ),
      child: Column(
        children: [
          TextFormField(
            controller: inputController,
            style: TextStyle(color: Colors.black, fontSize: 16),
            decoration: InputThemes.chatBubbleTheme(context),
            showCursor: true,
            maxLines: 3,
            minLines: 1,
            cursorHeight: 14,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              AppButtons.ellipsisButton(
                onPressed: () {},
                color: AppColors.primaryBlue,
                context: context,
                text: 'Nuer',
                icon: Icons.keyboard_arrow_down,
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
