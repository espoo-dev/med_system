import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:med_system_app/core/utils/ui.dart';
import 'package:med_system_app/core/widgets/error.widget.dart';
import 'package:med_system_app/core/widgets/ext_fab.widget.dart';
import 'package:med_system_app/core/widgets/fab.widget.dart';
import 'package:med_system_app/core/widgets/my_app_bar.widget.dart';
import 'package:med_system_app/features/patients/model/patient.model.dart';
import 'package:med_system_app/features/patients/store/patient.store.dart';

class PatientPage extends StatefulWidget {
  const PatientPage({super.key});

  @override
  State<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {
  final _patientStore = GetIt.I.get<PatientStore>();
  List<Patient>? _listPatients = [];
  final ScrollController _scrollController = ScrollController();
  bool isFab = false;
  @override
  void initState() {
    super.initState();
    debugPrint('initstate');
    _scrollController.addListener(() {
      inifiteScrolling();
      showFabButton();
    });
    _patientStore.getAllPatients(isRefresh: true);
  }

  showFabButton() {
    if (_scrollController.offset > 50) {
      setState(() {
        isFab = true;
      });
    } else {
      setState(() {
        isFab = false;
      });
    }
  }

  inifiteScrolling() {
    var maxScroll = _scrollController.position.maxScrollExtent;
    if (maxScroll == _scrollController.offset) {
      _patientStore.getAllPatients(isRefresh: false);
    }
  }

  Future _refreshProcedures() async {
    debugPrint('refreshProcedures');
    await _patientStore.getAllPatients(isRefresh: true);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _patientStore.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Pacientes',
        hideLeading: true,
        image: null,
      ),
      floatingActionButton: isFab
          ? buildFAB(context, () {})
          : buildExtendedFAB(
              context,
              "Novo paciente",
              () {},
            ),
      body: RefreshIndicator(
        onRefresh: _refreshProcedures,
        child: Observer(
          builder: (BuildContext context) {
            if (_patientStore.state == PatientState.error) {
              return Center(
                  child: ErrorRetryWidget(
                      'Algo deu errado', 'Por favor, tente novamente', () {
                _patientStore.getAllPatients(isRefresh: true);
              }));
            }
            if (_patientStore.state == PatientState.loading &&
                _listPatients!.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            if (_patientStore.patientList.isEmpty) {
              return const Center(
                  child: Text('Você não possui pacientes cadastrados.'));
            }
            _listPatients = _patientStore.patientList;
            return Stack(
              children: [
                ListView.separated(
                    controller: _scrollController,
                    itemCount: _patientStore.state == PatientState.loading
                        ? _listPatients!.length + 1
                        : _listPatients!.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index < _listPatients!.length) {
                        Patient patient = _listPatients![index];
                        return ListTile(
                          onTap: () {},
                          title: Text(
                            patient.name ?? "",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              showAlert(
                                title: 'Excluir Paciente',
                                content:
                                    'Tem certeza que deseja excluir este paciente?',
                                textYes: 'Sim',
                                textNo: 'Não',
                                onPressedConfirm: () {},
                                onPressedCancel: () {
                                  Navigator.pop(context);
                                },
                                context: context,
                              );
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                    separatorBuilder: (_, __) => const Divider()),
              ],
            );
          },
        ),
      ),
    );
  }
}
