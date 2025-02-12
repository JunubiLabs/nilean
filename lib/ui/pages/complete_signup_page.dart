import 'dart:async';

import 'package:buai/blocs/auth/auth_bloc.dart';
import 'package:buai/ui/widgets/app_buttons.dart';
import 'package:buai/utils/colors.dart';
import 'package:buai/utils/input_themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CompleteSignupPage extends StatefulWidget {
  const CompleteSignupPage({super.key});

  @override
  State<CompleteSignupPage> createState() => _CompleteSignupPageState();
}

class _CompleteSignupPageState extends State<CompleteSignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();

  bool isEmailVerified = false;
  bool isLoading = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    sendVerificationEmail();

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
    _firstnameController.dispose();
    _lastnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlue,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.registrationIncomplete) {
            Navigator.of(context).pushNamed('/home');
          }
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error.toString()),
              ),
            );
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
                          state.status == AuthStatus.unverified
                              ? "Email Verification"
                              : "Complete Signup",
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
                        if (state.status == AuthStatus.verified) ...[
                          Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 5),
                                TextFormField(
                                  controller: _firstnameController,
                                  style: GoogleFonts.lato(fontSize: 15),
                                  decoration: InputThemes.usernameInput(
                                    "First Name",
                                    context,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                TextFormField(
                                  controller: _lastnameController,
                                  style: GoogleFonts.lato(fontSize: 15),
                                  decoration: InputThemes.usernameInput(
                                    "Last Name",
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
                            if (state.status == AuthStatus.verified) {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                context
                                    .read<AuthBloc>()
                                    .add(CompleteRegistrationRequested(
                                      _firstnameController.text,
                                      _lastnameController.text,
                                    ));
                              }
                            } else {
                              context
                                  .read<AuthBloc>()
                                  .add(SendVerificationEmailRequested());
                            }
                          },
                          child: SizedBox(
                            width: double.maxFinite,
                            child: isLoading
                                ? LoadingAnimationWidget.fourRotatingDots(
                                    color: AppColors.primaryWhite,
                                    size: 20,
                                  )
                                : Text(
                                    !isEmailVerified
                                        ? "Resend Email"
                                        : "Let's Go",
                                    style: GoogleFonts.kanit(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        RichText(
                          text: TextSpan(
                            text: !isEmailVerified
                                ? "Resend Email after $timer"
                                : "Let's Go",
                            style: GoogleFonts.kanit(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            children: [],
                          ),
                        ),
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
