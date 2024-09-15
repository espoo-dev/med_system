import 'package:distrito_medico/core/pages/success/success.page.dart';
import 'package:distrito_medico/core/utils/navigation_utils.dart';
import 'package:distrito_medico/core/widgets/auto_complete_real_widget.dart';
import 'package:distrito_medico/core/widgets/error.widget.dart';
import 'package:distrito_medico/core/widgets/my_app_bar.widget.dart';
import 'package:distrito_medico/core/widgets/my_button_widget.dart';
import 'package:distrito_medico/core/widgets/my_date_input.widget.dart';

import 'package:distrito_medico/core/widgets/my_time_input.widget.dart';
import 'package:distrito_medico/core/widgets/my_toast.widget.dart';
import 'package:distrito_medico/core/widgets/custom_switch.widget.dart';
import 'package:distrito_medico/features/medical_shifts/pages/medical_shifts_page.dart';
import 'package:distrito_medico/features/medical_shifts/pages/widgets/radio_group_workload.widget.dart';
import 'package:distrito_medico/features/medical_shifts/store/add_medical_shift.store.dart';
import 'package:distrito_medico/features/procedures/util/real_input_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

class AddMedicalShiftPage extends StatefulWidget {
  const AddMedicalShiftPage({super.key});

  @override
  State<AddMedicalShiftPage> createState() => _AddMedicalShiftPageState();
}

class _AddMedicalShiftPageState extends State<AddMedicalShiftPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final addMedicalShiftStore = GetIt.I.get<AddMedicalShiftStore>();
  final List<ReactionDisposer> _disposers = [];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers.add(reaction<SaveMedicalShiftState>(
        (_) => addMedicalShiftStore.saveState, (validationState) {
      if (validationState == SaveMedicalShiftState.success) {
        to(
            context,
            const SuccessPage(
              title: 'Plantão criado com sucesso!',
              goToPage: MedicalShiftsPage(),
            ));
      } else if (validationState == SaveMedicalShiftState.error) {
        CustomToast.show(context,
            type: ToastType.error,
            title: "Cadastrar novo Plantão",
            description: "Ocorreu um erro ao tentar cadastrar.");
      }
    }));
  }

  @override
  void initState() {
    super.initState();
    addMedicalShiftStore.getAmountSuggestions();
    addMedicalShiftStore.getHospitalNameSuggestions();
  }

  @override
  void dispose() {
    for (var disposer in _disposers) {
      disposer();
    }
    addMedicalShiftStore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          if (didPop) {}
          to(context, const MedicalShiftsPage());
        },
        child: Scaffold(
          appBar: const MyAppBar(
            title: 'Novo Plantão',
            hideLeading: true,
            image: null,
          ),
          body: Observer(
            builder: (BuildContext context) {
              if (addMedicalShiftStore.medicalShiftState ==
                  MedicalShiftState.error) {
                return Center(
                    child: ErrorRetryWidget(
                        'Algo deu errado', 'Por favor, tente novamente', () {
                  addMedicalShiftStore.fetchAllData();
                }));
              }
              if (addMedicalShiftStore.medicalShiftState ==
                  MedicalShiftState.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              return form(context);
            },
          ),
        ));
  }

  Widget form(BuildContext context) {
    TimeOfDay? selectedTime;
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
                        AutoCompleteReal(
                          isCurrency: false,
                          fontSize: 16,
                          label: 'Nome do hospital',
                          placeholder: 'Digite o nome do hospital',
                          suggestions:
                              addMedicalShiftStore.hospitalNameSuggestions,
                          onChanged: addMedicalShiftStore.setHospitalName,
                          inputType: TextInputType.text,
                          validators: const {'required': true, 'minLength': 3},
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text("Carga horária",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )),
                        MyRadioGroupWorkLoad(
                            onValueChanged: addMedicalShiftStore.setWorkload),
                        const SizedBox(
                          height: 15,
                        ),
                        MyInputDate(
                          onChanged: addMedicalShiftStore.setStartDate,
                          label: 'Data início',
                          textColor: Theme.of(context).colorScheme.primary,
                          selectedDate: DateTime.now(),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        MyInputTime(
                            label: 'Hora início',
                            selectedTime: selectedTime,
                            onChanged: addMedicalShiftStore.setStartHour,
                            textColor: Theme.of(context).colorScheme.primary),
                        const SizedBox(
                          height: 15,
                        ),
                        AutoCompleteReal(
                          isCurrency: true,
                          fontSize: 16,
                          label: 'Valor plantão',
                          placeholder: 'Digite o valor do plantão',
                          suggestions: addMedicalShiftStore.amountSuggestions,
                          inputType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            RealInputFormatter(moeda: true),
                          ],
                          onChanged: addMedicalShiftStore.setAmountCents,
                          validators: const {'required': true, 'minLength': 3},
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomSwitch(
                          labelText: "Pago",
                          initialValue: false,
                          onChanged: addMedicalShiftStore.setPayd,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Center(child: Observer(builder: (_) {
                          return MyButtonWidget(
                            text: 'Cadastrar plantão',
                            isLoading: addMedicalShiftStore.saveState ==
                                SaveMedicalShiftState.loading,
                            disabledColor: Colors.grey,
                            onTap: addMedicalShiftStore.isValidData
                                ? () async {
                                    _formKey.currentState?.save();
                                    if (_formKey.currentState!.validate()) {
                                      addMedicalShiftStore.createMedicalShift();
                                    } else {
                                      CustomToast.show(context,
                                          type: ToastType.error,
                                          title: "Cadastrar novo Plantão",
                                          description:
                                              "Por favor, preencha os campos.");
                                    }
                                  }
                                : null,
                          );
                        })),
                      ]),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
