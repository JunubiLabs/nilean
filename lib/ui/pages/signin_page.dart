import 'package:buai/blocs/auth/auth_bloc.dart';
import 'package:buai/blocs/auth/auth_state.dart';
import 'package:buai/ui/widgets/app_buttons.dart';
import 'package:buai/utils/input_themes.dart';
import 'package:buai/utils/input_validator.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              return Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppButtons.backButton(
                      onPressed: () {},
                      context: context,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Welcome back!",
                      style: GoogleFonts.lato(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Login to your account to continue.",
                      style: GoogleFonts.lato(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Email",
                            style: GoogleFonts.lato(
                              fontSize: 15,
                            ),
                          ),
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
                          const SizedBox(height: 10),
                          Text(
                            "Password",
                            style: GoogleFonts.lato(
                              fontSize: 15,
                            ),
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
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
