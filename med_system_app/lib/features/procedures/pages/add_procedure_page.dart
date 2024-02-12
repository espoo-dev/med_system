import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:med_system_app/core/pages/success/success.page.dart';
import 'package:med_system_app/core/utils/navigation_utils.dart';
import 'package:med_system_app/core/widgets/my_app_bar.widget.dart';
import 'package:med_system_app/core/widgets/my_button_widget.dart';
import 'package:med_system_app/core/widgets/my_text_form_field.widget.dart';
import 'package:med_system_app/core/widgets/my_toast.widget.dart';
import 'package:med_system_app/features/procedures/pages/procedures_page.dart';
import 'package:med_system_app/features/procedures/store/add_procedure.store.dart';
import 'package:mobx/mobx.dart';

import '../util/real_input_format.dart';

class AddProcedurePage extends StatefulWidget {
  const AddProcedurePage({super.key});

  @override
  State<AddProcedurePage> createState() => _AddProcedurePageState();
}

class _AddProcedurePageState extends State<AddProcedurePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final addProcedureStore = GetIt.I.get<AddProcedureStore>();
  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers.add(reaction<SaveProcedureState>(
        (_) => addProcedureStore.saveState, (validationState) {
      if (validationState == SaveProcedureState.success) {
        to(
            context,
            const SuccessPage(
              title: 'Procedimento criado com sucesso!',
              goToPage: ProcedurePage(),
            ));
      } else if (validationState == SaveProcedureState.error) {
        CustomToast.show(context,
            type: ToastType.error,
            title: "Cadastrar novo Procedimento",
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
        to(context, const ProcedurePage());
      },
      child: Scaffold(
          appBar: const MyAppBar(
            title: 'Novo procedimento',
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
                        label: 'Nome do procedimento',
                        placeholder: 'Digite o nome do procedimento',
                        onChanged: addProcedureStore.setName,
                        inputType: TextInputType.text,
                        validators: const {'required': true, 'minLength': 3},
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      MyTextFormField(
                        fontSize: 16,
                        label: 'Código do procedimento',
                        placeholder: 'Digite o código do procedimento',
                        inputType: TextInputType.text,
                        onChanged: addProcedureStore.setCode,
                        validators: const {'required': true, 'minLength': 3},
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      MyTextFormField(
                        fontSize: 16,
                        label: 'Digite a descrição',
                        placeholder: 'Digite a descrição do procedimento',
                        inputType: TextInputType.text,
                        onChanged: addProcedureStore.setDescription,
                        validators: const {'required': true, 'minLength': 3},
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      MyTextFormField(
                        fontSize: 16,
                        label: 'Digite o valor',
                        placeholder: 'Digite o valor do procimento',
                        inputType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          RealInputFormatter(moeda: true),
                        ],
                        onChanged: addProcedureStore.setAmountCents,
                        validators: const {'required': true, 'minLength': 3},
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Center(child: Observer(builder: (_) {
                        return MyButtonWidget(
                          text: 'Cadastrar procedimento',
                          isLoading: addProcedureStore.saveState ==
                              SaveProcedureState.loading,
                          disabledColor: Colors.grey,
                          onTap: addProcedureStore.isValidData
                              ? () async {
                                  _formKey.currentState?.save();
                                  if (_formKey.currentState!.validate()) {
                                    addProcedureStore.createProcedure();
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
