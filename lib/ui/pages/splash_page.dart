import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nilean/models/user_model.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
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
      _checkAuthenticationStatus();
    });
  }

  Future<void> _checkAuthenticationStatus() async {
    Future.delayed(Duration(seconds: 2)).then((x) {
      _navigateBasedOnAuthStatus();
    });
  }

  Future<void> _navigateBasedOnAuthStatus() async {
    final navigator = Navigator.of(context);
    final connectivityResult = await Connectivity().checkConnectivity();
    final User? currentUser = FirebaseAuth.instance.currentUser;

    final userBox = await Hive.openBox('userBox');

    if (connectivityResult == ConnectivityResult.none) {
      final UserModel user = userBox.get('user');
      if (currentUser != null && user.isEmailVerified && user.name != null) {
        navigator.pushReplacementNamed('/home');
      }
      if (currentUser != null && !user.isEmailVerified) {
        navigator.pushReplacementNamed('/email-verification');
      }
      if (currentUser != null && user.isEmailVerified && user.name == null) {
        navigator.pushReplacementNamed('/complete-signup');
      }
      if (currentUser == null) {
        navigator.pushReplacementNamed('/auth');
      }
    }

    if (currentUser != null &&
        currentUser.emailVerified &&
        currentUser.displayName != null) {
      await userBox.put(
        'user',
        UserModel.fromJson({
          'uid': currentUser.uid,
          'email': currentUser.email,
          'name': currentUser.displayName,
          'registrationComplete': true,
          'isEmailVerified': true,
        }),
      );
      navigator.pushReplacementNamed('/home');
    }
    if (currentUser != null && !currentUser.emailVerified) {
      navigator.pushReplacementNamed('/email-verification');
    }
    if (currentUser != null &&
        currentUser.emailVerified &&
        currentUser.displayName == null) {
      navigator.pushReplacementNamed('/complete-signup');
    }
    if (currentUser == null) {
      navigator.pushReplacementNamed('/auth');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(_isDarkMode
                  ? 'assets/images/buai-dark.gif'
                  : 'assets/images/buai.gif'),
            ),
          ],
        ),
      ),
    );
  }
}
