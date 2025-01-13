import 'package:distrito_medico/features/medical_shifts/store/medical_shift.store.dart';
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
  final _store = GetIt.I.get<MedicalShiftStore>();

  @override
  void initState() {
    super.initState();
    _store.generatePdfReportForMedicalShifts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_) {
          if (_store.pdfState == PdfReportState.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_store.pdfState == PdfReportState.success) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => PdfViewerScreen(
                      pdfPath: _store.pdfPath!, title: 'Relatório de plantões'),
                ),
              );
            });

            return const Center(child: CircularProgressIndicator());
          }

          if (_store.pdfState == PdfReportState.error) {
            return Center(
              child: Text(_store.pdfErrorMessage),
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
