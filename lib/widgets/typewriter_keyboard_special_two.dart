import 'package:flutter/material.dart';
import 'package:flutter_hackathon/widgets/typewriter_key.dart';
import 'package:flutter_hackathon/widgets/typewriter_keyboard.dart';

class TypewriterKeyboardSpecialTwo extends StatelessWidget {
  TypewriterKeyboardSpecialTwo({@required this.typewriterKeyboardController});

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
                  _buildLetterKey('1', '1'),
                  _buildLetterKey('2', '2'),
                  _buildLetterKey('3', '3'),
                  _buildLetterKey('4', '4'),
                  _buildLetterKey('5', '5'),
                  _buildLetterKey('6', '6'),
                  _buildLetterKey('7', '7'),
                  _buildLetterKey('8', '8'),
                  _buildLetterKey('9', '9'),
                  _buildLetterKey('0', '0'),
                  _buildBackspaceKey(),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLetterKey('open_angle', '<'),
                  _buildLetterKey('close_angle', '>'),
                  _buildLetterKey('open_curly', '{'),
                  _buildLetterKey('close_curly', '}'),
                  _buildLetterKey('open_square', '['),
                  _buildLetterKey('close_square', ']'),
                  _buildLetterKey('beta', 'β'),
                  _buildLetterKey('paragraph', '¶'),
                  _buildLetterKey('plusminus', '±'),
                  _buildEnterKey(),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildShiftKey(),
                  _buildLetterKey('double_s', '§'),
                  _buildLetterKey('copyright', '©'),
                  _buildLetterKey('registered', '®'),
                  _buildLetterKey('14', '¼'),
                  _buildLetterKey('12', '½'),
                  _buildLetterKey('34', '¾'),
                  _buildLetterKey('caret', '^'),
                  _buildLetterKey('euro', '€'),
                  _buildLetterKey('dollar', '\$'),
                  _buildShiftKey(),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildThickLetterKey('abc', () {
                    typewriterKeyboardController
                        .setTypewriterState(TypewriterState(isOpen: true, type: KeyboardType.CAPS));
                  }),
                  _buildThickLetterKey('down_arrow', () {
                    typewriterKeyboardController.setTypewriterState(
                        TypewriterState(isOpen: false, type: typewriterKeyboardController.state.type));
                  }),
                  _buildSpaceLetterKey(),
                  _buildThickLetterKey('abc', () {
                    typewriterKeyboardController
                        .setTypewriterState(TypewriterState(isOpen: true, type: KeyboardType.CAPS));
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
          TypewriterState(isOpen: typewriterKeyboardController.state.isOpen, type: KeyboardType.LOWER_CASE));
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
