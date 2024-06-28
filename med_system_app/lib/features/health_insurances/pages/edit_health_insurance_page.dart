import 'package:distrito_medico/core/pages/success/success.page.dart';
import 'package:distrito_medico/core/utils/navigation_utils.dart';
import 'package:distrito_medico/core/widgets/my_app_bar.widget.dart';
import 'package:distrito_medico/core/widgets/my_button_widget.dart';
import 'package:distrito_medico/core/widgets/my_text_form_field.widget.dart';
import 'package:distrito_medico/core/widgets/my_toast.widget.dart';
import 'package:distrito_medico/features/health_insurances/model/health_insurances.model.dart';
import 'package:distrito_medico/features/health_insurances/pages/health_insurances_page.dart';
import 'package:distrito_medico/features/health_insurances/store/edit_health_insurance.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

class EditHealthInsurancePage extends StatefulWidget {
  final HealthInsurance healthInsurance;
  const EditHealthInsurancePage({super.key, required this.healthInsurance});

  @override
  State<EditHealthInsurancePage> createState() => _EditHealthInsuranceState();
}

class _EditHealthInsuranceState extends State<EditHealthInsurancePage> {
  final editHealthInsuranceStore = GetIt.I.get<EditHealthInsuranceStore>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    super.initState();
    editHealthInsuranceStore.setName(widget.healthInsurance.name ?? "");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers.add(reaction<SaveHealthInsurancetState>(
        (_) => editHealthInsuranceStore.saveState, (validationState) {
      if (validationState == SaveHealthInsurancetState.success) {
        to(
            context,
            const SuccessPage(
              title: 'Convênio editado com sucesso!',
              goToPage: HealthInsurancePage(),
            ));
      } else if (validationState == SaveHealthInsurancetState.error) {
        CustomToast.show(context,
            type: ToastType.error,
            title: "Editar convênio",
            description: " Ocorreu um erro ao tentar editar.");
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
        to(context, const HealthInsurancePage());
      },
      child: Scaffold(
          appBar: const MyAppBar(
            title: 'Editar Convênio',
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
                          initialValue: widget.healthInsurance.name,
                          fontSize: 16,
                          label: 'Nome do convênio',
                          placeholder: 'Digite o nome do convênio',
                          inputType: TextInputType.text,
                          validators: const {'required': true, 'minLength': 3},
                          onChanged: editHealthInsuranceStore.setName),
                      const SizedBox(
                        height: 15,
                      ),
                      Center(child: Observer(builder: (_) {
                        return MyButtonWidget(
                          text: 'Editar convênio',
                          isLoading: editHealthInsuranceStore.saveState ==
                              SaveHealthInsurancetState.loading,
                          disabledColor: Colors.grey,
                          onTap: editHealthInsuranceStore.isValidData
                              ? () async {
                                  _formKey.currentState?.save();
                                  if (_formKey.currentState!.validate()) {
                                    editHealthInsuranceStore
                                        .editHealthInsurance(
                                            widget.healthInsurance.id ?? 0);
                                  } else {
                                    CustomToast.show(context,
                                        type: ToastType.error,
                                        title: "Editar convênio",
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
