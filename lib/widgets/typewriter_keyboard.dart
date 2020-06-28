import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hackathon/widgets/typewriter_keyboard_caps.dart';
import 'package:flutter_hackathon/widgets/typewriter_keyboard_hidden.dart';
import 'package:flutter_hackathon/widgets/typewriter_keyboard_lower_case.dart';
import 'package:flutter_hackathon/widgets/typewriter_keyboard_special_one.dart';
import 'package:flutter_hackathon/widgets/typewriter_keyboard_special_two.dart';

class TypewriterKeyboard extends StatefulWidget {
  TypewriterKeyboard({this.typewriterKeyboardController});

  final TypewriterKeyboardController typewriterKeyboardController;

  @override
  _TypewriterKeyboardState createState() => _TypewriterKeyboardState();
}

class _TypewriterKeyboardState extends State<TypewriterKeyboard> {
  TypewriterKeyboardController typewriterKeyboardController;

  @override
  void initState() {
    typewriterKeyboardController = widget.typewriterKeyboardController ?? TypewriterKeyboardController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TypewriterState>(
      initialData: TypewriterState(isOpen: true, type: KeyboardType.CAPS),
      stream: typewriterKeyboardController.stateStream,
      builder: (context, snapshot) {
        final state = snapshot.data;
        if (state.isOpen) {
          switch (state.type) {
            case KeyboardType.CAPS:
              return _buildCapsKeyboard();
            case KeyboardType.LOWER_CASE:
              return _buildlowerCaseKeyboard();
            case KeyboardType.SPECIAL_1:
              return _buildSpecialOneKeyboard();
            case KeyboardType.SPECIAL_2:
              return _buildSpecialTwoKeyboard();
            default:
              return SizedBox(
                height: 30,
              );
          }
        } else {
          return _buildHiddenKeyboard();
        }
      },
    );
  }

  Widget _buildHiddenKeyboard() {
    return TypewriterKeyboardHidden(
      typewriterKeyboardController: typewriterKeyboardController,
    );
  }

  Widget _buildCapsKeyboard() {
    return TypewriterKeyboardCaps(
      typewriterKeyboardController: typewriterKeyboardController,
    );
  }

  Widget _buildlowerCaseKeyboard() {
    return TypewriterKeyboardLowerCase(
      typewriterKeyboardController: typewriterKeyboardController,
    );
  }

  Widget _buildSpecialOneKeyboard() {
    return TypewriterKeyboardSpecialOne(
      typewriterKeyboardController: typewriterKeyboardController,
    );
  }

  Widget _buildSpecialTwoKeyboard() {
    return TypewriterKeyboardSpecialTwo(
      typewriterKeyboardController: typewriterKeyboardController,
    );
  }
}

class TypewriterKeyboardController {
  StreamController<TypewriterState> _streamController = StreamController.broadcast();
  StreamController<String> _streamControllerText = StreamController.broadcast();
  TypewriterState _state;

  TypewriterState get state {
    return _state;
  }

  void setTypewriterState(TypewriterState typewriterState) {
    _state = typewriterState;
    _streamController.add(typewriterState);
  }

  void addText(String text) {
    _streamControllerText.add(text);
  }

  Stream<TypewriterState> get stateStream => _streamController.stream;
  Stream<String> get textStream => _streamControllerText.stream;

  TypewriterKeyboardController() {
    _state = TypewriterState(isOpen: true, type: KeyboardType.CAPS);
  }

  void dispose() {
    _streamController.close();
  }
}

enum KeyboardType {
  CAPS,
  LOWER_CASE,
  SPECIAL_1,
  SPECIAL_2,
}

class TypewriterState {
  TypewriterState({@required this.isOpen, @required this.type});

  final bool isOpen;
  final KeyboardType type;
}
