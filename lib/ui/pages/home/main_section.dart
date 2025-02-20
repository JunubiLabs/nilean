import 'package:buai/ui/widgets/app_buttons.dart';
import 'package:buai/ui/widgets/app_texts.dart';
import 'package:buai/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class MainSection extends StatefulWidget {
  const MainSection({super.key});

  @override
  State<MainSection> createState() => _MainSectionState();
}

class _MainSectionState extends State<MainSection> {
  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTexts.sectionTitle(
          context: context,
          title: "Let's talk in",
          subtitle: "your mother tongue",
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/chat');
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.all(0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: Size.zero,
          ),
          child: Container(
            height: 160,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: brightness == Brightness.dark
                  ? AppColors.primaryBlue
                  : AppColors.secondaryBlue,
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
                          color: brightness == Brightness.dark
                              ? AppColors.primaryBlack
                              : AppColors.primaryWhite,
                          fontWeight: FontWeight.bold,
                          height: 1.1,
                        ),
                        children: [
                          TextSpan(
                            text: "\nyour mother tongue",
                            style: GoogleFonts.lato(
                              fontSize: 21,
                              color: brightness == Brightness.dark
                                  ? AppColors.secondaryBlack
                                  : AppColors.secondaryWhite
                                      .withAlpha((255 * 0.75).ceil()),
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
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/news');
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  minimumSize: Size.zero,
                ),
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
                            color: AppColors.primaryBlack,
                            fontWeight: FontWeight.bold,
                            height: 1.1,
                          ),
                          children: [
                            TextSpan(
                              text: "\nyour mother tongue",
                              style: GoogleFonts.lato(
                                fontSize: 18,
                                color: AppColors.secondaryBlack,
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
            ).animate().slideX(
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 800),
                  begin: 0.5,
                ),
            const SizedBox(width: 5),
            Expanded(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/translate');
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  minimumSize: Size.zero,
                ),
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
                            color: AppColors.primaryBlack,
                            fontWeight: FontWeight.bold,
                            height: 1.1,
                          ),
                          children: [
                            TextSpan(
                              text: "\nyour mother tongue",
                              style: GoogleFonts.lato(
                                fontSize: 18,
                                color: AppColors.secondaryBlack,
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
            ).animate().slideX(
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 800),
                  begin: 0.5,
                ),
          ],
        ),
      ],
    );
  }
}
