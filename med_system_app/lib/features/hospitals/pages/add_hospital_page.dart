import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:med_system_app/core/pages/success/success.page.dart';
import 'package:med_system_app/core/utils/navigation_utils.dart';
import 'package:med_system_app/core/widgets/my_app_bar.widget.dart';
import 'package:med_system_app/core/widgets/my_button_widget.dart';
import 'package:med_system_app/core/widgets/my_text_form_field.widget.dart';
import 'package:med_system_app/core/widgets/my_toast.widget.dart';
import 'package:med_system_app/features/hospitals/pages/hospital_page.dart';
import 'package:med_system_app/features/hospitals/store/add_hospital.store.dart';
import 'package:mobx/mobx.dart';

class AddHospitalPage extends StatefulWidget {
  const AddHospitalPage({super.key});

  @override
  State<AddHospitalPage> createState() => _AddHospitalState();
}

class _AddHospitalState extends State<AddHospitalPage> {
  final addHospitalStore = GetIt.I.get<AddHospitalStore>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers.add(reaction<SaveHospitalState>((_) => addHospitalStore.saveState,
        (validationState) {
      if (validationState == SaveHospitalState.success) {
        to(
            context,
            const SuccessPage(
              title: 'Hospital criado com sucesso!',
              goToPage: HospitalPage(),
            ));
      } else if (validationState == SaveHospitalState.error) {
        CustomToast.show(context,
            type: ToastType.error,
            title: "Cadastrar novo hospital",
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
        to(context, const HospitalPage());
      },
      child: Scaffold(
          appBar: const MyAppBar(
            title: 'Novo hospital',
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
                          label: 'Nome do hospital',
                          placeholder: 'Digite o nome do hospital',
                          inputType: TextInputType.text,
                          validators: const {'required': true, 'minLength': 3},
                          onChanged: addHospitalStore.setNameHospital),
                      MyTextFormField(
                          fontSize: 16,
                          label: 'Nome do endereço',
                          placeholder: 'Digite o nome do endereço',
                          inputType: TextInputType.text,
                          validators: const {'required': true, 'minLength': 3},
                          onChanged: addHospitalStore.setAddress),
                      const SizedBox(
                        height: 15,
                      ),
                      Center(child: Observer(builder: (_) {
                        return MyButtonWidget(
                          text: 'Cadastrar hospital',
                          isLoading: addHospitalStore.saveState ==
                              SaveHospitalState.loading,
                          disabledColor: Colors.grey,
                          onTap: addHospitalStore.isValidData
                              ? () async {
                                  _formKey.currentState?.save();
                                  if (_formKey.currentState!.validate()) {
                                    addHospitalStore.createHospital();
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
