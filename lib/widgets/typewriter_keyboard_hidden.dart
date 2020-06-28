import 'package:flutter/material.dart';
import 'package:flutter_hackathon/widgets/typewriter_key.dart';
import 'package:flutter_hackathon/widgets/typewriter_keyboard.dart';

class TypewriterKeyboardHidden extends StatelessWidget {
  TypewriterKeyboardHidden({@required this.typewriterKeyboardController});

  final TypewriterKeyboardController typewriterKeyboardController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildLetterKey('up_arrow'),
          ),
        ],
      ),
    );
  }

  Widget _buildLetterKey(String key) {
    return TypewriterKey(
      height: 50,
      width: 80,
      padding: EdgeInsets.all(0),
      assetName: 'assets/keyboard/$key.png',
      onTap: () {
        typewriterKeyboardController
            .setTypewriterState(TypewriterState(isOpen: true, type: typewriterKeyboardController.state.type));
      },
    );
  }
}
