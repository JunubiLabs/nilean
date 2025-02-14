import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTexts {
  static Widget sectionTitle({
    required String title,
    required String subtitle,
    required BuildContext context,
  }) {
    return RichText(
      text: TextSpan(
        text: title,
        style: GoogleFonts.lato(
          fontSize: 24,
          color: Theme.of(context).colorScheme.secondary,
          fontWeight: FontWeight.bold,
          height: 1.1,
        ),
        children: [
          TextSpan(
            text: subtitle,
            style: GoogleFonts.lato(
              fontSize: 24,
              color: Theme.of(context).colorScheme.onSecondary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
