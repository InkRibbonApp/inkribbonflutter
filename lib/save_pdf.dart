import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

Future<File> createPDF(String typeWriterText, String filename) async {
  final Document pdf = Document();
  pdf.addPage(Page(
      pageFormat: PdfPageFormat.a4,
      theme: Theme.withFont(
        base: Font.ttf(await rootBundle.load("assets/uwch.ttf")),
        bold: Font.ttf(await rootBundle.load("assets/uwch.ttf")),
        italic: Font.ttf(await rootBundle.load("assets/uwch.ttf")),
        boldItalic: Font.ttf(await rootBundle.load("assets/uwch.ttf")),
      ),
      build: (Context context) {
        return Center(
          child: Text(
              typeWriterText,
              style: TextStyle(fontSize: 22)
          ),
        ); // Center
      }));
  var output = await getExternalStorageDirectory();
  final file = File('${output.path}/${filename}.pdf');
  file.writeAsBytesSync(pdf.save());
  return file;
}