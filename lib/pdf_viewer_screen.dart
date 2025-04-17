import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';

class PdfViewerScreen extends StatelessWidget {
  final String pdfPath;

  PdfViewerScreen({required this.pdfPath});

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text('PDF Viewer')),
        body: PdfViewer.asset(pdfPath),
      );
  }
}
