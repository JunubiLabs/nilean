import 'package:nilean/ui/widgets/app_buttons.dart';
import 'package:nilean/ui/widgets/app_texts.dart';
import 'package:nilean/utils/colors.dart';
import 'package:card_loading/card_loading.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class TranslateDisplay extends StatelessWidget {
  const TranslateDisplay({
    super.key,
    required this.displayText,
    required this.isLoading,
    required this.onLanguagePressed,
    required this.items,
    required this.activeItem,
  });

  final String displayText;
  final bool isLoading;
  final Function(String) onLanguagePressed;
  final List<String> items;
  final String activeItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: AppColors.primaryGrey),
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.2,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isLoading) ...[
            Text(
              displayText,
              style: GoogleFonts.inter(color: Colors.black, fontSize: 16),
            )
          ],
          if (isLoading) ...[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CardLoading(height: 13, width: double.maxFinite),
                const SizedBox(height: 10),
                CardLoading(
                  height: 13,
                  width: MediaQuery.of(context).size.width * 0.6,
                ),
                const SizedBox(height: 10),
                CardLoading(
                  height: 13,
                  width: MediaQuery.of(context).size.width * 0.4,
                )
              ],
            )
          ],
          Row(
            children: [
              AppButtons.dropdownButton(
                onPressed: onLanguagePressed,
                context: context,
                items: items,
                activeItem: activeItem,
                color: AppColors.primaryBlue,
                displaySize: DisplaySize.large,
              ),
              const Spacer(),
              AppButtons.circularButton(
                onPressed: () {
                  FlutterClipboard.copy(displayText);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Copied to clipboard')),
                  );
                },
                context: context,
                color: AppColors.primaryYellow,
                icon: Icons.copy_sharp,
                displaySize: DisplaySize.large,
              ),
              const SizedBox(width: 2),
              AppButtons.circularButton(
                onPressed: () {},
                context: context,
                color: AppColors.primaryBlue,
                icon: Icons.volume_up,
                displaySize: DisplaySize.large,
              ),
              const SizedBox(width: 2),
              AppButtons.circularButton(
                onPressed: () {
                  Share.share(displayText);
                },
                context: context,
                color: AppColors.primaryGrey,
                icon: Icons.ios_share,
                displaySize: DisplaySize.large,
              ),
            ],
          )
        ],
      ),
    );
  }
}
