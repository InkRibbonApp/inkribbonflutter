import 'package:flutter/material.dart';
import 'package:flutter_hackathon/widgets/typewriter_key.dart';
import 'package:flutter_hackathon/widgets/typewriter_keyboard.dart';

class TypewriterKeyboardCaps extends StatelessWidget {
  TypewriterKeyboardCaps({@required this.typewriterKeyboardController});

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
                  _buildBackspaceKey(),
                ],
              ),
              Row(
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
                  _buildEnterKey(),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildShiftKey(),
                  _buildLetterKey('z-cap', 'Z'),
                  _buildLetterKey('x-cap', 'X'),
                  _buildLetterKey('c-cap', 'C'),
                  _buildLetterKey('v-cap', 'V'),
                  _buildLetterKey('b-cap', 'B'),
                  _buildLetterKey('n-cap', 'N'),
                  _buildLetterKey('m-cap', 'M'),
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
                  _buildThickLetterKey('down_arrow', () {
                    typewriterKeyboardController.setTypewriterState(
                        TypewriterState(isOpen: false, type: typewriterKeyboardController.state.type));
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
      key: UniqueKey(),
      height: 45,
      width: width,
      padding: EdgeInsets.only(left: 4, right: 4, bottom: 4),
      assetName: 'assets/keyboard/$key.png',
      soundAsset: soundAsset,
      onTap: onTap,
    );
  }
}
