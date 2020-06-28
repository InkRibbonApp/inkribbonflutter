import 'package:flutter/material.dart';

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
    if (typewriterKeyboardController.isOpen) {
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
                  setState(() {
                    typewriterKeyboardController.isOpen = false;
                  });
                },
              ),
            )
          ],
        ),
      );
    } else {
      return SizedBox(
        height: 50,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              color: Colors.red,
              child: FlatButton(
                child: Text('open it'),
                onPressed: () {
                  setState(() {
                    typewriterKeyboardController.isOpen = true;
                  });
                },
              ),
            )
          ],
        ),
      );
    }
  }
}

class TypewriterKeyboardController {
  bool isOpen = true;
}
