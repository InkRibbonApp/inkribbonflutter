import 'package:flutter/material.dart';
import 'package:flutter_hackathon/widgets/typewriter_key.dart';
import 'package:flutter_hackathon/widgets/typewriter_keyboard.dart';

class TypewriterKeyboardCaps extends StatelessWidget {
  TypewriterKeyboardCaps({@required this.typewriterKeyboardController});

  final TypewriterKeyboardController typewriterKeyboardController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: Colors.black87,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLetterKey('q-cap'),
                _buildLetterKey('w-cap'),
                _buildLetterKey('e-cap'),
                _buildLetterKey('r-cap'),
                _buildLetterKey('t-cap'),
                _buildLetterKey('y-cap'),
                _buildLetterKey('u-cap'),
                _buildLetterKey('i-cap'),
                _buildLetterKey('o-cap'),
                _buildLetterKey('p-cap'),
                _buildLetterKey('backspace'),
              ],
            ),
          ),
          Positioned(
            top: 60,
            left: 30,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLetterKey('a-cap'),
                _buildLetterKey('s-cap'),
                _buildLetterKey('d-cap'),
                _buildLetterKey('e-cap'),
                _buildLetterKey('g-cap'),
                _buildLetterKey('h-cap'),
                _buildLetterKey('j-cap'),
                _buildLetterKey('k-cap'),
                _buildLetterKey('l-cap'),
                _buildThickLetterKey('enter'),
              ],
            ),
          ),
          Positioned(
            top: 120,
            left: 15,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLetterKey('shift'),
                _buildLetterKey('z-cap'),
                _buildLetterKey('x-cap'),
                _buildLetterKey('c-cap'),
                _buildLetterKey('v-cap'),
                _buildLetterKey('b-cap'),
                _buildLetterKey('n-cap'),
                _buildLetterKey('m-cap'),
                _buildLetterKey('comma'),
                _buildLetterKey('dot'),
                _buildLetterKey('shift'),
              ],
            ),
          ),
          Positioned(
            top: 180,
            left: 15,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildThickLetterKey('special_1'),
                _buildThickLetterKey('down_arrow'),
                _buildSpaceLetterKey('space'),
                _buildThickLetterKey('down_arrow'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLetterKey(String key) {
    return _buildKey(50, key);
  }

  Widget _buildThickLetterKey(String key) {
    return _buildKey(80, key);
  }

  Widget _buildSpaceLetterKey(String key) {
    return _buildKey(350, key);
  }

  Widget _buildKey(double width, String key) {
    return TypewriterKey(
      height: 50,
      width: width,
      assetName: 'assets/keyboard/$key.png',
    );
  }
}
