import 'dart:io';
import 'dart:math';

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

void main() {
  runApp(MaterialApp(
    home: pdf(),
    debugShowCheckedModeBanner: false,
  ));
}

class pdf extends StatefulWidget {
  @override
  State<pdf> createState() => _pdfState();
}

class _pdfState extends State<pdf> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ElevatedButton(
          onPressed: () async {
            PdfDocument document = PdfDocument();
            PdfPage page = document.pages.add();

            page.graphics.drawString(
              'Hello',
              PdfStandardFont(PdfFontFamily.helvetica, 14),
              brush: PdfSolidBrush(
                PdfColor(0, 0, 0),
              ),
              bounds: Rect.fromLTWH(0, 0, 150, 20),
            );
            var path = await ExternalPath.getExternalStoragePublicDirectory(
                    ExternalPath.DIRECTORY_DOWNLOADS) +
                '/hmr';

            Directory dir = Directory(path);

            if (!await dir!.exists()) {
              dir.create();
            }

            File f = File("${dir.path}/mypdg${Random().nextInt(100)}.pdf");
            f.writeAsBytes(await document.save());
            OpenFile.open(f.path);
            document.dispose();
            setState(() {});
          },
          child: Text("Submit")),
    );
  }
}
