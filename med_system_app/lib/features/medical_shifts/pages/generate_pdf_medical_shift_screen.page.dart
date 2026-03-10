import 'package:distrito_medico/features/event_procedures/store/event_procedure.store.dart' hide PdfReportState;
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
  final _eventStore = GetIt.I.get<EventProcedureStore>();

  @override
  void initState() {
    super.initState();
    // Default: clear selected IDs when entering the screen
    _store.selectedEventProcedureIds.clear();
    _store.pdfState = PdfReportState.idle;
    _store.hideValues = false;

    // Load procedures for the period to allow selection
    _eventStore.selectedMonth = _store.selectedMonth;
    _eventStore.selectedYear = _store.selectedYear;
    _eventStore.hospitalName = _store.hospitalName;
    _eventStore.selectedPaymentStatus = _store.selectedPaymentStatus;
    _eventStore.getAllEventProcedures(isRefresh: true, perPage: 100);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Opções do Relatório'),
      ),
      body: Observer(
        builder: (_) {
          if (_store.pdfState == PdfReportState.loading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text("Gerando relatório..."),
                ],
              ),
            );
          }

          if (_store.pdfState == PdfReportState.success) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
               if (mounted) {
                  final path = _store.pdfPath;
                  _store.pdfState = PdfReportState.idle; // Reset after navigation
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PdfViewerScreen(
                        pdfPath: path,
                        title: 'Relatório de plantões',
                      ),
                    ),
                  );
               }
            });
          }

          if (_store.pdfState == PdfReportState.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  Text(_store.pdfErrorMessage),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _store.pdfState = PdfReportState.idle,
                    child: const Text("Tentar novamente"),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    SwitchListTile(
                      title: const Text('Ocultar valores'),
                      subtitle: const Text('Não mostrar o valor de cada item no relatório'),
                      value: _store.hideValues ?? false,
                      onChanged: (val) {
                        _store.hideValues = val;
                      },
                    ),
                    const Divider(),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'Selecionar Procedimentos:',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    if (_eventStore.state == EventProcedureState.loading)
                      const Center(child: CircularProgressIndicator())
                    else if (_eventStore.eventProcedureList.isEmpty)
                      const Text('Nenhum procedimento encontrado para este período.')
                    else
                      ..._eventStore.eventProcedureList.map((ep) {
                        final isSelected = _store.selectedEventProcedureIds.contains(ep.id);
                        return CheckboxListTile(
                          title: Text(ep.patient ?? 'Sem paciente'),
                          subtitle: Text(ep.procedure ?? 'Sem procedimento'),
                          value: isSelected,
                          onChanged: (val) {
                            if (val == true) {
                              _store.selectedEventProcedureIds.add(ep.id!);
                            } else {
                              _store.selectedEventProcedureIds.remove(ep.id);
                            }
                          },
                        );
                      }),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () => _store.generatePdfReportForMedicalShifts(),
                    child: const Text('GERAR RELATÓRIO'),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
