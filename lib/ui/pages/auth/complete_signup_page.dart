import 'dart:async';

import 'package:nilean/blocs/auth/auth_bloc.dart';
import 'package:nilean/ui/widgets/app_buttons.dart';
import 'package:nilean/ui/widgets/snack_bar.dart';
import 'package:nilean/utils/colors.dart';
import 'package:nilean/utils/input_themes.dart';
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
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlue,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          Future.delayed(const Duration(milliseconds: 1000));
          if (state.status == AuthStatus.registrationComplete) {
            Navigator.of(context).pushNamed('/home');
          }
          if (state.user != null && state.user?.displayName != null) {
            Navigator.of(context).pushNamed('/home');
          }
          if (state.error != null) {
            showSnackBar(
              context,
              SnackMessageType.error,
              'Registration Error',
              state.error.toString(),
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
                          "Complete Signup",
                          style: GoogleFonts.jockeyOne(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Enter your name to complete signup",
                          style: GoogleFonts.kanit(fontSize: 15),
                        ),
                        const SizedBox(height: 5),
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                                decoration: InputThemes.usernameInput(
                                  "Name",
                                  context,
                                ),
                              ),
                              const SizedBox(height: 5),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        AppButtons.blueButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context
                                  .read<AuthBloc>()
                                  .add(CompleteRegistrationRequested(
                                    _nameController.value.text,
                                  ));
                            }
                          },
                          child: SizedBox(
                            width: double.maxFinite,
                            child: state.status == AuthStatus.loading
                                ? LoadingAnimationWidget.fourRotatingDots(
                                    color: AppColors.primaryWhite,
                                    size: 20,
                                  )
                                : Text(
                                    "Let's Go",
                                    style: GoogleFonts.kanit(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                          ),
                        ),
                        const SizedBox(height: 5),
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
