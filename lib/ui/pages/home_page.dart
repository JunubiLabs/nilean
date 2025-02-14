import 'package:buai/ui/widgets/app_buttons.dart';
import 'package:buai/ui/widgets/header.dart';
import 'package:buai/utils/colors.dart';
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
              Container(
                height: 160,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue,
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppButtons.forwardButton(onPressed: () {}),
                        RichText(
                          text: TextSpan(
                            text: "Let's talk in",
                            style: GoogleFonts.lato(
                              fontSize: 21,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              height: 1.1,
                            ),
                            children: [
                              TextSpan(
                                text: "\nyour mother tongue",
                                style: GoogleFonts.lato(
                                  fontSize: 21,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Image(
                      image: AssetImage('assets/images/chat.png'),
                      height: double.maxFinite,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: AppColors.primaryOrange,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Image(
                                  image: AssetImage('assets/images/news.png'),
                                  height: 80,
                                  alignment: Alignment.topLeft,
                                ),
                              ),
                              AppButtons.forwardButton(onPressed: () {}),
                            ],
                          ),
                          RichText(
                            text: TextSpan(
                              text: "Get news in",
                              style: GoogleFonts.lato(
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                                height: 1.1,
                              ),
                              children: [
                                TextSpan(
                                  text: "\nyour mother tongue",
                                  style: GoogleFonts.lato(
                                    fontSize: 18,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: AppColors.primaryYellow,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image(
                                image: AssetImage(
                                  'assets/images/translate.png',
                                ),
                                height: 80,
                                alignment: Alignment.topLeft,
                              ),
                              AppButtons.forwardButton(onPressed: () {}),
                            ],
                          ),
                          RichText(
                            text: TextSpan(
                              text: "Translate to",
                              style: GoogleFonts.lato(
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                                height: 1.1,
                              ),
                              children: [
                                TextSpan(
                                  text: "\nyour mother tongue",
                                  style: GoogleFonts.lato(
                                    fontSize: 18,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
