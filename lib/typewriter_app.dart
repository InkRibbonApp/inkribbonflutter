import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hackathon/screens/login/login_screen.dart';
import 'package:flutter_hackathon/screens/main_screen/main_screen.dart';
import 'package:flutter_hackathon/screens/onboarding/onboarding_screen.dart';
import 'package:flutter_hackathon/screens/user/user_landing_screen.dart';
import 'package:provider/provider.dart';

class TypewriterApp extends StatelessWidget {
  TypewriterApp({@required this.showOnboardingScreen, @required this.audioPlayer});

  final bool showOnboardingScreen;
  final AudioCache audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Provider<AudioCache>.value(
      value: audioPlayer,
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent),
        ),
        initialRoute: showOnboardingScreen ? '/' : '/login',
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
