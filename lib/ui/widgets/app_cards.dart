import 'dart:convert';

import 'package:buai/ui/widgets/app_buttons.dart';
import 'package:buai/utils/colors.dart';
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
        width: double.maxFinite,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.primaryGrey,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              chat,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
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
}
