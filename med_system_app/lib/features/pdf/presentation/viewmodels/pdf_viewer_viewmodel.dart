import 'package:mobx/mobx.dart';

part 'pdf_viewer_viewmodel.g.dart';

class PdfViewerViewModel = _PdfViewerViewModelBase with _$PdfViewerViewModel;

abstract class _PdfViewerViewModelBase with Store {
  @observable
  String? pdfPath;

  @action
  void setPdfPath(String path) {
    pdfPath = path;
  }

  @action
  void clearPdfPath() {
    pdfPath = null;
  }
}
