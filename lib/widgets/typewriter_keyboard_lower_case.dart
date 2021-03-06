import 'package:flutter/material.dart';
import 'package:flutter_hackathon/widgets/typewriter_key.dart';
import 'package:flutter_hackathon/widgets/typewriter_keyboard.dart';

class TypewriterKeyboardLowerCase extends StatelessWidget {
  TypewriterKeyboardLowerCase({@required this.typewriterKeyboardController});

  final TypewriterKeyboardController typewriterKeyboardController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: Colors.black87,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLetterKey('q', 'q'),
                  _buildLetterKey('w', 'w'),
                  _buildLetterKey('e', 'e'),
                  _buildLetterKey('r', 'r'),
                  _buildLetterKey('t', 't'),
                  _buildLetterKey('y', 'y'),
                  _buildLetterKey('u', 'u'),
                  _buildLetterKey('i', 'i'),
                  _buildLetterKey('o', 'o'),
                  _buildLetterKey('p', 'p'),
                  _buildBackspaceKey(),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLetterKey('a', 'a'),
                  _buildLetterKey('s', 's'),
                  _buildLetterKey('d', 'd'),
                  _buildLetterKey('f', 'f'),
                  _buildLetterKey('g', 'g'),
                  _buildLetterKey('h', 'h'),
                  _buildLetterKey('j', 'j'),
                  _buildLetterKey('k', 'k'),
                  _buildLetterKey('l', 'l'),
                  _buildEnterKey(),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildShiftKey(),
                  _buildLetterKey('z', 'z'),
                  _buildLetterKey('x', 'x'),
                  _buildLetterKey('c', 'c'),
                  _buildLetterKey('v', 'v'),
                  _buildLetterKey('b', 'b'),
                  _buildLetterKey('n', 'n'),
                  _buildLetterKey('m', 'm'),
                  _buildLetterKey('comma', ','),
                  _buildLetterKey('dot', '.'),
                  _buildShiftKey(),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildThickLetterKey('special_1', () {
                    typewriterKeyboardController
                        .setTypewriterState(TypewriterState(isOpen: true, type: KeyboardType.SPECIAL_1));
                  }),
                  _buildThickLetterKey('down_arrow', () {
                    typewriterKeyboardController.setTypewriterState(
                        TypewriterState(isOpen: false, type: typewriterKeyboardController.state.type));
                  }),
                  _buildSpaceLetterKey(),
                  _buildThickLetterKey('special_1', () {
                    typewriterKeyboardController
                        .setTypewriterState(TypewriterState(isOpen: true, type: KeyboardType.SPECIAL_1));
                  }),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildLetterKey(String key, String text) {
    return _buildKey(45, key, null, () {
      typewriterKeyboardController.addText(text);
    });
  }

  Widget _buildBackspaceKey() {
    return _buildKey(45, 'backspace', 'sounds/typing_sound_soft.wav', () {
      typewriterKeyboardController.addText('backspace');
    });
  }

  Widget _buildEnterKey() {
    return _buildKey(70, 'enter', 'sounds/ding_sound.wav', () {
      typewriterKeyboardController.addText('\n');
    });
  }

  Widget _buildThickLetterKey(String key, Function onTap) {
    return _buildKey(70, key, 'sounds/typing_sound_soft.wav', onTap);
  }

  Widget _buildShiftKey() {
    return _buildKey(45, 'shift', 'sounds/typing_sound_soft.wav', () {
      typewriterKeyboardController.setTypewriterState(
          TypewriterState(isOpen: typewriterKeyboardController.state.isOpen, type: KeyboardType.CAPS));
    });
  }

  Widget _buildSpaceLetterKey() {
    return _buildKey(350, 'space', null, () {
      typewriterKeyboardController.addText(' ');
    });
  }

  Widget _buildKey(double width, String key, String soundAsset, Function onTap) {
    return TypewriterKey(
      height: 45,
      width: width,
      padding: EdgeInsets.only(left: 4, right: 4, bottom: 4),
      assetName: 'assets/keyboard_round/$key.png',
      soundAsset: soundAsset,
      onTap: onTap,
    );
  }
}
