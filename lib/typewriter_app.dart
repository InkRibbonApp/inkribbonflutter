import 'package:flutter/material.dart';
import 'package:flutter_hackathon/screens/login/login_screen.dart';
import 'package:flutter_hackathon/screens/main_screen/main_screen.dart';
import 'package:flutter_hackathon/screens/onboarding/onboarding_screen.dart';

class TypewriterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => OnboardingScreen(),
        '/login': (context) => LoginScreen(),
        '/main': (context) => MainScreen(),
      },
    );
  }
}
