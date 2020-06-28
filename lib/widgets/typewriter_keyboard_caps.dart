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
                _buildLetterKey('q-cap', 'Q'),
                _buildLetterKey('w-cap', 'W'),
                _buildLetterKey('e-cap', 'E'),
                _buildLetterKey('r-cap', 'R'),
                _buildLetterKey('t-cap', 'T'),
                _buildLetterKey('y-cap', 'Y'),
                _buildLetterKey('u-cap', 'U'),
                _buildLetterKey('i-cap', 'I'),
                _buildLetterKey('o-cap', 'O'),
                _buildLetterKey('p-cap', 'P'),
                _buildLetterKey('backspace', 'backspace'),
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
                _buildLetterKey('a-cap', 'A'),
                _buildLetterKey('s-cap', 'S'),
                _buildLetterKey('d-cap', 'D'),
                _buildLetterKey('f-cap', 'F'),
                _buildLetterKey('g-cap', 'G'),
                _buildLetterKey('h-cap', 'H'),
                _buildLetterKey('j-cap', 'J'),
                _buildLetterKey('k-cap', 'K'),
                _buildLetterKey('l-cap', 'L'),
                _buildEnterKey('enter', '\n'),
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
                _buildLetterKey('shift', 'shift'),
                _buildLetterKey('z-cap', 'Z'),
                _buildLetterKey('x-cap', 'X'),
                _buildLetterKey('c-cap', 'C'),
                _buildLetterKey('v-cap', 'V'),
                _buildLetterKey('b-cap', 'B'),
                _buildLetterKey('n-cap', 'N'),
                _buildLetterKey('m-cap', 'M'),
                _buildLetterKey('comma', ','),
                _buildLetterKey('dot', '.'),
                _buildLetterKey('shift', 'shift'),
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
                _buildThickLetterKey('special_1', null),
                _buildThickLetterKey('down_arrow', () {
                  typewriterKeyboardController.setTypewriterState(
                      TypewriterState(isOpen: false, type: typewriterKeyboardController.state.type));
                }),
                _buildSpaceLetterKey('space'),
                _buildThickLetterKey('down_arrow', () {
                  typewriterKeyboardController.setTypewriterState(
                      TypewriterState(isOpen: false, type: typewriterKeyboardController.state.type));
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLetterKey(String key, String text) {
    return _buildKey(50, key, () {
      typewriterKeyboardController.addText(text);
    });
  }

  Widget _buildEnterKey(String key, String text) {
    return _buildKey(80, key, () {
      typewriterKeyboardController.addText(text);
    });
  }

  Widget _buildThickLetterKey(String key, Function onTap) {
    return _buildKey(80, key, onTap);
  }

  Widget _buildSpaceLetterKey(String key) {
    return _buildKey(350, key, () {
      typewriterKeyboardController.addText(' ');
    });
  }

  Widget _buildKey(double width, String key, Function onTap) {
    return TypewriterKey(
      key: UniqueKey(),
      height: 50,
      width: width,
      assetName: 'assets/keyboard/$key.png',
      onTap: onTap,
    );
  }
}
