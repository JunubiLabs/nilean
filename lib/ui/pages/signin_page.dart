import 'package:buai/blocs/auth/auth_bloc.dart';
import 'package:buai/blocs/auth/auth_state.dart';
import 'package:buai/ui/widgets/app_buttons.dart';
import 'package:buai/utils/colors.dart';
import 'package:buai/utils/input_themes.dart';
import 'package:buai/utils/input_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryYellow,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.of(context).pushNamed('/home');
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
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
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Image.asset(
                          'assets/images/login.png',
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
                        Text(
                          "Sign In",
                          style: GoogleFonts.jockeyOne(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "To continue you need to sign in",
                          style: GoogleFonts.kanit(
                            fontSize: 15,
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
                                style: GoogleFonts.lato(fontSize: 15),
                                validator: (value) {
                                  InputValidator.isValidEmail(value);
                                  return null;
                                },
                                decoration: InputThemes.emailInput(context),
                              ),
                              const SizedBox(height: 5),
                              TextFormField(
                                controller: _passwordController,
                                style: GoogleFonts.lato(fontSize: 15),
                                validator: (value) {
                                  InputValidator.isValidPassword(value);
                                  return null;
                                },
                                obscuringCharacter: '*',
                                obscureText: isObsecure,
                                decoration: InputThemes.passwordInput(
                                  context,
                                  isObsecure,
                                ),
                              ),
                              if (state is AuthError) ...[
                                RichText(
                                  text: TextSpan(
                                    text: "forgot your password?",
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
                                        text: " CLICK HERE",
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
                                onPressed: () {},
                                child: SizedBox(
                                  width: double.maxFinite,
                                  child: state is AuthLoading
                                      ? CircularProgressIndicator.adaptive()
                                      : Text(
                                          "Sign In",
                                          style: GoogleFonts.kanit(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        RichText(
                          text: TextSpan(
                            text: "need an account?",
                            style: GoogleFonts.kanit(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).pushNamed('/signup');
                                  },
                                text: " SIGN UP",
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
