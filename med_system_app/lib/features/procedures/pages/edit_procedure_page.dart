import 'package:distrito_medico/core/pages/success/success.page.dart';
import 'package:distrito_medico/core/utils/navigation_utils.dart';
import 'package:distrito_medico/core/widgets/my_app_bar.widget.dart';
import 'package:distrito_medico/core/widgets/my_button_widget.dart';
import 'package:distrito_medico/core/widgets/my_text_form_field.widget.dart';
import 'package:distrito_medico/core/widgets/my_toast.widget.dart';
import 'package:distrito_medico/features/procedures/model/procedure.model.dart';
import 'package:distrito_medico/features/procedures/pages/procedures_page.dart';
import 'package:distrito_medico/features/procedures/store/edit_procedure.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../util/real_input_format.dart';

class EditProcedurePage extends StatefulWidget {
  final Procedure procedure;
  const EditProcedurePage({super.key, required this.procedure});

  @override
  State<EditProcedurePage> createState() => _EditProcedurePageState();
}

class _EditProcedurePageState extends State<EditProcedurePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final editProcedureStore = GetIt.I.get<EditProcedureStore>();
  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    super.initState();
    editProcedureStore.getAllData(widget.procedure);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers.add(reaction<SaveProcedureState>(
        (_) => editProcedureStore.saveState, (validationState) {
      if (validationState == SaveProcedureState.success) {
        to(
            context,
            const SuccessPage(
              title: 'Procedimento editado com sucesso!',
              goToPage: ProcedurePage(),
            ));
      } else if (validationState == SaveProcedureState.error) {
        CustomToast.show(context,
            type: ToastType.error,
            title: "Editar Procedimento",
            description: "Ocorreu um erro ao tentar editar.");
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
            title: 'Editar procedimento',
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
                        onChanged: editProcedureStore.setName,
                        initialValue: editProcedureStore.name,
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
                        onChanged: editProcedureStore.setCode,
                        initialValue: editProcedureStore.code,
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
                        onChanged: editProcedureStore.setDescription,
                        initialValue: editProcedureStore.description,
                        validators: const {'required': true, 'minLength': 3},
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      MyTextFormField(
                        fontSize: 16,
                        label: 'Digite o valor',
                        placeholder: 'Digite o valor do procimento',
                        initialValue: editProcedureStore.amountCents,
                        inputType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          RealInputFormatter(moeda: true),
                        ],
                        onChanged: editProcedureStore.setAmountCents,
                        validators: const {'required': true, 'minLength': 3},
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Center(child: Observer(builder: (_) {
                        return MyButtonWidget(
                          text: 'Editar procedimento',
                          isLoading: editProcedureStore.saveState ==
                              SaveProcedureState.loading,
                          disabledColor: Colors.grey,
                          onTap: editProcedureStore.isValidData
                              ? () async {
                                  _formKey.currentState?.save();
                                  if (_formKey.currentState!.validate()) {
                                    editProcedureStore.editProcedure(
                                        widget.procedure.id ?? 0);
                                  } else {
                                    CustomToast.show(context,
                                        type: ToastType.error,
                                        title: "Editar Procedimento",
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
