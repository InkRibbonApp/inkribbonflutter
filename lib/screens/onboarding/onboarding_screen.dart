import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hackathon/screens/onboarding/onboarding_page_one.dart';
import 'package:flutter_hackathon/screens/onboarding/onboarding_page_three.dart';
import 'package:flutter_hackathon/screens/onboarding/onboarding_page_two.dart';
import 'package:page_view_indicator/page_view_indicator.dart';
import 'package:provider/provider.dart';

import '../../text_styles.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with TickerProviderStateMixin {
  final _pageIndexNotifier = ValueNotifier<int>(0);
  PageController _pageController = PageController();
  AudioCache _audioPlayer;

  @override
  void initState() {
    _audioPlayer = Provider.of<AudioCache>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            PageView(
              physics: BouncingScrollPhysics(),
              controller: _pageController,
              onPageChanged: (index) {
                _audioPlayer.play('sounds/pageturn.wav');
                setState(() {
                  _pageIndexNotifier.value = index;
                });
                return _pageIndexNotifier.value = index;
              },
              children: [
                OnboardingPageOne(),
                OnboardingPageTwo(),
                OnboardingPageThree(),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: PageViewIndicator(
                  pageIndexNotifier: _pageIndexNotifier,
                  length: 3,
                  normalBuilder: (animationController, index) => Circle(
                    size: 8.0,
                    color: Colors.black87,
                  ),
                  highlightedBuilder: (animationController, index) => ScaleTransition(
                    scale: CurvedAnimation(
                      parent: animationController,
                      curve: Curves.ease,
                    ),
                    child: Circle(
                      size: 14.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: _buildButton(),
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildButton() {
    final pageIndex = _pageIndexNotifier.value;
    if (pageIndex == 2) {
      return FlatButton(
        child: Text(
          'NEXT',
          style: kOnboardingButtonTextStyle,
        ),
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/login');
        },
      );
    } else {
      return FlatButton(
        child: Text(
          'SKIP',
          style: kOnboardingButtonTextStyle,
        ),
        onPressed: () {
          setState(() {
            _pageController.animateToPage(2, duration: Duration(milliseconds: 200), curve: Curves.easeIn);
          });
        },
      );
    }
  }
}
