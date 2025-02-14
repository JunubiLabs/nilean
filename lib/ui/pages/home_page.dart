import 'package:buai/ui/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppHeader(),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: "Let's talk in",
                  style: GoogleFonts.lato(
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                  ),
                  children: [
                    TextSpan(
                      text: "\nyour mother tongue",
                      style: GoogleFonts.lato(
                        fontSize: 24,
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
