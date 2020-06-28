import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hackathon/widgets/typewriter_keyboard_caps.dart';
import 'package:flutter_hackathon/widgets/typewriter_keyboard_hidden.dart';

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
    return SizedBox(
      height: 200,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: Colors.red,
            child: FlatButton(
              child: Text('close it'),
              onPressed: () {
                typewriterKeyboardController.streamController.add(
                  TypewriterState(isOpen: false, type: KeyboardType.CAPS),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class TypewriterKeyboardController {
  StreamController<TypewriterState> streamController = StreamController.broadcast();

  TypewriterState _state;

  TypewriterState get state {
    return _state;
  }

  Stream<TypewriterState> get stateStream => streamController.stream;

  void dispose() {
    streamController.close();
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
