import 'package:distrito_medico/core/pages/success/success.page.dart';
import 'package:distrito_medico/core/utils/navigation_utils.dart';
import 'package:distrito_medico/core/widgets/my_app_bar.widget.dart';
import 'package:distrito_medico/core/widgets/my_button_widget.dart';
import 'package:distrito_medico/core/widgets/my_text_form_field.widget.dart';
import 'package:distrito_medico/core/widgets/my_toast.widget.dart';
import 'package:distrito_medico/features/hospitals/domain/entities/hospital_entity.dart';
import 'package:distrito_medico/features/hospitals/pages/hospital_page.dart';
import 'package:distrito_medico/features/hospitals/presentation/viewmodels/hospital_list_viewmodel.dart';
import 'package:distrito_medico/features/hospitals/presentation/viewmodels/update_hospital_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

class EditHospitaltPage extends StatefulWidget {
  final HospitalEntity hospital;
  const EditHospitaltPage({super.key, required this.hospital});

  @override
  State<EditHospitaltPage> createState() => _EditHospitalState();
}

class _EditHospitalState extends State<EditHospitaltPage> {
  final _viewModel = GetIt.I.get<UpdateHospitalViewModel>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    super.initState();
    _viewModel.loadHospital(widget.hospital);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers.add(reaction<UpdateHospitalState>(
      (_) => _viewModel.state,
      (state) {
        if (state == UpdateHospitalState.success) {
          // Atualiza a lista de hospitais
          GetIt.I.get<HospitalListViewModel>().loadHospitals(refresh: true);

          to(
            context,
            const SuccessPage(
              title: 'Hospital editado com sucesso!',
              goToPage: HospitalPage(),
            ),
          );
        } else if (state == UpdateHospitalState.error) {
          CustomToast.show(
            context,
            type: ToastType.error,
            title: "Editar Hospital",
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
        to(context, const HospitalPage());
      },
      child: Scaffold(
        appBar: const MyAppBar(
          title: 'Editar Hospital',
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
                        initialValue: widget.hospital.name,
                        fontSize: 16,
                        label: 'Nome do hospital',
                        placeholder: 'Digite o nome do hospital',
                        inputType: TextInputType.text,
                        validators: const {'required': true, 'minLength': 3},
                        onChanged: _viewModel.setName,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      MyTextFormField(
                        initialValue: widget.hospital.address,
                        fontSize: 16,
                        label: 'Endereço',
                        placeholder: 'Digite o endereço do hospital',
                        inputType: TextInputType.text,
                        validators: const {'required': true, 'minLength': 5},
                        onChanged: _viewModel.setAddress,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: Observer(
                          builder: (_) {
                            return MyButtonWidget(
                              text: 'Editar hospital',
                              isLoading: _viewModel.isLoading,
                              disabledColor: Colors.grey,
                              onTap: _viewModel.canSubmit
                                  ? () async {
                                      _formKey.currentState?.save();
                                      if (_formKey.currentState!.validate()) {
                                        await _viewModel.updateHospital();
                                      } else {
                                        CustomToast.show(
                                          context,
                                          type: ToastType.error,
                                          title: "Editar hospital",
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
