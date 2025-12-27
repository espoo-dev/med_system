import 'package:distrito_medico/core/pages/success/success.page.dart';
import 'package:distrito_medico/core/utils/navigation_utils.dart';
import 'package:distrito_medico/core/widgets/my_app_bar.widget.dart';
import 'package:distrito_medico/core/widgets/my_button_widget.dart';
import 'package:distrito_medico/core/widgets/my_text_form_field.widget.dart';
import 'package:distrito_medico/core/widgets/my_toast.widget.dart';
import 'package:distrito_medico/features/patients/domain/entities/patient_entity.dart';
import 'package:distrito_medico/features/patients/pages/patient_page.dart';
import 'package:distrito_medico/features/patients/presentation/viewmodels/patient_list_viewmodel.dart';
import 'package:distrito_medico/features/patients/presentation/viewmodels/update_patient_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

class EditPatientPage extends StatefulWidget {
  final PatientEntity patient;
  const EditPatientPage({super.key, required this.patient});

  @override
  State<EditPatientPage> createState() => _EditPatientState();
}

class _EditPatientState extends State<EditPatientPage> {
  final _viewModel = GetIt.I.get<UpdatePatientViewModel>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    super.initState();
    _viewModel.loadPatient(widget.patient);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers.add(reaction<UpdatePatientState>(
      (_) => _viewModel.state,
      (state) {
        if (state == UpdatePatientState.success) {
          // Atualiza a lista de pacientes
          GetIt.I.get<PatientListViewModel>().loadPatients(refresh: true);

          to(
            context,
            const SuccessPage(
              title: 'Paciente editado com sucesso!',
              goToPage: PatientPage(),
            ),
          );
        } else if (state == UpdatePatientState.error) {
          CustomToast.show(
            context,
            type: ToastType.error,
            title: "Editar paciente",
            description: _viewModel.errorMessage.isNotEmpty
                ? _viewModel.errorMessage
                : "Ocorreu um erro ao tentar editar.",
          );
        }
      },
    ));
  }

  @override
  void dispose() {
    for (var disposer in _disposers) {
      disposer();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) return;
        to(context, const PatientPage());
      },
      child: Scaffold(
        appBar: const MyAppBar(
          title: 'Editar Paciente',
          hideLeading: true,
          image: null,
        ),
        body: form(context),
      ),
    );
  }

  Widget form(BuildContext context) {
    return ListView(
      children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 20, top: 30),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyTextFormField(
                        initialValue: widget.patient.name,
                        fontSize: 16,
                        label: 'Nome do paciente',
                        placeholder: 'Digite o nome do paciente',
                        inputType: TextInputType.text,
                        validators: const {'required': true, 'minLength': 3},
                        onChanged: _viewModel.setName,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: Observer(
                          builder: (_) {
                            return MyButtonWidget(
                              text: 'Editar paciente',
                              isLoading: _viewModel.isLoading,
                              disabledColor: Colors.grey,
                              onTap: _viewModel.canSubmit
                                  ? () async {
                                      _formKey.currentState?.save();
                                      if (_formKey.currentState!.validate()) {
                                        await _viewModel.updatePatient();
                                      } else {
                                        CustomToast.show(
                                          context,
                                          type: ToastType.error,
                                          title: "Editar paciente",
                                          description:
                                              "Por favor, preencha os campos.",
                                        );
                                      }
                                    }
                                  : null,
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
