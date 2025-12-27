import 'package:distrito_medico/features/medical_shifts/presentation/viewmodels/medical_shifts_list_viewmodel.dart';
import 'package:distrito_medico/features/pdf/pdf_screen.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class MedicalShiftGeneratePdfPage extends StatefulWidget {
  const MedicalShiftGeneratePdfPage({super.key});

  @override
  State<MedicalShiftGeneratePdfPage> createState() =>
      _MedicalShiftGeneratePdfPageState();
}

class _MedicalShiftGeneratePdfPageState
    extends State<MedicalShiftGeneratePdfPage> {
  final _viewModel = GetIt.I.get<MedicalShiftsListViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.generatePdf();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_) {
          if (_viewModel.isGeneratingPdf) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_viewModel.pdfPath != null) {
            // Use local variable to avoid infinite build loop if observable triggers re-build
            // But postFrameCallback ensures it runs once per frame.
            // Ideally we should clear pdfPath after navigation or use a one-off event.
            // But since we stick to existing flow:
            
            WidgetsBinding.instance.addPostFrameCallback((_) {
              // Ensure we don't navigate if widget is disposed or already navigating?
              if (mounted) {
                 Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PdfViewerScreen(
                        pdfPath: _viewModel.pdfPath!, title: 'Relatório de plantões'),
                  ),
                ).then((_) {
                   // Clear pdfPath when coming back? 
                   // This pushes replacement, so we don't come back here.
                   // We go back to previous screen from PdfViewer?
                   // No, PushReplacement replaces THIS screen (loading screen) with PdfViewer.
                   // So we are good.
                });
              }
            });

            return const Center(child: CircularProgressIndicator());
          }

          if (_viewModel.errorMessage.isNotEmpty && !_viewModel.isGeneratingPdf) {
            return Center(
              child: Text(_viewModel.errorMessage),
            );
          }
          
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
