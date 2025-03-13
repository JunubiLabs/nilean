import 'package:nilean/ui/widgets/app_texts.dart';
import 'package:nilean/utils/colors.dart';
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
    DisplaySize? displaySize,
  }) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: Size.zero,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: displaySize == DisplaySize.large
              ? 4
              : displaySize == DisplaySize.medium
                  ? 3
                  : 2,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(width: 1.5, color: Colors.black),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (text != null) ...[
              RichText(
                text: TextSpan(
                  text: text,
                  style: GoogleFonts.lato(
                    fontSize: displaySize == DisplaySize.large
                        ? 15
                        : displaySize == DisplaySize.small
                            ? 8
                            : 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
            if (icon != null) ...[
              Icon(icon,
                  size: displaySize == DisplaySize.large
                      ? 20
                      : displaySize == DisplaySize.small
                          ? 12
                          : 16,
                  color: Colors.black)
            ]
          ],
        ),
      ),
    );
  }

  static Widget circularButton({
    required VoidCallback onPressed,
    required BuildContext context,
    required Color color,
    required IconData icon,
  }) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: Size.zero,
      ),
      child: Container(
        width: 25,
        height: 25,
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(width: 2),
        ),
        child: Icon(icon, color: Colors.black, size: 15),
      ),
    );
  }

  static Widget dropdownButton({
    required Function(String) onPressed,
    required BuildContext context,
    DisplaySize? displaySize,
    required List<String> items,
    required String activeItem,
    required Color color,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (details) {
        final Size screenSize = MediaQuery.of(context).size;

        final RelativeRect position = RelativeRect.fromLTRB(
          details.globalPosition.dx,
          details.globalPosition.dy,
          screenSize.width - details.globalPosition.dx,
          screenSize.height - details.globalPosition.dy,
        );

        showMenu(
          context: context,
          position: position,
          color: Theme.of(context).scaffoldBackgroundColor,
          menuPadding: EdgeInsets.all(2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            side: BorderSide(
              color: AppColors.primaryBlue,
              width: 0.5,
            ),
          ),
          items: [
            for (var item in items) ...[
              PopupMenuItem(
                onTap: () => onPressed(item),
                value: item,
                height: 40,
                child: Text(
                  item,
                  style: GoogleFonts.lato(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        );
      },
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          minimumSize: Size.zero,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: displaySize == DisplaySize.large
                ? 4
                : displaySize == DisplaySize.medium
                    ? 2
                    : 1,
          ),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(width: 1.5, color: Colors.black),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                activeItem,
                style: GoogleFonts.lato(
                  fontSize: displaySize == DisplaySize.large
                      ? 15
                      : displaySize == DisplaySize.small
                          ? 8
                          : 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 3),
              Icon(
                Icons.language_sharp,
                size: displaySize == DisplaySize.large
                    ? 20
                    : displaySize == DisplaySize.small
                        ? 12
                        : 16,
                color: Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }
}
