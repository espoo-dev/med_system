import 'package:distrito_medico/core/pages/success/success.page.dart';
import 'package:distrito_medico/core/utils/navigation_utils.dart';
import 'package:distrito_medico/core/widgets/my_app_bar.widget.dart';
import 'package:distrito_medico/core/widgets/my_button_widget.dart';
import 'package:distrito_medico/core/widgets/my_text_form_field.widget.dart';
import 'package:distrito_medico/core/widgets/my_toast.widget.dart';
import 'package:distrito_medico/features/patients/pages/patient_page.dart';
import 'package:distrito_medico/features/patients/store/add_patient.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

class AddPatientPage extends StatefulWidget {
  const AddPatientPage({super.key});

  @override
  State<AddPatientPage> createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatientPage> {
  final addPatientStore = GetIt.I.get<AddPatientStore>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers.add(reaction<SavePatientState>((_) => addPatientStore.saveState,
        (validationState) {
      if (validationState == SavePatientState.success) {
        to(
            context,
            const SuccessPage(
              title: 'Paciente criado com sucesso!',
              goToPage: PatientPage(),
            ));
      } else if (validationState == SavePatientState.error) {
        CustomToast.show(context,
            type: ToastType.error,
            title: "Cadastrar novo Pacinete",
            description: "Ocorreu um erro ao tentar cadastrar.");
      }
    }));
  }

  @override
  void dispose() {
    for (var disposer in _disposers) {
      disposer();
    }
    addPatientStore.dispose();
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
            title: 'Novo Paciente',
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
                          fontSize: 16,
                          label: 'Nome do paciente',
                          placeholder: 'Digite o nome do paciente',
                          inputType: TextInputType.text,
                          validators: const {'required': true, 'minLength': 3},
                          onChanged: addPatientStore.setNamePatient),
                      const SizedBox(
                        height: 15,
                      ),
                      Center(child: Observer(builder: (_) {
                        return MyButtonWidget(
                          text: 'Cadastrar paciente',
                          isLoading: addPatientStore.saveState ==
                              SavePatientState.loading,
                          disabledColor: Colors.grey,
                          onTap: addPatientStore.isValidData
                              ? () async {
                                  _formKey.currentState?.save();
                                  if (_formKey.currentState!.validate()) {
                                    addPatientStore.createPatient();
                                  } else {
                                    CustomToast.show(context,
                                        type: ToastType.error,
                                        title: "Cadastrar novo paciente",
                                        description:
                                            "Por favor, preencha os campos.");
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
