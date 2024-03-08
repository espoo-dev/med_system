import 'package:distrito_medico/core/utils/navigation_utils.dart';
import 'package:distrito_medico/core/widgets/error.widget.dart';
import 'package:distrito_medico/core/widgets/ext_fab.widget.dart';
import 'package:distrito_medico/core/widgets/fab.widget.dart';
import 'package:distrito_medico/core/widgets/my_app_bar.widget.dart';
import 'package:distrito_medico/core/widgets/my_toast.widget.dart';
import 'package:distrito_medico/features/patients/model/patient.model.dart';
import 'package:distrito_medico/features/patients/pages/add_patient_page.dart';
import 'package:distrito_medico/features/patients/pages/edit_patient_page.dart';
import 'package:distrito_medico/features/patients/store/patient.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

class PatientPage extends StatefulWidget {
  const PatientPage({super.key});

  @override
  State<PatientPage> createState() => _PatientPageState();
}

enum Actions { delete }

class _PatientPageState extends State<PatientPage> {
  final _patientStore = GetIt.I.get<PatientStore>();
  List<Patient>? _listPatients = [];
  final ScrollController _scrollController = ScrollController();
  bool isFab = false;
  final List<ReactionDisposer> _disposers = [];

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
    await _patientStore.getAllPatients(isRefresh: true);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _disposers.add(reaction<DeletePatientState>(
        (_) => _patientStore.deletePatientState, (validationState) {
      if (validationState == DeletePatientState.success) {
        CustomToast.show(context,
            type: ToastType.success,
            title: "Exclusão de paciente",
            description: "Paciente excluído com sucesso!");
      } else if (validationState == DeletePatientState.error) {
        CustomToast.show(context,
            type: ToastType.error,
            title: "Exclusão de paciente",
            description: "Ocorreu um erro ao tentar excluir paciente.");
      }
    }));
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _patientStore.dispose();
    for (var disposer in _disposers) {
      disposer();
    }
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
          ? buildFAB(context, () {
              to(context, const AddPatientPage());
            })
          : buildExtendedFAB(
              context,
              "Novo paciente",
              () {
                to(context, const AddPatientPage());
              },
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
            if (_patientStore.patientList.isEmpty &&
                _patientStore.state == PatientState.success) {
              return const Center(
                  child: Text('Você não possui pacientes cadastrados.'));
            }
            _listPatients = _patientStore.patientList;
            return Stack(
              children: [
                SlidableAutoCloseBehavior(
                  closeWhenOpened: true,
                  child: ListView.separated(
                      controller: _scrollController,
                      itemCount: _patientStore.state == PatientState.loading
                          ? _listPatients!.length + 1
                          : _listPatients!.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (index < _listPatients!.length) {
                          Patient patient = _listPatients![index];
                          return Slidable(
                            key: ValueKey(_listPatients?.length),
                            endActionPane: patient.deletable!
                                ? ActionPane(
                                    dismissible: DismissiblePane(
                                      onDismissed: () =>
                                          _onDismissed(index, Actions.delete),
                                    ),
                                    motion: const BehindMotion(),
                                    children: [
                                      SlidableAction(
                                        backgroundColor: Colors.red,
                                        icon: Icons.delete,
                                        label: 'Deletar',
                                        onPressed: (context) =>
                                            _onDismissed(index, Actions.delete),
                                      )
                                    ],
                                  )
                                : null,
                            child: ListTile(
                              onTap: () {
                                to(context, EditPatientPage(patient: patient));
                              },
                              title: Text(
                                patient.name ?? "",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                      separatorBuilder: (_, __) => const Divider()),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _onDismissed(int index, Actions action) {
    Patient patient = _listPatients![index];
    setState(() {
      _listPatients?.removeAt(index);
    });
    switch (action) {
      case Actions.delete:
        _patientStore.deletePatient(patient.id ?? 0);
        break;
    }
  }
}
