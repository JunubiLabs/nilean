import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class InputThemes {
  static InputDecoration usernameInput(
    String label,
    BuildContext context,
  ) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      filled: true,
      fillColor: Colors.white,
      labelText: label,
      labelStyle: GoogleFonts.lato(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      border: const OutlineInputBorder(),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 2),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 2),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 2),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
    );
  }

  static InputDecoration emailInput(BuildContext context) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      filled: true,
      fillColor: Colors.white,
      labelText: "example@gmail.com",
      labelStyle: GoogleFonts.lato(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 2),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 2),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 2),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 2),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
    );
  }

  static InputDecoration passwordInput(
    BuildContext context,
    bool isObsecure,
    Function() toggleObsecure,
  ) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      filled: true,
      fillColor: Colors.white,
      labelText: "password",
      labelStyle: GoogleFonts.lato(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      border: const OutlineInputBorder(),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 2),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 2),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 2),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      suffixIcon: IconButton(
        onPressed: toggleObsecure,
        icon: Icon(
          isObsecure ? IconsaxPlusLinear.eye : IconsaxPlusLinear.eye_slash,
          color: Colors.black,
        ),
      ),
    );
  }

  static InputDecoration chatBubbleTheme(BuildContext context) {
    return InputDecoration(
      contentPadding: EdgeInsets.zero,
      isCollapsed: true,
      labelText: 'Enter your prompt here',
      labelStyle: TextStyle(fontSize: 16, color: Colors.black),
      filled: true,
      fillColor: Colors.transparent,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
      ),
    );
  }

  static InputDecoration defInput(BuildContext context, String label) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      isCollapsed: true,
      filled: true,
      fillColor: Colors.transparent,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      labelText: label,
      labelStyle: GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.bold),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
      ),
    );
  }
}
