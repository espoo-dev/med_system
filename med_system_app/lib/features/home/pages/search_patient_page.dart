import 'package:distrito_medico/core/widgets/my_app_bar.widget.dart';
import 'package:distrito_medico/features/event_procedures/pages/edit_event_procedure_page.dart';
import 'package:distrito_medico/features/event_procedures/pages/generate_pdf_screen.page.dart';
import 'package:distrito_medico/features/event_procedures/store/event_procedure.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:distrito_medico/core/theme/icons.dart';
import 'package:distrito_medico/core/utils/navigation_utils.dart';

class SearchPatientPage extends StatefulWidget {
  final String? initialQuery;
  const SearchPatientPage({super.key, this.initialQuery});

  @override
  State<SearchPatientPage> createState() => _SearchPatientPageState();
}

class _SearchPatientPageState extends State<SearchPatientPage> {
  final _store = GetIt.I.get<EventProcedureStore>();
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialQuery != null) {
      _searchController.text = widget.initialQuery!;
      _store.patientName = widget.initialQuery;
      _store.getAllEventProceduresByFilters();
    } else {
      _store.eventProcedureList.clear();
      _store.patientName = null;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Buscar Paciente',
        image: null,
        trailingIcons: const [
          Icon(Icons.description),
        ],
        onTrailingPressed: [
          () => push(
                context,
                const EventProcedureGeneratePdfPage(),
              ),
        ],
        onPressed: () {
          _store.patientName = null;
          Navigator.of(context).pop();
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Digite o nome do paciente...',
                prefixIcon: Icon(Icons.search, color: Theme.of(context).colorScheme.primary),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear, color: Theme.of(context).colorScheme.primary),
                  onPressed: () {
                    _searchController.clear();
                    _store.patientName = null;
                    _store.eventProcedureList.clear();
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onSubmitted: (val) {
                _store.patientName = val;
                _store.getAllEventProceduresByFilters();
              },
            ),
          ),
          Expanded(
            child: Observer(
              builder: (_) {
                if (_store.state == EventProcedureState.loading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (_store.eventProcedureList.isEmpty) {
                  if (_store.patientName == null || _store.patientName!.isEmpty) {
                    return const Center(child: Text('Digite um nome para buscar.'));
                  }
                  return const Center(child: Text('Nenhum procedimento encontrado.'));
                }

                return ListView.separated(
                  padding: const EdgeInsets.only(bottom: 20),
                  itemCount: _store.eventProcedureList.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final item = _store.eventProcedureList[index];
                    return ListTile(
                      onTap: () {
                        to(context, EditEventProcedurePage(eventProcedures: item));
                      },
                      leading: SvgPicture.asset(
                        item.paid! ? iconCheckCoreAsset : iconCloseCoreAsset,
                        width: 32,
                        height: 32,
                        colorFilter: ColorFilter.mode(
                          item.paid!
                              ? Theme.of(context).colorScheme.primary
                              : const Color(0xFFEC2A58),
                          BlendMode.srcIn,
                        ),
                      ),
                      title: Text(
                        item.patient ?? "",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.procedure ?? "", maxLines: 1, overflow: TextOverflow.ellipsis),
                          Row(
                            children: [
                              Text(item.healthInsurance ?? "", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                              const SizedBox(width: 10),
                              Text(item.date ?? "", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                      trailing: Text(
                        item.totalAmountCents ?? "",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
