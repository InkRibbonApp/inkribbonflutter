import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

Future<File> createPDF(String typeWriterText, String filename) async {
  final Document pdf = Document();
  pdf.addPage(Page(
      pageFormat: PdfPageFormat.a4,
      build: (Context context) {
        return Center(
          child: Text(
              typeWriterText,
              style: TextStyle(fontSize: 22)
          ),
        ); // Center
      }));
  var output = await getTemporaryDirectory();
  final file = File('${output.path}/${filename}.pdf');
  file.writeAsBytesSync(pdf.save());
  return file;
}