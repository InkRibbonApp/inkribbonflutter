import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hackathon/widgets/ink_ribbon_editable_text.dart';
import 'package:flutter_hackathon/widgets/typewriter_keyboard.dart';

import '../../text_styles.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  double xPosition = 0;
  double yPosition = 0;
  TextEditingController _textEditcontroller = TextEditingController(
    text: '',
  );
  TypewriterKeyboardController _keyboardController;

  @override
  void initState() {
    super.initState();
    _keyboardController = TypewriterKeyboardController();
    _keyboardController.textStream.listen(_onTextReceived);
    _keyboardController.stateStream.listen((event) {
      _textEditcontroller.selection = TextSelection.fromPosition(TextPosition(offset: _textEditcontroller.text.length));
    });
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
              padding: const EdgeInsets.fromLTRB(40.0, 20, 40.0, 10.0),
              child: Stack(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: _buildBackgroundImage()),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 20, 16.0, 0),
                    child: StreamBuilder<TypewriterState>(
                        initialData: TypewriterState(isOpen: true, type: KeyboardType.CAPS),
                        stream: _keyboardController.stateStream,
                        builder: (context, snapshot) {
                          final keyboardShown = snapshot.data.isOpen;

                          return Container(
                            width: MediaQuery.of(context).size.width,
                            color: Colors.transparent,
                            height: (keyboardShown) ? MediaQuery.of(context).size.height - 280 : null,
                            child: buildInkRibbonEditableText(),
                          );
                        }),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: TypewriterKeyboard(
        typewriterKeyboardController: _keyboardController,
      ),
    );
  }

  Image _buildBackgroundImage() {
    return Image(fit: BoxFit.fill, image: AssetImage('assets/paper/paper.png'));
  }

  InkRibbonEditableText buildInkRibbonEditableText() {
    return InkRibbonEditableText(
      key: ValueKey('$xPosition$yPosition'),
      controller: _textEditcontroller,
      cursorColor: Colors.black87,
      cursorOpacityAnimates: false,
      showCursor: true,
      enableInteractiveSelection: false,
      style: kTypewriterTextStyle,
      backgroundCursorColor: Colors.black,
      hideSoftKeyboard: true,
      autofocus: true,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      minLines: 20,
      focusNode: FocusNode(),
    );
  }

  void _onTextReceived(String text) {
    if (text == 'backspace') {
      _textEditcontroller.text = _textEditcontroller.text.substring(0, _textEditcontroller.text.length - 1);
    } else {
      _textEditcontroller.text = _textEditcontroller.text + text;
    }
    _textEditcontroller.selection = TextSelection.fromPosition(TextPosition(offset: _textEditcontroller.text.length));
  }
}
