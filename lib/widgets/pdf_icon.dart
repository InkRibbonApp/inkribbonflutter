import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PdfIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final icon = (!kIsWeb && Platform.isAndroid) ? Icons.share : CupertinoIcons.share;

    return Icon(icon);
  }
}
