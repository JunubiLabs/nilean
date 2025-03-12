import 'dart:convert';

import 'package:nilean/ui/widgets/app_buttons.dart';
import 'package:nilean/ui/widgets/app_texts.dart';
import 'package:nilean/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';

class AppCards {
  static String encodeText(rawText) {
    return utf8.decode(utf8.encode(rawText));
  }

  static Widget chatCard({
    required BuildContext context,
    required String chat,
    required VoidCallback onPressed,
  }) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).primaryColor,
        padding: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.primaryGrey,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                text: chat,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                AppButtons.ellipsisButton(
                  onPressed: onPressed,
                  color: AppColors.primaryBlue,
                  text: Jiffy.now().yMd,
                  context: context,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget curatedNewsCard({
    required BuildContext context,
    required String news,
    required String image,
    required VoidCallback onPressed,
  }) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).primaryColor,
        padding: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(),
      ),
      child: Container(
        width: 200,
        height: 120,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.primaryGrey,
          image: DecorationImage(
            image: NetworkImage(image),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withAlpha(75),
              BlendMode.darken,
            ),
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                AppButtons.ellipsisButton(
                  onPressed: onPressed,
                  color: AppColors.primaryOrange,
                  text: Jiffy.now().yMd,
                  context: context,
                  displaySize: DisplaySize.small,
                ),
              ],
            ),
            const SizedBox(height: 5),
            RichText(
              maxLines: 3,
              text: TextSpan(
                text: news,
                style: GoogleFonts.inter(
                  height: 1.0,
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  static Widget newsCard({
    required BuildContext context,
    required String news,
    required String image,
    required String source,
    required String author,
    required String date,
    required VoidCallback onPressed,
  }) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).primaryColor,
        padding: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(),
      ),
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.zero,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.primaryGrey,
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    maxLines: 3,
                    text: TextSpan(
                      text: 'by $author | ${Jiffy.parse(date).MMMEd}',
                      style: GoogleFonts.inter(
                        height: 1.0,
                        fontSize: 10,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  RichText(
                    maxLines: 3,
                    text: TextSpan(
                      text: news,
                      style: GoogleFonts.inter(
                        height: 1.0,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      AppButtons.ellipsisButton(
                        onPressed: onPressed,
                        color: AppColors.sourceColors(source),
                        text: source,
                        context: context,
                        displaySize: DisplaySize.small,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
