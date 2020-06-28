import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hackathon/screens/login/login_screen.dart';
import 'package:flutter_hackathon/screens/main_screen/main_screen.dart';
import 'package:flutter_hackathon/screens/onboarding/onboarding_screen.dart';
import 'package:flutter_hackathon/screens/user/user_landing_screen.dart';
import 'package:provider/provider.dart';

class TypewriterApp extends StatelessWidget {
  static AudioCache player = AudioCache();

  bool shouldShowOnboard;
  TypewriterApp(this.shouldShowOnboard);

  @override
  Widget build(BuildContext context) {
    return Provider<AudioCache>.value(
      value: player,
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent),
        ),
        initialRoute: shouldShowOnboard ? '/' : '/login',
        routes: {
          '/': (context) => OnboardingScreen(),
          '/login': (context) => LoginScreen(),
          '/main': (context) => MainScreen(),
          '/user': (context) => UserLandingScreen(),
        },
      ),
    );
  }
}
