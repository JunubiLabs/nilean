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
      labelStyle: GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.bold),
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
  ) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      filled: true,
      fillColor: Theme.of(context).colorScheme.primary,
      labelText: "password",
      labelStyle: GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.bold),
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
