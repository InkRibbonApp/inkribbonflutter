import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hackathon/data/notes/notes_repo.dart';
import 'package:flutter_hackathon/save_pdf.dart';
import 'package:flutter_hackathon/view_pdf.dart';
import 'package:flutter_hackathon/widgets/pdf_icon.dart';
import 'package:flutter_hackathon/widgets/typewriter_keyboard.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../text_styles.dart';

class MainScreenArguments {
  final FirebaseUser user;
  final String file;

  MainScreenArguments(this.user, this.file);
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _notesRepo = NotesRepo();
  TextEditingController _textEditcontroller = TextEditingController(
    text: '',
  );
  TypewriterKeyboardController _typewriterKeyboardController;
  String _fileName = 'Note-${DateTime.now().toIso8601String()}';
  AudioCache _audioPlayer;
  Timer _autoSaveTimer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = Provider.of<AudioCache>(context, listen: false);

    _typewriterKeyboardController = TypewriterKeyboardController();
    _typewriterKeyboardController.textStream.listen(_onTextReceived);
    _typewriterKeyboardController.stateStream.listen((event) {
      _textEditcontroller.selection = TextSelection.fromPosition(
        TextPosition(offset: _textEditcontroller.text.length),
      );
    });
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ],
    );

    _autoSaveTimer = Timer.periodic(Duration(seconds: 5), (Timer t) => _autoSave());
  }

  void _autoSave() {
    final MainScreenArguments args = ModalRoute.of(context).settings.arguments;
    if (args != null && _fileName != null && args.user != null) {
      _notesRepo.uploadNote(_textEditcontroller.text, _fileName, args.user);
    }
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();

    _autoSaveTimer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final MainScreenArguments args = ModalRoute.of(context).settings.arguments;
    if (args != null && args.file != null) {
      _fileName = args.file;
      _notesRepo.getNote(args.file).then((text) {
        _textEditcontroller.text = text;
        _textEditcontroller.selection = TextSelection.fromPosition(
          TextPosition(offset: _textEditcontroller.text.length),
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  createPDF(_textEditcontroller.text, _fileName, kIsWeb).whenComplete(
                    () => {
                      getTemporaryDirectory().then(
                        (value) => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PDFScreen(
                                filename: _fileName,
                                path: value.path,
                              ),
                            ),
                          )
                        },
                      )
                    },
                  );
                },
                child: PdfIcon(),
              )),
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut().then(
                  (_) {
                    _autoSaveTimer.cancel();
                    Navigator.pushNamed(context, '/login');
                  },
                );
              },
              child: Icon(SimpleLineIcons.logout, size: 20),
            ),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
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
                        stream: _typewriterKeyboardController.stateStream,
                        builder: (context, snapshot) {
                          final keyboardShown = snapshot.data.isOpen;

                          return RawKeyboardListener(
                            focusNode: FocusNode(),
                            onKey: (key) => _handlePhysicalKey(key),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              color: Colors.transparent,
                              height: (keyboardShown) ? MediaQuery.of(context).size.height - 310 : null,
                              child: buildInkRibbonEditableText(),
                            ),
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
        typewriterKeyboardController: _typewriterKeyboardController,
      ),
    );
  }

  Image _buildBackgroundImage() {
    return Image(fit: BoxFit.fill, image: AssetImage('assets/paper/paper.png'));
  }

  EditableText buildInkRibbonEditableText() {
    return EditableText(
      controller: _textEditcontroller,
      cursorColor: Colors.black87,
      cursorOpacityAnimates: false,
      showCursor: true,
      enableInteractiveSelection: false,
      style: kTypewriterTextStyle,
      backgroundCursorColor: Colors.black,
      autofocus: true,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      minLines: 20,
      readOnly: true,
      focusNode: FocusNode(),
    );
  }

  void _handlePhysicalKey(RawKeyEvent key) {
    if (key.runtimeType == RawKeyDownEvent) {
      if (key.logicalKey.keyId == 4295426090) {
        _playSoundAccordingToKeyName("backspace");
        _onTextReceived("backspace");
      } else if (key.logicalKey.keyId == 4295426088) {
        _playSoundAccordingToKeyName("enter");
        _onTextReceived("enter");
      } else if (key.logicalKey.debugName == "Tab") {
        _playSoundAccordingToKeyName(key.data.keyLabel);
        _onTextReceived("tab");
      } else if (key.data.keyLabel.length <= 2) {
        _playSoundAccordingToKeyName(key.data.keyLabel);
        _onTextReceived(key.data.keyLabel);
      }
    }
  }

  void _onTextReceived(String text) {
    final textValue = text.toLowerCase();

    switch (textValue) {
      case 'backspace':
        _textEditcontroller.text = _textEditcontroller.text.substring(0, _textEditcontroller.text.length - 1);
        break;
      case 'enter':
        _textEditcontroller.text = _textEditcontroller.text + '\n';
        break;
      case 'tab':
        _textEditcontroller.text = _textEditcontroller.text + '  ';
        break;
      default:
        _textEditcontroller.text = _textEditcontroller.text + text;
    }

    _textEditcontroller.selection = TextSelection.fromPosition(TextPosition(offset: _textEditcontroller.text.length));
  }

  void _playSoundAccordingToKeyName(String keyName) {
    if (keyName.toLowerCase() == 'enter') {
      _audioPlayer.play('sounds/ding_sound.wav');
    } else if (keyName.toLowerCase() == 'backspace') {
      _audioPlayer.play('sounds/typing_sound_soft.wav');
    } else {
      _audioPlayer.play('sounds/typing_sound.wav');
    }
  }
}
