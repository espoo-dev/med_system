import 'dart:io';
import 'package:mobx/mobx.dart';
part 'pdf_viewer.store.g.dart';

// ignore: library_private_types_in_public_api
class PdfViewerStore = _PdfViewerStore with _$PdfViewerStore;

abstract class _PdfViewerStore with Store {
  @observable
  String? pdfPath;

  @action
  void setPdfPath(String path) {
    pdfPath = path;
  }

  @action
  Future<void> deletePdf() async {
    if (pdfPath != null) {
      try {
        final file = File(pdfPath!);
        if (await file.exists()) {
          await file.delete();
          pdfPath = null;
        }
        // ignore: empty_catches
      } catch (e) {}
    }
  }
}
