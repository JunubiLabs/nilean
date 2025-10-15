import 'package:nilean/extensions/string_extensions.dart';
import 'package:nilean/models/chat_content_model.dart';
import 'package:nilean/ui/widgets/app_buttons.dart';
import 'package:nilean/utils/colors.dart';
import 'package:clipboard/clipboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class ChatBubble extends StatelessWidget {
  ChatBubble({super.key, required this.chat, this.isError = false});
  final ChatContentModel chat;
  final User user = FirebaseAuth.instance.currentUser!;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/avatar.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(60),
                border: Border.all(
                  width: 2,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                user.email?.split('@')[0].toTitleCase() ?? '',
                style: GoogleFonts.lato(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          chat.chat ?? '',
          style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isError
                ? Colors.red
                : Theme.of(context).colorScheme.tertiary,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/buai.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(60),
                      border: Border.all(
                        width: 2,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 3),
                  Expanded(
                    child: Text(
                      'JunubiAi',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              MarkdownBody(data: chat.response ?? '', selectable: true),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AppButtons.circularButton(
                    onPressed: () {
                      FlutterClipboard.copy(chat.response ?? '');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Copied to clipboard')),
                      );
                    },
                    context: context,
                    color: AppColors.primaryYellow,
                    icon: Icons.copy_sharp,
                  ),
                  const SizedBox(width: 2),
                  AppButtons.circularButton(
                    onPressed: () {},
                    context: context,
                    color: AppColors.primaryBlue,
                    icon: Icons.volume_up,
                  ),
                  const SizedBox(width: 2),
                  AppButtons.circularButton(
                    onPressed: () {
                      SharePlus.instance.share(
                        ShareParams(text: chat.response ?? ''),
                      );
                    },
                    context: context,
                    color: AppColors.primaryGrey,
                    icon: Icons.ios_share,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
