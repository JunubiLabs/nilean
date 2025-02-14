import 'package:buai/ui/widgets/app_buttons.dart';
import 'package:buai/ui/widgets/app_texts.dart';
import 'package:buai/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainSection extends StatefulWidget {
  const MainSection({super.key});

  @override
  State<MainSection> createState() => _MainSectionState();
}

class _MainSectionState extends State<MainSection> {
  bool _isDarkMode = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final brightness = MediaQuery.of(context).platformBrightness;
      setState(() {
        _isDarkMode = brightness == Brightness.dark;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
        Container(
          height: 160,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color:
                _isDarkMode ? AppColors.primaryBlue : AppColors.secondaryBlue,
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
                        color: _isDarkMode
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
                            color: _isDarkMode
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
          ],
        ),
      ],
    );
  }
}
