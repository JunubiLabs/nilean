import 'package:buai/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppButtons {
  static Widget authButton({
    required Widget child,
    required VoidCallback onPressed,
  }) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: const BorderSide(color: Colors.black, width: 2),
        ),
      ),
      child: child,
    );
  }

  static Widget backButton({
    required onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 30,
        height: 30,
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: AppColors.primaryGrey,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(width: 2),
        ),
        child: const Icon(
          Icons.arrow_back,
          color: Colors.black,
          size: 20,
        ),
      ),
    );
  }

  static Widget blueButton({
    required VoidCallback onPressed,
    required Widget child,
  }) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: AppColors.secondaryBlue,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: const BorderSide(color: Colors.black, width: 2),
        ),
      ),
      child: child,
    );
  }

  static Widget forwardButton({
    required onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 25,
        height: 25,
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: AppColors.primaryGrey,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(width: 2),
        ),
        child: const Icon(
          Icons.arrow_forward,
          color: Colors.black,
          size: 18,
        ),
      ),
    );
  }

  static Widget ellipsisButton({
    required VoidCallback onPressed,
    required Color color,
    required BuildContext context,
    IconData? icon,
    String? text,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(width: 1, color: Colors.black),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text!,
              style: GoogleFonts.lato(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
            icon != null
                ? Icon(icon, size: 16, color: Colors.black)
                : Container(),
          ],
        ),
      ),
    );
  }
}
