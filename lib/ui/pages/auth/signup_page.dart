import 'package:nilean/blocs/auth/auth_bloc.dart';
import 'package:nilean/ui/widgets/app_buttons.dart';
import 'package:nilean/ui/widgets/snack_bar.dart';
import 'package:nilean/utils/colors.dart';
import 'package:nilean/utils/input_themes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isObsecure = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  hidePassword() {
    setState(() {
      isObsecure = !isObsecure;
    });
  }

  errorHandling(String code) {
    if (code == 'user-not-found') {
      snackBarMessage('No user found for that email.');
    } else if (code == 'wrong-password') {
      snackBarMessage('Wrong password provided for that user.');
    }
    if (code == 'invalid-email') {
      snackBarMessage('Invalid email.');
    }
    if (code == 'user-disabled') {
      snackBarMessage('User is disabled.');
    }
    if (code == 'too-many-requests') {
      snackBarMessage('Too Many Requests. Try Again Later.');
    }
    if (code ==
        'Sign In Error: The supplied auth credential is incorrect, malformed or has expired.') {
      snackBarMessage(
          'The supplied email/password credential is incorrect, malformed or has expired.');
    } else {
      snackBarMessage(code);
    }
  }

  snackBarMessage(String message) {
    return showSnackBar(
      context,
      SnackMessageType.error,
      'Authentication Error',
      message,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlue,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.unverified) {
            Navigator.of(context).pushNamed('/email-verification');
          }
          if (state.error != null) {
            errorHandling(state.error!);
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
                          'assets/images/signup.png',
                          height: 350,
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            AppButtons.backButton(onPressed: () {
                              Navigator.pop(context);
                            }),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          "Sign Up",
                          style: GoogleFonts.jockeyOne(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Enter Your Email and Password to Sign Up",
                          style: GoogleFonts.kanit(
                            fontSize: 15,
                            color: Colors.black,
                          ),
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
                                controller: _emailController,
                                style: GoogleFonts.lato(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                                validator: (email) {
                                  if (email == null || email.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  if (!RegExp(
                                          r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(email)) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                                decoration: InputThemes.emailInput(context),
                              ),
                              const SizedBox(height: 5),
                              TextFormField(
                                controller: _passwordController,
                                style: GoogleFonts.lato(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                                validator: (password) {
                                  if (password == null) {
                                    return 'Please enter your password';
                                  }
                                  if (password.length < 6) {
                                    return 'Password too short. Should be larger than 6 characters';
                                  }
                                  return null;
                                },
                                obscuringCharacter: '*',
                                obscureText: isObsecure,
                                decoration: InputThemes.passwordInput(
                                  context,
                                  isObsecure,
                                  hidePassword,
                                ),
                              ),
                              if (state.error != null) ...[
                                const SizedBox(height: 5),
                                RichText(
                                  text: TextSpan(
                                    text: state.error.toString(),
                                    style: GoogleFonts.kanit(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.of(context)
                                                .pushNamed('/reset-password');
                                          },
                                        text: "",
                                        style: GoogleFonts.kanit(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                              const SizedBox(height: 5),
                              AppButtons.blueButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context
                                        .read<AuthBloc>()
                                        .add(SignUpRequested(
                                          _emailController.value.text,
                                          _passwordController.value.text,
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
                                          "Sign Up",
                                          style: GoogleFonts.kanit(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        AppButtons.defButton(
                          onPressed: () {
                            context
                                .read<AuthBloc>()
                                .add(SignInWithGoogleRequested());
                          },
                          color: Colors.blue.shade600,
                          child: SizedBox(
                            width: double.maxFinite,
                            child: state.status == AuthStatus.loading
                                ? LoadingAnimationWidget.fourRotatingDots(
                                    color: AppColors.primaryWhite,
                                    size: 20,
                                  )
                                : Text(
                                    "Sign In With Google",
                                    style: GoogleFonts.kanit(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        RichText(
                          text: TextSpan(
                            text: "got an account?",
                            style: GoogleFonts.kanit(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).pushNamed('/signin');
                                  },
                                text: " SIGN IN",
                                style: GoogleFonts.kanit(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
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
