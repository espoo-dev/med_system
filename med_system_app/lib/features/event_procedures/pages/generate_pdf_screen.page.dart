import 'package:distrito_medico/features/event_procedures/store/event_procedure.store.dart';
import 'package:distrito_medico/features/pdf/pdf_screen.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class EventProcedureGeneratePdfPage extends StatefulWidget {
  const EventProcedureGeneratePdfPage({super.key});

  @override
  State<EventProcedureGeneratePdfPage> createState() =>
      _EventProcedureGeneratePdfPageState();
}

class _EventProcedureGeneratePdfPageState
    extends State<EventProcedureGeneratePdfPage> {
  final _store = GetIt.I.get<EventProcedureStore>();

  @override
  void initState() {
    super.initState();
    _store.generatePdfReportForEventProcedure();
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
                      pdfPath: _store.pdfPath!,
                      title: 'Relatório de procedimento'),
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
