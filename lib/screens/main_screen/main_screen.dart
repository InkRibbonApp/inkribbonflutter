import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hackathon/screens/main_screen/ink_ribbon_editable_text.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ],
    );
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          color: Colors.white,
          child: InkRibbonEditableText(
            controller: TextEditingController(
              text:
                  "Look at these beautiful horses and elephants! Who brought them here",
            ),
            cursorColor: Colors.green,
            selectionColor: Colors.red,
            style: TextStyle(
                fontStyle: FontStyle.normal,
                fontSize: 30.0,
                color: Colors.black),
            backgroundCursorColor: Colors.black,
            hideSoftKeyboard: true,
            focusNode: NoKeyboardEditableTextFocusNode(),
          ),
        ),
      ),
    );
  }
}

class NoKeyboardEditableTextFocusNode extends FocusNode {
  @override
  bool consumeKeyboardToken() {
    // prevents keyboard from showing on first focus
    return false;
  }
}
