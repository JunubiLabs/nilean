import 'package:nilean/blocs/chat/chat_bloc.dart';
import 'package:nilean/blocs/translate/translate_bloc.dart';
import 'package:nilean/models/news_article_model.dart';
import 'package:nilean/ui/pages/auth/complete_signup_page.dart';
import 'package:nilean/ui/pages/auth/email_verification_page.dart';
import 'package:nilean/ui/pages/auth/reset_password_page.dart';
import 'package:nilean/ui/pages/auth/signup_page.dart';
import 'package:nilean/ui/pages/chat/chat_page.dart';
import 'package:nilean/ui/pages/chat/my_chats.dart';
import 'package:nilean/ui/pages/news/news_page.dart';
import 'package:nilean/ui/pages/news/single_news_page.dart';
import 'package:nilean/ui/pages/translate/translate_page.dart';
import 'package:nilean/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilean/blocs/auth/auth_bloc.dart';
import 'package:nilean/repositories/auth_repository.dart';
import 'package:nilean/ui/pages/home/home_page.dart';
import 'package:nilean/ui/pages/splash_page.dart';
import 'package:nilean/ui/pages/welcome_page.dart';
import 'package:nilean/ui/pages/auth/signin_page.dart';

class App extends StatelessWidget {
  const App({super.key});
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(AuthRepository())),
        BlocProvider(create: (context) => ChatBloc()),
        BlocProvider(create: (context) => TranslateBloc()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Nilean',
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
          '/news': (context) => NewsPage(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/article') {
            final article = settings.arguments as NewsArticleModel;
            return MaterialPageRoute(
              builder: (context) => SingleNewsPage(news: article),
            );
          }
          return null;
        },
        debugShowCheckedModeBanner: false,
        theme: AppThemes.light,
        darkTheme: AppThemes.dark,
        themeMode: ThemeMode.system,
      ),
    );
  }
}
