import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum DisplaySize {
  small,
  medium,
  large,
}

class AppTexts {
  static Widget sectionTitle({
    required String title,
    required String subtitle,
    required BuildContext context,
    DisplaySize? size,
  }) {
    return RichText(
      text: TextSpan(
        text: title,
        style: GoogleFonts.lato(
          fontSize: size == DisplaySize.large
              ? 32
              : size == DisplaySize.small
                  ? 18
                  : 25,
          color: Theme.of(context).colorScheme.secondary,
          fontWeight: FontWeight.bold,
          height: 1.1,
        ),
        children: [
          TextSpan(
            text: '\n$subtitle',
            style: GoogleFonts.lato(
              fontSize: size == DisplaySize.large
                  ? 32
                  : size == DisplaySize.small
                      ? 18
                      : 25,
              color: Theme.of(context).colorScheme.onSecondary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  static RichText newsTitle({
    required String title,
    required BuildContext context,
    DisplaySize? size,
  }) {
    return RichText(
      text: TextSpan(
        text: title,
        style: GoogleFonts.lato(
          fontSize: size == DisplaySize.large
              ? 32
              : size == DisplaySize.small
                  ? 18
                  : 25,
          color: Theme.of(context).colorScheme.secondary,
          fontWeight: FontWeight.bold,
          height: 1.1,
        ),
      ),
    );
  }
}
