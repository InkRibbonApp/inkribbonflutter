import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hackathon/screens/main_screen/ink_ribbon_editable_text.dart';
import 'package:flutter_hackathon/widgets/typewriter_keyboard.dart';

import '../../typewriter_app.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  double xPosition = 0;
  double yPosition = 0;
  TextEditingController _controller = TextEditingController(
    text: '',
  );

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
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
              child: Stack(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: _buildBackgroundImage()),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 30.0, 16.0, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.transparent,
                      child: buildInkRibbonEditableText(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: TypewriterKeyboard(),
    );
  }

  Image _buildBackgroundImage() {
    return Image(fit: BoxFit.fill, image: AssetImage('assets/paper/paper.png'));
  }

  InkRibbonEditableText buildInkRibbonEditableText() {
    return InkRibbonEditableText(
      key: ValueKey('$xPosition$yPosition'),
      controller: _controller,
      cursorColor: Colors.black,
      cursorOpacityAnimates: false,
      enableInteractiveSelection: false,
      style: TextStyle(fontStyle: FontStyle.normal, fontSize: 20.0, color: Colors.black),
      backgroundCursorColor: Colors.black,
      hideSoftKeyboard: true,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      minLines: 20,
      focusNode: FocusNode(),
    );
  }
}
