import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:distrito_medico/core/pages/success/success.page.dart';
import 'package:distrito_medico/core/utils/navigation_utils.dart';
import 'package:distrito_medico/core/widgets/my_app_bar.widget.dart';
import 'package:distrito_medico/core/widgets/my_button_widget.dart';
import 'package:distrito_medico/core/widgets/my_text_form_field.widget.dart';
import 'package:distrito_medico/core/widgets/my_toast.widget.dart';
import 'package:distrito_medico/features/health_insurances/pages/health_insurances_page.dart';
import 'package:distrito_medico/features/health_insurances/store/add_health_insurances.store.dart';
import 'package:mobx/mobx.dart';

class AddHealthInsurances extends StatefulWidget {
  const AddHealthInsurances({super.key});

  @override
  State<AddHealthInsurances> createState() => _AddHealthInsurancesState();
}

class _AddHealthInsurancesState extends State<AddHealthInsurances> {
  final addHealthInsuranceStore = GetIt.I.get<AddHealthInsuranceStore>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers.add(reaction<SaveHealthInsurancetState>(
        (_) => addHealthInsuranceStore.saveState, (validationState) {
      if (validationState == SaveHealthInsurancetState.success) {
        to(
            context,
            const SuccessPage(
              title: 'Convênio criado com sucesso!',
              goToPage: HealthInsurancePage(),
            ));
      } else if (validationState == SaveHealthInsurancetState.error) {
        CustomToast.show(context,
            type: ToastType.error,
            title: "Cadastrar novo convênio",
            description: "Ocorreu um erro ao tentar cadastrar.");
      }
    }));
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
            title: 'Novo convênio',
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
                        label: 'Nome do convênio',
                        placeholder: 'Digite o nome do convênio',
                        inputType: TextInputType.text,
                        onChanged: addHealthInsuranceStore.setName,
                        validators: const {'required': true, 'minLength': 3},
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Center(child: Observer(builder: (_) {
                        return MyButtonWidget(
                          text: 'Cadastrar convênio',
                          isLoading: addHealthInsuranceStore.saveState ==
                              SaveHealthInsurancetState.loading,
                          disabledColor: Colors.grey,
                          onTap: addHealthInsuranceStore.isValidData
                              ? () async {
                                  _formKey.currentState?.save();
                                  if (_formKey.currentState!.validate()) {
                                    addHealthInsuranceStore
                                        .createHealthInsurance();
                                  } else {
                                    CustomToast.show(context,
                                        type: ToastType.error,
                                        title: "Cadastrar novo convênio",
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
