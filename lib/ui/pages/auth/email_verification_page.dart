import 'dart:async';

import 'package:nilean/blocs/auth/auth_bloc.dart';
import 'package:nilean/ui/widgets/app_buttons.dart';
import 'package:nilean/utils/colors.dart';
import 'package:nilean/utils/input_themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  bool isEmailVerified = false;
  bool isLoading = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(Duration(seconds: 3), (_) => checkEmailVerified());
  }

  Future<void> sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      await user?.sendEmailVerification();
    } catch (e) {
      throw 'Error sending email verification: $e';
    }
  }

  Future<void> checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();
    setState(() {
      isEmailVerified =
          FirebaseAuth.instance.currentUser?.emailVerified ?? false;
    });

    if (isEmailVerified) {
      timer?.cancel();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlue,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.verified) {
            Navigator.of(context).pushNamed('/complete-registration');
          }
        },
        child: SafeArea(
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Stack(
                children: [
                  Positioned.fill(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/complete-signup.png',
                          width: double.maxFinite,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email Verification",
                          style: GoogleFonts.jockeyOne(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Please Check Your Email for Verification and then come back",
                          style: GoogleFonts.kanit(fontSize: 15),
                        ),
                        const SizedBox(height: 5),
                        if (isEmailVerified) ...[
                          Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 5),
                                TextFormField(
                                  controller: _nameController,
                                  style: GoogleFonts.lato(
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                  decoration: InputThemes.usernameInput(
                                    "Name",
                                    context,
                                  ),
                                ),
                                const SizedBox(height: 5),
                              ],
                            ),
                          ),
                        ],
                        const SizedBox(height: 5),
                        AppButtons.blueButton(
                          onPressed: () {
                            context
                                .read<AuthBloc>()
                                .add(SendVerificationEmailRequested());
                          },
                          child: SizedBox(
                            width: double.maxFinite,
                            child: isLoading
                                ? LoadingAnimationWidget.fourRotatingDots(
                                    color: AppColors.primaryWhite,
                                    size: 20,
                                  )
                                : Text(
                                    "Resend Verification Email",
                                    style: GoogleFonts.kanit(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        if (!isEmailVerified) ...[
                          RichText(
                            text: TextSpan(
                              text: "Resend Email after ${timer?.tick} seconds",
                              style: GoogleFonts.kanit(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                              children: [],
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
