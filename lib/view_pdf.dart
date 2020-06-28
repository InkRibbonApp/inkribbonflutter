import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider/path_provider.dart';

class PDFScreen extends StatelessWidget {
  final String PDFname;
  PDFScreen({this.PDFname});

  var output = getTemporaryDirectory();

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        path: "${(output)}/${PDFname}.pdf");
  }
}