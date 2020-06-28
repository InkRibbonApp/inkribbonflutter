import 'package:flutter/material.dart';
import 'package:flutter_hackathon/typewriter_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var onBoardingState = await prefs.getBool("onBoardingState") ?? true;
  if(onBoardingState) { await prefs.setBool('onBoardingState', false); }
  runApp(TypewriterApp(onBoardingState));
}
