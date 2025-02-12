import 'package:buai/blocs/auth/auth_bloc.dart';
import 'package:buai/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuthenticationStatus();
    });
  }

  Future<void> _checkAuthenticationStatus() async {
    Future.delayed(Duration(seconds: 3)).then((x) {
      _navigateBasedOnAuthStatus();
    });
  }

  Future<void> _navigateBasedOnAuthStatus() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null && currentUser.emailVerified) {
      Navigator.of(context).pushReplacementNamed('/home');
    }
    if (currentUser != null && !currentUser.emailVerified) {
      Navigator.of(context).pushReplacementNamed('/complete-signup');
    } else {
      Navigator.of(context).pushReplacementNamed('/auth');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryBlue,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          print(state.status);
          if (state.status == AuthStatus.unauthenticated) {
            Navigator.of(context).pushReplacementNamed('/home');
          }
          if (state.status == AuthStatus.unverified) {
            Navigator.of(context).pushReplacementNamed('/complete-signup');
          }
          if (state.status == AuthStatus.registrationIncomplete) {
            Navigator.of(context).pushReplacementNamed('/complete-signup');
          }
          if (state.status == AuthStatus.authenticated) {
            Navigator.of(context).pushReplacementNamed('/home');
          }
        },
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(image: AssetImage('assets/images/buai.png')),
            ],
          ),
        ),
      ),
    );
  }
}
