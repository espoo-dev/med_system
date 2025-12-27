import 'package:distrito_medico/core/pages/success/success.page.dart';
import 'package:distrito_medico/core/utils/navigation_utils.dart';
import 'package:distrito_medico/core/widgets/my_app_bar.widget.dart';
import 'package:distrito_medico/core/widgets/my_button_widget.dart';
import 'package:distrito_medico/core/widgets/my_text_form_field.widget.dart';
import 'package:distrito_medico/core/widgets/my_toast.widget.dart';
import 'package:distrito_medico/features/health_insurances/pages/health_insurances_page.dart';
import 'package:distrito_medico/features/health_insurances/presentation/viewmodels/create_health_insurance_viewmodel.dart';
import 'package:distrito_medico/features/health_insurances/presentation/viewmodels/health_insurance_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

class AddHealthInsurancesPage extends StatefulWidget {
  const AddHealthInsurancesPage({super.key});

  @override
  State<AddHealthInsurancesPage> createState() =>
      _AddHealthInsurancesPageState();
}

class _AddHealthInsurancesPageState extends State<AddHealthInsurancesPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _viewModel = GetIt.I.get<CreateHealthInsuranceViewModel>();
  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    super.initState();
    _viewModel.reset();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers.add(reaction<CreateHealthInsuranceState>(
        (_) => _viewModel.state, (state) {
      if (state == CreateHealthInsuranceState.success) {
        // Atualiza a lista
        GetIt.I.get<HealthInsuranceListViewModel>().loadHealthInsurances(refresh: true);
        
        to(
            context,
            const SuccessPage(
              title: 'Convênio criado com sucesso!',
              goToPage: HealthInsurancesPage(),
            ));
      } else if (state == CreateHealthInsuranceState.error) {
        CustomToast.show(context,
            type: ToastType.error,
            title: "Cadastrar novo Convênio",
            description: _viewModel.errorMessage.isNotEmpty
                ? _viewModel.errorMessage
                : "Ocorreu um erro ao tentar cadastrar.");
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
                        onChanged: _viewModel.setName,
                        inputType: TextInputType.text,
                        validators: const {'required': true, 'minLength': 3},
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Center(child: Observer(builder: (_) {
                        return MyButtonWidget(
                          text: 'Cadastrar convênio',
                          isLoading: _viewModel.isLoading,
                          disabledColor: Colors.grey,
                          onTap: _viewModel.canSubmit
                              ? () async {
                                  _formKey.currentState?.save();
                                  if (_formKey.currentState!.validate()) {
                                    _viewModel.createHealthInsurance();
                                  } else {
                                    CustomToast.show(context,
                                        type: ToastType.error,
                                        title: "Cadastrar novo Convênio",
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
