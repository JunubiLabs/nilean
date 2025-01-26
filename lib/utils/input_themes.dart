import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
}
