import 'package:flutter/material.dart';
import 'package:flutter_hackathon/screens/login/login_screen.dart';
import 'package:flutter_hackathon/screens/onboarding/onboarding_page_one.dart';
import 'package:flutter_hackathon/screens/onboarding/onboarding_page_three.dart';
import 'package:flutter_hackathon/screens/onboarding/onboarding_page_two.dart';
import 'package:page_turn/page_turn.dart';

class OnboardingScreenRetro extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreenRetro> with TickerProviderStateMixin {
  final _pageController = GlobalKey<PageTurnState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            PageTurn(
              key: _pageController,
              backgroundColor: Colors.orange.shade300,
              showDragCutoff: false,
              children: <Widget>[
                OnboardingPageOne(),
                OnboardingPageTwo(),
                OnboardingPageThree(),
                LoginScreen(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
