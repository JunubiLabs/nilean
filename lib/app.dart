import 'package:buai/blocs/chat/chat_bloc.dart';
import 'package:buai/ui/pages/auth/complete_signup_page.dart';
import 'package:buai/ui/pages/auth/email_verification_page.dart';
import 'package:buai/ui/pages/auth/reset_password_page.dart';
import 'package:buai/ui/pages/auth/signup_page.dart';
import 'package:buai/ui/pages/chat/chat_page.dart';
import 'package:buai/ui/pages/chat/my_chats.dart';
import 'package:buai/ui/pages/translate/translate_page.dart';
import 'package:buai/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buai/blocs/auth/auth_bloc.dart';
import 'package:buai/repositories/auth_repository.dart';
import 'package:buai/ui/pages/home/home_page.dart';
import 'package:buai/ui/pages/splash_page.dart';
import 'package:buai/ui/pages/welcome_page.dart';
import 'package:buai/ui/pages/auth/signin_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(AuthRepository()),
        ),
        BlocProvider(
          create: (context) => ChatBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Buai',
        initialRoute: '/',
        routes: {
          '/': (context) => SplashPage(),
          '/auth': (context) => WelcomePage(),
          '/home': (context) => HomePage(),
          '/signin': (context) => SigninPage(),
          '/signup': (context) => SignupPage(),
          '/reset-password': (context) => ResetPasswordPage(),
          '/email-verification': (context) => EmailVerificationPage(),
          '/complete-signup': (context) => CompleteSignupPage(),
          '/chat': (context) => ChatPage(),
          '/my-chats': (context) => MyChats(),
          '/translate': (context) => TranslatePage(),
        },
        debugShowCheckedModeBanner: false,
        theme: AppThemes.light,
        darkTheme: AppThemes.dark,
        themeMode: ThemeMode.system,
      ),
    );
  }
}
