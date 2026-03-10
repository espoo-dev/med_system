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
    _store.selectedEventProcedureIds.clear();
    _store.pdfState = PdfReportState.idle;
    _store.hideValues = false;

    if (_store.eventProcedureList.isEmpty) {
      _store.getAllEventProcedures(isRefresh: true, perPage: 100);
    }
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
                  _store.pdfState = PdfReportState.idle;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PdfViewerScreen(
                        pdfPath: path,
                        title: 'Relatório de procedimentos',
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
                    if (_store.state == EventProcedureState.loading)
                      const Center(child: CircularProgressIndicator())
                    else if (_store.eventProcedureList.isEmpty)
                      const Text('Nenhum procedimento encontrado.')
                    else
                      ..._store.eventProcedureList.map((ep) {
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
                    onPressed: () => _store.generatePdfReportForEventProcedure(),
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
