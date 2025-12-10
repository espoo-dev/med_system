import 'package:get_it/get_it.dart';
import 'presentation/viewmodels/pdf_viewer_viewmodel.dart';

/// Configura a injeção de dependências para a feature PDF
void setupPdfInjection(GetIt getIt) {
  // ViewModels
  getIt.registerFactory(() => PdfViewerViewModel());
}
