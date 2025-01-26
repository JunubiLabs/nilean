import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

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
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: child,
    );
  }

  static Widget backButton({
    required VoidCallback onPressed,
    required BuildContext context,
  }) {
    return IconButton(
      onPressed: onPressed,
      style: IconButton.styleFrom(
        alignment: Alignment.center,
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(),
        ),
      ),
      icon: const Icon(
        IconsaxPlusLinear.arrow_left_1,
        size: 20,
      ),
    );
  }
}
