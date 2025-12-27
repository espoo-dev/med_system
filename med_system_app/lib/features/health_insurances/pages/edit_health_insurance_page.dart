import 'package:distrito_medico/core/pages/success/success.page.dart';
import 'package:distrito_medico/core/utils/navigation_utils.dart';
import 'package:distrito_medico/core/widgets/my_app_bar.widget.dart';
import 'package:distrito_medico/core/widgets/my_button_widget.dart';
import 'package:distrito_medico/core/widgets/my_text_form_field.widget.dart';
import 'package:distrito_medico/core/widgets/my_toast.widget.dart';
import 'package:distrito_medico/features/health_insurances/domain/entities/health_insurance_entity.dart';
import 'package:distrito_medico/features/health_insurances/pages/health_insurances_page.dart';
import 'package:distrito_medico/features/health_insurances/presentation/viewmodels/health_insurance_list_viewmodel.dart';
import 'package:distrito_medico/features/health_insurances/presentation/viewmodels/update_health_insurance_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

class EditHealthInsurancePage extends StatefulWidget {
  final HealthInsuranceEntity healthInsuranceEntity;
  const EditHealthInsurancePage(
      {super.key, required this.healthInsuranceEntity});

  @override
  State<EditHealthInsurancePage> createState() =>
      _EditHealthInsurancePageState();
}

class _EditHealthInsurancePageState extends State<EditHealthInsurancePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _viewModel = GetIt.I.get<UpdateHealthInsuranceViewModel>();
  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    super.initState();
    _viewModel.setHealthInsurance(widget.healthInsuranceEntity);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers.add(reaction<UpdateHealthInsuranceState>(
        (_) => _viewModel.state, (state) {
      if (state == UpdateHealthInsuranceState.success) {
        // Atualiza a lista
        GetIt.I.get<HealthInsuranceListViewModel>().loadHealthInsurances(refresh: true);
        
        to(
            context,
            const SuccessPage(
              title: 'Convênio editado com sucesso!',
              goToPage: HealthInsurancesPage(),
            ));
      } else if (state == UpdateHealthInsuranceState.error) {
        CustomToast.show(context,
            type: ToastType.error,
            title: "Editar Convênio",
            description: _viewModel.errorMessage.isNotEmpty
                ? _viewModel.errorMessage
                : "Ocorreu um erro ao tentar editar.");
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
        if (didPop) return;
        to(context, const HealthInsurancesPage());
      },
      child: Scaffold(
          appBar: const MyAppBar(
            title: 'Editar convênio',
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
                        initialValue: widget.healthInsuranceEntity.name,
                        fontSize: 16,
                        label: 'Nome do convênio',
                        placeholder: 'Digite o nome do convênio',
                        onChanged: _viewModel.setName,
                        inputType: TextInputType.text,
                        validators: const {'required': true, 'minLength': 3},
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Center(child: Observer(builder: (_) {
                        return MyButtonWidget(
                          text: 'Editar convênio',
                          isLoading: _viewModel.isLoading,
                          disabledColor: Colors.grey,
                          onTap: _viewModel.canSubmit
                              ? () async {
                                  _formKey.currentState?.save();
                                  if (_formKey.currentState!.validate()) {
                                    _viewModel.updateHealthInsurance();
                                  } else {
                                    CustomToast.show(context,
                                        type: ToastType.error,
                                        title: "Editar Convênio",
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
