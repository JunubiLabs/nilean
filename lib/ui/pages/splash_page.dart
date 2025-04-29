import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
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
      firstTimeOpen();
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
    final bool isConnected =
        await InternetConnectionChecker.instance.hasConnection;
    final User? currentUser = FirebaseAuth.instance.currentUser;
    final userBox = await Hive.openBox('user');

    if (!isConnected) {
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
        if (await firstTimeOpen()) {
          navigator.pushReplacementNamed('/home');
        } else {
          navigator.pushReplacementNamed('/auth');
        }
      }
    }

    if (currentUser != null &&
        currentUser.emailVerified &&
        currentUser.displayName != null) {
      await userBox.put(
        'user',
        UserModel(
          uid: currentUser.uid,
          email: currentUser.email.toString(),
          name: currentUser.displayName,
          registrationComplete: true,
          isEmailVerified: true,
        ),
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

  Future<bool> firstTimeOpen() async {
    final firstTime = await Hive.openBox('first_time');
    if (firstTime.get('first_time') == null) {
      firstTime.put('first_time', true);
      return true;
    } else {
      return false;
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
