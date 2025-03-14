import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nilean/ui/widgets/app_buttons.dart';
import 'package:nilean/ui/widgets/app_texts.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
              AppButtons.backButton(
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 20),
              AppTexts.sectionTitle(
                title: 'Account',
                subtitle: 'Preferences',
                context: context,
              ),
              const SizedBox(height: 20),
              AppButtons.settingItem(
                onPressed: () {},
                context: context,
                child: Row(
                  children: [
                    Icon(Icons.account_circle_outlined),
                    const SizedBox(width: 10),
                    Text(
                      'Account Settings',
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.arrow_forward_ios_sharp),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              AppButtons.settingItem(
                onPressed: () {},
                context: context,
                child: Row(
                  children: [
                    Icon(Icons.notifications_active_outlined),
                    const SizedBox(width: 10),
                    Text(
                      'Notifications',
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.arrow_forward_ios_sharp),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              AppButtons.settingItem(
                onPressed: () {},
                context: context,
                child: Row(
                  children: [
                    Icon(Icons.account_circle_outlined),
                    const SizedBox(width: 10),
                    Text(
                      'Theme Settings',
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.arrow_forward_ios_sharp),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              AppButtons.settingItem(
                onPressed: () {},
                context: context,
                child: Row(
                  children: [
                    Icon(Icons.logout_rounded),
                    const SizedBox(width: 10),
                    Text(
                      'Logout',
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.arrow_forward_ios_sharp),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              //General
              AppTexts.sectionTitle(
                title: 'General',
                subtitle: 'Application',
                context: context,
              ),
              const SizedBox(height: 20),
              AppButtons.settingItem(
                onPressed: () {},
                context: context,
                child: Row(
                  children: [
                    Icon(Icons.privacy_tip_outlined),
                    const SizedBox(width: 10),
                    Text(
                      'Privacy Policy',
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.arrow_forward_ios_sharp),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              AppButtons.settingItem(
                onPressed: () {},
                context: context,
                child: Row(
                  children: [
                    Icon(Icons.accessibility_outlined),
                    const SizedBox(width: 10),
                    Text(
                      'Terms & Conditions',
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.arrow_forward_ios_sharp),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              AppButtons.settingItem(
                onPressed: () {},
                context: context,
                child: Row(
                  children: [
                    Icon(Icons.heat_pump_sharp),
                    const SizedBox(width: 10),
                    Text(
                      'Donate & Support Us',
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.arrow_forward_ios_sharp),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              AppButtons.settingItem(
                onPressed: () {},
                context: context,
                child: Row(
                  children: [
                    Icon(Icons.ios_share_sharp),
                    const SizedBox(width: 10),
                    Text(
                      'Share App',
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.arrow_forward_ios_sharp),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              AppButtons.settingItem(
                onPressed: () {},
                context: context,
                child: Row(
                  children: [
                    Icon(Icons.stars_rounded),
                    const SizedBox(width: 10),
                    Text(
                      'Rate Us',
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.arrow_forward_ios_sharp),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
