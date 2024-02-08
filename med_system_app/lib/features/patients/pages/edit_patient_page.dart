import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:med_system_app/core/pages/success/success.page.dart';
import 'package:med_system_app/core/utils/navigation_utils.dart';
import 'package:med_system_app/core/widgets/my_app_bar.widget.dart';
import 'package:med_system_app/core/widgets/my_button_widget.dart';
import 'package:med_system_app/core/widgets/my_text_form_field.widget.dart';
import 'package:med_system_app/core/widgets/my_toast.widget.dart';
import 'package:med_system_app/features/patients/model/patient.model.dart';
import 'package:med_system_app/features/patients/pages/patient_page.dart';
import 'package:med_system_app/features/patients/store/edit_patient.store.dart';
import 'package:mobx/mobx.dart';

class EditPatientPage extends StatefulWidget {
  final Patient patient;
  const EditPatientPage({super.key, required this.patient});

  @override
  State<EditPatientPage> createState() => _EditPatientState();
}

class _EditPatientState extends State<EditPatientPage> {
  final editPatientStore = GetIt.I.get<EditPatientStore>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    super.initState();
    editPatientStore.setNamePatient(editPatientStore.patientName ?? "");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers.add(reaction<SavePatientState>((_) => editPatientStore.saveState,
        (validationState) {
      if (validationState == SavePatientState.success) {
        to(
            context,
            const SuccessPage(
              title: 'Paciente editado com sucesso!',
              goToPage: PatientPage(),
            ));
      } else if (validationState == SavePatientState.error) {
        CustomToast.show(context,
            type: ToastType.error,
            title: "Editar paciente",
            description: "Por favor, preencha os campos.");
      }
    }));
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
        if (didPop) {}
        to(context, const PatientPage());
      },
      child: Scaffold(
          appBar: const MyAppBar(
            title: 'Editar Paciente',
            hideLeading: true,
            image: null,
          ),
          body: form(context)),
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
                          onChanged: editPatientStore.setNamePatient),
                      const SizedBox(
                        height: 15,
                      ),
                      Center(child: Observer(builder: (_) {
                        return MyButtonWidget(
                          text: 'Editar paciente',
                          isLoading: editPatientStore.saveState ==
                              SavePatientState.loading,
                          disabledColor: Colors.grey,
                          onTap: editPatientStore.isValidData
                              ? () async {
                                  _formKey.currentState?.save();
                                  if (_formKey.currentState!.validate()) {
                                    editPatientStore
                                        .editPatient(widget.patient.id ?? 0);
                                  }
                                }
                              : null,
                        );
                      })),
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
