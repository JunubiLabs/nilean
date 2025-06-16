import 'package:nilean/extensions/string_extensions.dart';
import 'package:nilean/services/date_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nilean/ui/widgets/app_buttons.dart';

class AppHeader extends StatefulWidget {
  const AppHeader({super.key});

  @override
  State<AppHeader> createState() => _AppHeaderState();
}

class _AppHeaderState extends State<AppHeader> {
  String name = FirebaseAuth.instance.currentUser?.email?.split('@')[0] ?? '';
  String? photoUrl = FirebaseAuth.instance.currentUser?.photoURL;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/settings');
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.all(0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: Size.zero,
          ),
          child: Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: photoUrl != null
                    ? NetworkImage(photoUrl ?? '')
                    : AssetImage('assets/images/avatar.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(60),
              border: Border.all(
                width: 2,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ),
        FirebaseAuth.instance.currentUser != null
            ? RichText(
                textAlign: TextAlign.right,
                text: TextSpan(
                  text: "${DateServices.getMorningOrEvening()}\n",
                  style: GoogleFonts.jockeyOne(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.secondary,
                    height: 1.1,
                  ),
                  children: [
                    TextSpan(
                      text: name.toTitleCase(),
                      style: GoogleFonts.lato(
                        fontSize: 28,
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            : AppButtons.defButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signin');
                },
                color: Colors.blue,
                child: Text(
                  'Sign In',
                  style: GoogleFonts.lato(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
      ],
    );
  }
}
