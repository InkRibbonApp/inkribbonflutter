import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';

class PDFScreen extends StatelessWidget {
  String pdf;
  String path;
  PDFScreen(String pdf, String path) {
    this.pdf = pdf;
    this.path = path;
  }

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: AppBar(
          title: Text("Pdf"),
        ),
        path: "${(path)}/${pdf}.pdf"
    );
  }
}

