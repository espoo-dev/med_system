import 'package:distrito_medico/core/pages/success/success.page.dart';
import 'package:distrito_medico/core/utils/navigation_utils.dart';
import 'package:distrito_medico/core/widgets/error.widget.dart';
import 'package:distrito_medico/core/widgets/my_app_bar.widget.dart';
import 'package:distrito_medico/core/widgets/my_button_widget.dart';
import 'package:distrito_medico/core/widgets/my_date_input.widget.dart';
import 'package:distrito_medico/core/widgets/my_text_form_field.widget.dart';
import 'package:distrito_medico/core/widgets/my_toast.widget.dart';
import 'package:distrito_medico/features/event_procedures/pages/event_procedures_page.dart';
import 'package:distrito_medico/features/event_procedures/pages/widgets/custom_switch.widget.dart';
import 'package:distrito_medico/features/event_procedures/pages/widgets/dropdown_search_health_insurances.widget.dart';
import 'package:distrito_medico/features/event_procedures/pages/widgets/dropdown_search_hospitals.widget.dart';
import 'package:distrito_medico/features/event_procedures/pages/widgets/dropdown_search_patients.widget.dart';
import 'package:distrito_medico/features/event_procedures/pages/widgets/dropdown_search_procedures.widget.dart';
import 'package:distrito_medico/features/event_procedures/pages/widgets/radio_group.widget.dart';
import 'package:distrito_medico/features/event_procedures/pages/widgets/radio_group_payment.widget.dart';
import 'package:distrito_medico/features/event_procedures/store/add_event_procedure.store.dart';
import 'package:distrito_medico/features/health_insurances/model/health_insurances.model.dart';
import 'package:distrito_medico/features/home/pages/home_page.dart';
import 'package:distrito_medico/features/hospitals/model/hospital.model.dart';
import 'package:distrito_medico/features/patients/model/patient.model.dart';
import 'package:distrito_medico/features/procedures/model/procedure.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

class AddEventProcedurePage extends StatefulWidget {
  final bool backToHome;

  const AddEventProcedurePage({super.key, this.backToHome = false});

  @override
  State<AddEventProcedurePage> createState() => _AddEventProcedureState();
}

class _AddEventProcedureState extends State<AddEventProcedurePage> {
  final addEventProcedureStore = GetIt.I.get<AddEventProcedureStore>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    super.initState();
    addEventProcedureStore.fetchAllData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers.add(reaction<SaveEventProcedureState>(
        (_) => addEventProcedureStore.saveState, (validationState) {
      if (validationState == SaveEventProcedureState.success) {
        to(
            context,
            const SuccessPage(
              title: 'Evento criado com sucesso!',
              goToPage: EventProceduresPage(),
            ));
      } else if (validationState == SaveEventProcedureState.error) {
        CustomToast.show(context,
            type: ToastType.error,
            title: "Cadastrar novo evento",
            description: "Por favor, preencha os campos.");
      }
    }));
  }

  @override
  void dispose() {
    for (var disposer in _disposers) {
      disposer();
    }
    addEventProcedureStore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) {}
        if (widget.backToHome) {
          to(context, const HomePage());
        } else {
          to(context, const EventProceduresPage());
        }
      },
      child: Scaffold(
        appBar: const MyAppBar(
          title: 'Novo Procedimento',
          hideLeading: true,
          image: null,
        ),
        body: Observer(
          builder: (BuildContext context) {
            if (addEventProcedureStore.state == AddEventProcedureState.error) {
              return Center(
                  child: ErrorRetryWidget(
                      'Algo deu errado', 'Por favor, tente novamente', () {
                addEventProcedureStore.fetchAllData();
              }));
            }
            if (addEventProcedureStore.state ==
                AddEventProcedureState.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            return form(context);
          },
        ),
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
                      DropdownSearchPatients(
                          patientList: addEventProcedureStore.patientList,
                          selectedPatient:
                              addEventProcedureStore.patient ?? Patient(),
                          onChanged: (Patient? patient) =>
                              addEventProcedureStore.setPatient(patient!)),
                      const SizedBox(
                        height: 15,
                      ),
                      MyTextFormField(
                          fontSize: 16,
                          label: 'Número de registro',
                          placeholder: 'Digite número de serviço paciente.',
                          inputType: TextInputType.text,
                          validators: const {'required': true, 'minLength': 4},
                          onChanged:
                              addEventProcedureStore.setPatientServiceNumber),
                      const SizedBox(
                        height: 15,
                      ),
                      MyInputDate(
                        onChanged: addEventProcedureStore.setCreatedDate,
                        label: 'Data',
                        textColor: Theme.of(context).colorScheme.primary,
                        selectedDate: DateTime.now(),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text("Pago",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                      Checkbox(
                          value: addEventProcedureStore.payd,
                          onChanged: (bool? value) {
                            addEventProcedureStore.setPayd(value ?? false);
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text("Pagamento",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                      MyRadioGroupPayment(onValueChanged: (value) {
                        addEventProcedureStore.setPayment(value);
                      }),
                      const SizedBox(
                        height: 15,
                      ),
                      DropdownSearchProcedures(
                        procedureList: addEventProcedureStore.procedureList,
                        selectedProcedure: Procedure(),
                        onChanged: (Procedure? procedure) =>
                            addEventProcedureStore
                                .setProcedureId(procedure?.id ?? 0),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      DropdownSearchHospitals(
                        hospitalList: addEventProcedureStore.hospitalList,
                        selectedHospital: Hospital(),
                        onChanged: (Hospital? hospital) =>
                            addEventProcedureStore
                                .setHospitalId(hospital?.id ?? 0),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      DropdownHealthInsurances(
                        healthInsuranceList:
                            addEventProcedureStore.healthInsuranceList,
                        selectedHealthInsurance: HealthInsurance(),
                        onChanged: (HealthInsurance? healthInsurance) =>
                            addEventProcedureStore
                                .setHealthInsuranceId(healthInsurance?.id ?? 0),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text("Acomodação",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                      MyRadioGroup(onValueChanged: (value) {
                        addEventProcedureStore.setAccommodation(value);
                      }),
                      CustomSwitch(
                        initialValue: false,
                        onChanged: (value) {
                          addEventProcedureStore.setUrgency(value);
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Center(child: Observer(builder: (_) {
                        return MyButtonWidget(
                          text: 'Cadastrar procedimento',
                          isLoading: addEventProcedureStore.saveState ==
                              SaveEventProcedureState.loading,
                          disabledColor: Colors.grey,
                          onTap: addEventProcedureStore.isValidData
                              ? () async {
                                  _formKey.currentState?.save();
                                  if (_formKey.currentState!.validate()) {
                                    addEventProcedureStore
                                        .createEventProcedure();
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
