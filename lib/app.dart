import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buai/blocs/auth/auth_bloc.dart';
import 'package:buai/repositories/auth_repository.dart';
import 'package:buai/ui/pages/home_page.dart';
import 'package:buai/ui/pages/splash_page.dart';
import 'package:buai/ui/pages/welcome_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(AuthRepository()),
        ),
        // Other BLoC providers
      ],
      child: MaterialApp(
        title: 'Buai',
        initialRoute: '/',
        routes: {
          '/': (context) => SplashPage(),
          '/auth': (context) => WelcomePage(),
          '/home': (context) => HomePage(),
          // Add other routes as needed
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
