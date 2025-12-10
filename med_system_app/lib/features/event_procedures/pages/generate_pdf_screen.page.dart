import 'package:distrito_medico/features/event_procedures/presentation/viewmodels/event_procedures_list_viewmodel.dart';
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
  final _viewModel = GetIt.I.get<EventProceduresListViewModel>();

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
          if (_viewModel.isPdfLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_viewModel.pdfPath != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => PdfViewerScreen(
                      pdfPath: _viewModel.pdfPath!,
                      title: 'Relatório de procedimento'),
                ),
              );
            });

            return const Center(child: CircularProgressIndicator());
          }

          if (_viewModel.errorMessage != null) {
            return Center(
              child: Text(_viewModel.errorMessage!),
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
