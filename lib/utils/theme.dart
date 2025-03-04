import 'package:buai/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static ThemeData light = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(
      primary: Colors.white,
      onPrimary: AppColors.secondaryWhite.withAlpha((255 * 0.75).ceil()),
      secondary: Colors.black,
      onSecondary: AppColors.secondaryBlack,
      tertiary: AppColors.primaryGrey.withAlpha((255 * 0.65).ceil()),
    ),
    textTheme: TextTheme(
      labelLarge: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        height: 1.2,
      ),
    ),
  );

  static ThemeData dark = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    colorScheme: ColorScheme.dark(
      primary: Colors.black,
      secondary: Colors.white,
      onSecondary: AppColors.secondaryWhite.withAlpha((255 * 0.75).ceil()),
      tertiary: AppColors.primaryGrey.withAlpha((255 * 0.15).ceil()),
    ),
    textTheme: TextTheme(
      labelLarge: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        height: 1.2,
      ),
    ),
  );
}
