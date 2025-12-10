// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdf_viewer_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PdfViewerViewModel on _PdfViewerViewModelBase, Store {
  late final _$pdfPathAtom =
      Atom(name: '_PdfViewerViewModelBase.pdfPath', context: context);

  @override
  String? get pdfPath {
    _$pdfPathAtom.reportRead();
    return super.pdfPath;
  }

  @override
  set pdfPath(String? value) {
    _$pdfPathAtom.reportWrite(value, super.pdfPath, () {
      super.pdfPath = value;
    });
  }

  late final _$_PdfViewerViewModelBaseActionController =
      ActionController(name: '_PdfViewerViewModelBase', context: context);

  @override
  void setPdfPath(String path) {
    final _$actionInfo = _$_PdfViewerViewModelBaseActionController.startAction(
        name: '_PdfViewerViewModelBase.setPdfPath');
    try {
      return super.setPdfPath(path);
    } finally {
      _$_PdfViewerViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearPdfPath() {
    final _$actionInfo = _$_PdfViewerViewModelBaseActionController.startAction(
        name: '_PdfViewerViewModelBase.clearPdfPath');
    try {
      return super.clearPdfPath();
    } finally {
      _$_PdfViewerViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pdfPath: ${pdfPath}
    ''';
  }
}
