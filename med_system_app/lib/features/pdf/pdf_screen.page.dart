import 'package:distrito_medico/features/pdf/store/pdf_viewer.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get_it/get_it.dart';
import 'package:share_plus/share_plus.dart';

class PdfViewerScreen extends StatefulWidget {
  final String pdfPath;
  final String title;

  const PdfViewerScreen(
      {super.key, required this.pdfPath, required this.title});

  @override
  // ignore: library_private_types_in_public_api
  _PdfViewerScreenState createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  final PdfViewerStore _pdfViewerStore = GetIt.I.get<PdfViewerStore>();

  @override
  void initState() {
    super.initState();
    _pdfViewerStore.setPdfPath(widget.pdfPath);
  }

  @override
  void dispose() {
    _pdfViewerStore.deletePdf();
    super.dispose();
  }

  Future<void> sharePdf(XFile pdfFile, Rect? sharePositionOrigin) async {
    try {
      await Share.shareXFiles(
        [pdfFile],
        text: "Relatório de procedimento",
        sharePositionOrigin: sharePositionOrigin,
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro ao compartilhar o PDF.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Builder(builder: (context) {
            return IconButton(
              icon: const Icon(Icons.share),
              onPressed: () async {
                final box = context.findRenderObject() as RenderBox?;
                final sharePositionOrigin =
                    box != null ? box.localToGlobal(Offset.zero) & box.size : null;
                final pdfFile = XFile(widget.pdfPath);
                await sharePdf(pdfFile, sharePositionOrigin);
              },
            );
          }),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: PDFView(
              filePath: widget.pdfPath,
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: false,
              pageFling: false,
              pageSnap: false,
              fitPolicy: FitPolicy.BOTH,
              preventLinkNavigation: false,
            ),
          ),
        ],
      ),
    );
  }
}
