import 'package:distrito_medico/features/pdf/presentation/viewmodels/pdf_viewer_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late PdfViewerViewModel viewModel;

  setUp(() {
    viewModel = PdfViewerViewModel();
  });

  group('PdfViewerViewModel', () {
    test('should start with null pdfPath', () {
      // assert
      expect(viewModel.pdfPath, null);
    });

    test('setPdfPath should update pdfPath', () {
      // arrange
      const testPath = '/path/to/test.pdf';

      // act
      viewModel.setPdfPath(testPath);

      // assert
      expect(viewModel.pdfPath, testPath);
    });

    test('clearPdfPath should set pdfPath to null', () {
      // arrange
      viewModel.setPdfPath('/path/to/test.pdf');
      expect(viewModel.pdfPath, isNotNull);

      // act
      viewModel.clearPdfPath();

      // assert
      expect(viewModel.pdfPath, null);
    });

    test('setPdfPath should update pdfPath multiple times', () {
      // arrange
      const path1 = '/path/to/first.pdf';
      const path2 = '/path/to/second.pdf';

      // act & assert
      viewModel.setPdfPath(path1);
      expect(viewModel.pdfPath, path1);

      viewModel.setPdfPath(path2);
      expect(viewModel.pdfPath, path2);
    });
  });
}
