// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdf_viewer.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PdfViewerStore on _PdfViewerStore, Store {
  late final _$pdfPathAtom =
      Atom(name: '_PdfViewerStore.pdfPath', context: context);

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

  late final _$deletePdfAsyncAction =
      AsyncAction('_PdfViewerStore.deletePdf', context: context);

  @override
  Future<void> deletePdf() {
    return _$deletePdfAsyncAction.run(() => super.deletePdf());
  }

  late final _$_PdfViewerStoreActionController =
      ActionController(name: '_PdfViewerStore', context: context);

  @override
  void setPdfPath(String path) {
    final _$actionInfo = _$_PdfViewerStoreActionController.startAction(
        name: '_PdfViewerStore.setPdfPath');
    try {
      return super.setPdfPath(path);
    } finally {
      _$_PdfViewerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pdfPath: ${pdfPath}
    ''';
  }
}
