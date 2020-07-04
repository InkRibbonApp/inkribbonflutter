import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:universal_html/html.dart' as html;

Future<void> createPDF(String typeWriterText, String filename, bool kIsWeb) async {
  final Document pdf = Document();
  pdf.addPage(
    Page(
      pageFormat: PdfPageFormat.a4,
      build: (_) {
        return Text(
          typeWriterText,
          style: TextStyle(
            fontSize: 22,
            font: Font.courierBold(),
          ),
        );
      },
    ),
  );

  if (kIsWeb) {
    final blob = html.Blob([pdf.save()], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.window.open(url, "_blank");
    html.Url.revokeObjectUrl(url);
  } else {
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/$filename.pdf');
    file.createSync(recursive: true);
    file.writeAsBytesSync(pdf.save(), mode: FileMode.write, flush: true);
  }
}
