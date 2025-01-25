import 'package:buai/ui/widgets/app_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage('assets/images/larim.jpg'),
            fit: BoxFit.cover,
            opacity: 0.60,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "buai",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'GizaStencil',
                  letterSpacing: 1.5,
                ),
              ).animate().fadeIn(
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeIn,
                  ),
              const Spacer(),
              Text(
                "Let's get started!",
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Experience your Ai in your South Sudanese language. To continue, sign in or create an account.",
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 25),
              AppButtons.authButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/login');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(IconsaxPlusLinear.sms, color: Colors.black, size: 21),
                    const SizedBox(width: 6),
                    Text(
                      "Continue with Email",
                      style: GoogleFonts.lato(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
                  .animate()
                  .slideY(
                    begin: 0.5,
                    duration: const Duration(milliseconds: 850),
                  )
                  .fade(),
              const SizedBox(height: 10),
              AppButtons.authButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/login');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/google.jpg', width: 16),
                    const SizedBox(width: 6),
                    Text(
                      "Continue with Google",
                      style: GoogleFonts.lato(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
                  .animate()
                  .slideY(
                    begin: 0.5,
                    duration: const Duration(milliseconds: 850),
                    delay: const Duration(milliseconds: 200),
                  )
                  .fade(),
            ],
          ),
        ),
      ),
    );
  }
}
