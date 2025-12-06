import 'package:distrito_medico/core/utils/navigation_utils.dart';
import 'package:distrito_medico/core/utils/ui.dart';
import 'package:distrito_medico/core/widgets/error.widget.dart';
import 'package:distrito_medico/core/widgets/ext_fab.widget.dart';
import 'package:distrito_medico/core/widgets/fab.widget.dart';
import 'package:distrito_medico/core/widgets/my_app_bar.widget.dart';
import 'package:distrito_medico/core/widgets/my_toast.widget.dart';
import 'package:distrito_medico/features/patients/domain/entities/patient_entity.dart';
import 'package:distrito_medico/features/patients/pages/add_patient_page.dart';
import 'package:distrito_medico/features/patients/pages/edit_patient_page.dart';
import 'package:distrito_medico/features/patients/presentation/viewmodels/patient_list_viewmodel.dart';
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

class _PatientPageState extends State<PatientPage> {
  final _viewModel = GetIt.I.get<PatientListViewModel>();
  final ScrollController _scrollController = ScrollController();
  bool isFab = false;
  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      infiniteScrolling();
      showFabButton();
    });
    _viewModel.loadPatients(refresh: true);
  }

  void showFabButton() {
    if (_scrollController.offset > 50) {
      if (!isFab) {
        setState(() {
          isFab = true;
        });
      }
    } else {
      if (isFab) {
        setState(() {
          isFab = false;
        });
      }
    }
  }

  void infiniteScrolling() {
    var maxScroll = _scrollController.position.maxScrollExtent;
    if (maxScroll == _scrollController.offset) {
      _viewModel.loadPatients(refresh: false);
    }
  }

  Future<void> _refreshPatients() async {
    await _viewModel.loadPatients(refresh: true);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _disposers.add(reaction<DeletePatientState>(
      (_) => _viewModel.deleteState,
      (state) {
        if (state == DeletePatientState.success) {
          CustomToast.show(
            context,
            type: ToastType.success,
            title: "Exclusão de paciente",
            description: "Paciente excluído com sucesso!",
          );
          _viewModel.resetDeleteState();
        } else if (state == DeletePatientState.error) {
          CustomToast.show(
            context,
            type: ToastType.error,
            title: "Exclusão de paciente",
            description: _viewModel.errorMessage.isNotEmpty
                ? _viewModel.errorMessage
                : "Ocorreu um erro ao tentar excluir paciente.",
          );
          _viewModel.resetDeleteState();
        }
      },
    ));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    for (var disposer in _disposers) {
      disposer();
    }
    // Não damos dispose no ViewModel aqui pois ele é um Singleton
    // Mas podemos resetar o estado se necessário
    // _viewModel.dispose();
    super.dispose();
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
        onRefresh: _refreshPatients,
        child: Observer(
          builder: (BuildContext context) {
            if (_viewModel.state == PatientListState.error &&
                _viewModel.patients.isEmpty) {
              return Center(
                child: ErrorRetryWidget(
                  'Algo deu errado',
                  'Por favor, tente novamente',
                  () {
                    _viewModel.loadPatients(refresh: true);
                  },
                ),
              );
            }

            if (_viewModel.state == PatientListState.loading &&
                _viewModel.patients.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (_viewModel.patients.isEmpty &&
                _viewModel.state == PatientListState.success) {
              return const Center(
                child: Text('Você não possui pacientes cadastrados.'),
              );
            }

            return Stack(
              children: [
                SlidableAutoCloseBehavior(
                  closeWhenOpened: true,
                  child: ListView.separated(
                    controller: _scrollController,
                    itemCount: _viewModel.state == PatientListState.loading
                        ? _viewModel.patients.length + 1
                        : _viewModel.patients.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index < _viewModel.patients.length) {
                        PatientEntity patient = _viewModel.patients[index];
                        return Slidable(
                          key: ValueKey(patient.id),
                          endActionPane: ActionPane(
                            motion: const BehindMotion(),
                            children: [
                              SlidableAction(
                                backgroundColor: Colors.red,
                                icon: Icons.delete,
                                label: 'Deletar',
                                onPressed: (context) {
                                  if (patient.deletable) {
                                    showAlert(
                                      context: context,
                                      title: 'Excluir Paciente',
                                      content:
                                          'Tem certeza que deseja excluir este paciente?',
                                      textYes: 'Sim',
                                      textNo: 'Não',
                                      onPressedConfirm: () {
                                        _viewModel.deletePatient(patient.id);
                                      },
                                      onPressedCancel: () {},
                                    );
                                  } else {
                                    CustomToast.show(
                                      context,
                                      type: ToastType.error,
                                      title: "Exclusão de paciente",
                                      description:
                                          "Paciente tem procedimento vinculado.",
                                    );
                                  }
                                },
                              )
                            ],
                          ),
                          child: ListTile(
                            onTap: () {
                              to(context, EditPatientPage(patient: patient));
                            },
                            title: Text(
                              patient.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                    separatorBuilder: (_, __) => const Divider(),
                  ),
                ),
                if (_viewModel.isDeleting)
                  Container(
                    color: Colors.black26,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
