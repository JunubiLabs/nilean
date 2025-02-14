import 'package:buai/extensions/string_extensions.dart';
import 'package:buai/services/date_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppHeader extends StatefulWidget {
  const AppHeader({super.key});

  @override
  State<AppHeader> createState() => _AppHeaderState();
}

class _AppHeaderState extends State<AppHeader> {
  String name = FirebaseAuth.instance.currentUser?.displayName ?? '';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/avatar.png'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(60),
            border: Border.all(
              width: 2,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        Column(
          children: [
            Text(
              DateServices.getMorningOrEvening(),
              style: GoogleFonts.jockeyOne(
                fontSize: 15,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            Text(
              name.toTitleCase(),
              style: GoogleFonts.lato(
                fontSize: 28,
                color: Theme.of(context).colorScheme.secondary,
              ),
            )
          ],
        )
      ],
    );
  }
}
