import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hackathon/typewriter_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final showOnboardingScreen = prefs.getBool("onBoardingState") ?? true;
  if (showOnboardingScreen) {
    await prefs.setBool('onBoardingState', false);
  }
  final audioPlayer = AudioCache();
  runApp(
    TypewriterApp(
      showOnboardingScreen: showOnboardingScreen,
      audioPlayer: audioPlayer,
    ),
  );
}
