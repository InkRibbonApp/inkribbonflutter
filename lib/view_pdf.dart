import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:share_extend/share_extend.dart';

class PDFScreen extends StatelessWidget {

  IconData pdfSave;
  String pdf;
  String path;
  PDFScreen(String pdf, String path, IconData pdfSave) {
    this.pdf = pdf;
    this.path = path;
    this.pdfSave = pdfSave;
  }

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: AppBar(
          title: Text("Pdf"),
          actions: <Widget>[
            IconButton(
              icon: Icon(pdfSave),
              onPressed: () {
                ShareExtend.share("${(path)}/${pdf}.pdf", "file");
              },
            ),
          ],
        ),
        path: "${(path)}/${pdf}.pdf"
    );
  }
}

