import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:flutter_hackathon/widgets/pdf_icon.dart';
import 'package:share_extend/share_extend.dart';

class PDFScreen extends StatelessWidget {
  PDFScreen({
    @required this.filename,
    @required this.path,
  });

  final String filename;
  final String path;

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: AppBar(
          title: Text("PDF"),
          actions: <Widget>[
            IconButton(
              icon: PdfIcon(),
              onPressed: () {
                ShareExtend.share("$path/$filename.pdf", "file");
              },
            ),
          ],
        ),
        path: "$path/$filename.pdf");
  }
}
