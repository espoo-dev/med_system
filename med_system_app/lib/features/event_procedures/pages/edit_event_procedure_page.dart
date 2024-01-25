import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:med_system_app/core/pages/success/success.page.dart';
import 'package:med_system_app/core/utils/navigation_utils.dart';
import 'package:med_system_app/core/widgets/error.widget.dart';
import 'package:med_system_app/core/widgets/my_app_bar.widget.dart';
import 'package:med_system_app/core/widgets/my_button_widget.dart';
import 'package:med_system_app/core/widgets/my_date_input.widget.dart';
import 'package:med_system_app/core/widgets/my_text_form_field.widget.dart';
import 'package:med_system_app/core/widgets/my_toast.widget.dart';
import 'package:med_system_app/features/event_procedures/model/event_procedure.model.dart';
import 'package:med_system_app/features/event_procedures/pages/event_procedures_page.dart';
import 'package:med_system_app/features/event_procedures/pages/widgets/custom_switch.widget.dart';
import 'package:med_system_app/features/event_procedures/pages/widgets/dropdown_search_health_insurances.widget.dart';
import 'package:med_system_app/features/event_procedures/pages/widgets/dropdown_search_hospitals.widget.dart';
import 'package:med_system_app/features/event_procedures/pages/widgets/dropdown_search_patients.widget.dart';
import 'package:med_system_app/features/event_procedures/pages/widgets/dropdown_search_procedures.widget.dart';
import 'package:med_system_app/features/event_procedures/pages/widgets/radio_group.widget.dart';
import 'package:med_system_app/features/event_procedures/store/edit_event_procedure.store.dart';
import 'package:med_system_app/features/health_insurances/model/health_insurances.model.dart';
import 'package:med_system_app/features/hospitals/model/hospital.model.dart';
import 'package:med_system_app/features/patients/model/patient.model.dart';
import 'package:med_system_app/features/procedures/model/procedure.model.dart';
import 'package:mobx/mobx.dart';

class EditEventProcedurePage extends StatefulWidget {
  final EventProcedures eventProcedures;
  const EditEventProcedurePage({super.key, required this.eventProcedures});

  @override
  State<EditEventProcedurePage> createState() => _EditEventProcedureState();
}

class _EditEventProcedureState extends State<EditEventProcedurePage> {
  final editEventProcedureStore = GetIt.I.get<EditEventProcedureStore>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    super.initState();
    editEventProcedureStore.fetchAllData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers.add(reaction<SaveEventProcedureState>(
        (_) => editEventProcedureStore.saveState, (validationState) {
      if (validationState == SaveEventProcedureState.success) {
        to(
            context,
            const SuccessPage(
              title: 'Evento editado com sucesso!',
              goToPage: EventProceduresPage(),
            ));
      } else if (validationState == SaveEventProcedureState.error) {
        CustomToast.show(context,
            type: ToastType.error,
            title: "Editar evento",
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
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Editar evento procedimento',
        hideLeading: true,
        image: null,
      ),
      body: Observer(
        builder: (BuildContext context) {
          if (editEventProcedureStore.state == EditEventProcedureState.error) {
            return Center(
                child: ErrorRetryWidget(
                    'Algo deu errado', 'Por favor, tente novamente', () {
              editEventProcedureStore.fetchAllData();
            }));
          }
          if (editEventProcedureStore.state ==
              EditEventProcedureState.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return form(context);
        },
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
                          patientList: editEventProcedureStore.patientList,
                          selectedPatient: editEventProcedureStore.findPatient(
                              widget.eventProcedures.patient ?? "")!,
                          onChanged: (Patient? patient) =>
                              editEventProcedureStore
                                  .setPatientId(patient?.id ?? 0)),
                      const SizedBox(
                        height: 15,
                      ),
                      MyTextFormField(
                          initialValue:
                              widget.eventProcedures.patientServiceNumber,
                          fontSize: 16,
                          label: 'Número de serviço paciente',
                          placeholder: 'Digite número de serviço paciente.',
                          inputType: TextInputType.text,
                          validators: const {'required': true, 'minLength': 4},
                          onChanged:
                              editEventProcedureStore.setPatientServiceNumber),
                      const SizedBox(
                        height: 15,
                      ),
                      MyInputDate(
                        onChanged: editEventProcedureStore.setCreatedDate,
                        label: 'Data',
                        textColor: Theme.of(context).colorScheme.primary,
                        selectedDate: DateTime.now(),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      MyInputDate(
                        onChanged: editEventProcedureStore.setPaydAt,
                        label: 'Data Pagamento',
                        textColor: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      DropdownSearchProcedures(
                        procedureList: editEventProcedureStore.procedureList,
                        selectedProcedure:
                            editEventProcedureStore.findProcedure(
                                widget.eventProcedures.procedure ?? "")!,
                        onChanged: (Procedure? procedure) =>
                            editEventProcedureStore
                                .setProcedureId(procedure?.id ?? 0),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      DropdownSearchHospitals(
                        hospitalList: editEventProcedureStore.hospitalList,
                        selectedHospital: editEventProcedureStore.findHospital(
                            widget.eventProcedures.hospital ?? "")!,
                        onChanged: (Hospital? hospital) =>
                            editEventProcedureStore
                                .setHospitalId(hospital?.id ?? 0),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      DropdownHealthInsurances(
                        healthInsuranceList:
                            editEventProcedureStore.healthInsuranceList,
                        selectedHealthInsurance:
                            editEventProcedureStore.findHealthInsurance(
                                widget.eventProcedures.healthInsurance ?? "")!,
                        onChanged: (HealthInsurance? healthInsurance) =>
                            editEventProcedureStore
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
                      MyRadioGroup(
                          initialValue: widget.eventProcedures.roomType,
                          onValueChanged: (value) {
                            editEventProcedureStore.setAccommodation(value);
                          }),
                      CustomSwitch(
                        initialValue: widget.eventProcedures.urgency ?? false,
                        onChanged: (value) {
                          editEventProcedureStore.setUrgency(value);
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Center(child: Observer(builder: (_) {
                        return MyButtonWidget(
                          text: 'Editar evento',
                          isLoading: editEventProcedureStore.saveState ==
                              SaveEventProcedureState.loading,
                          disabledColor: Colors.grey,
                          onTap: editEventProcedureStore.isValidData
                              ? () async {
                                  _formKey.currentState?.save();
                                  if (_formKey.currentState!.validate()) {}
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
