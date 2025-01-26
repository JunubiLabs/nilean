import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class InputThemes {
  static InputDecoration emailInput(BuildContext context) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      filled: true,
      fillColor: Theme.of(context).colorScheme.primary,
      labelText: "example@gmail.com",
      labelStyle: GoogleFonts.lato(fontSize: 15),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      border: const OutlineInputBorder(),
      focusedBorder: const OutlineInputBorder(),
    );
  }

  static InputDecoration passwordInput(
    BuildContext context,
    bool isObsecure,
  ) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      filled: true,
      fillColor: Theme.of(context).colorScheme.primary,
      labelText: "password",
      labelStyle: GoogleFonts.lato(fontSize: 15),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      border: const OutlineInputBorder(),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      suffixIcon: IconButton(
        onPressed: () {
          isObsecure = !isObsecure;
        },
        icon: Icon(
          isObsecure ? IconsaxPlusLinear.eye : IconsaxPlusLinear.eye_slash,
        ),
      ),
    );
  }
}
