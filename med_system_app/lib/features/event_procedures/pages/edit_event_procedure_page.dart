import 'package:distrito_medico/core/pages/success/success.page.dart';
import 'package:distrito_medico/core/utils/navigation_utils.dart';
import 'package:distrito_medico/core/utils/utils.dart';
import 'package:distrito_medico/core/widgets/error.widget.dart';
import 'package:distrito_medico/core/widgets/my_app_bar.widget.dart';
import 'package:distrito_medico/core/widgets/my_button_widget.dart';
import 'package:distrito_medico/core/widgets/my_date_input.widget.dart';
import 'package:distrito_medico/core/widgets/my_text_form_field.widget.dart';
import 'package:distrito_medico/core/widgets/my_toast.widget.dart';
import 'package:distrito_medico/features/event_procedures/model/event_procedure.model.dart';
import 'package:distrito_medico/features/event_procedures/pages/event_procedures_page.dart';
import 'package:distrito_medico/features/event_procedures/pages/widgets/custom_switch.widget.dart';
import 'package:distrito_medico/features/event_procedures/pages/widgets/dropdown_search_health_insurances.widget.dart';
import 'package:distrito_medico/features/event_procedures/pages/widgets/dropdown_search_health_insurances_others.widget.dart';
import 'package:distrito_medico/features/event_procedures/pages/widgets/dropdown_search_hospitals.widget.dart';
import 'package:distrito_medico/features/event_procedures/pages/widgets/dropdown_search_patients.widget.dart';
import 'package:distrito_medico/features/event_procedures/pages/widgets/dropdown_search_procedures.widget.dart';
import 'package:distrito_medico/features/event_procedures/pages/widgets/dropdown_search_procedures_others.widget.dart';
import 'package:distrito_medico/features/event_procedures/pages/widgets/radio_group.widget.dart';
import 'package:distrito_medico/features/event_procedures/pages/widgets/radio_group_payment.widget.dart';
import 'package:distrito_medico/features/event_procedures/pages/widgets/triangle_widget.dart';
import 'package:distrito_medico/features/event_procedures/store/edit_event_procedure.store.dart';
import 'package:distrito_medico/features/health_insurances/model/health_insurances.model.dart';
import 'package:distrito_medico/features/home/pages/home_page.dart';
import 'package:distrito_medico/features/hospitals/model/hospital.model.dart';
import 'package:distrito_medico/features/patients/model/patient.model.dart';
import 'package:distrito_medico/features/procedures/model/procedure.model.dart';
import 'package:distrito_medico/features/procedures/util/real_input_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

class EditEventProcedurePage extends StatefulWidget {
  final bool backToHome;

  final EventProcedures eventProcedures;
  const EditEventProcedurePage(
      {super.key, required this.eventProcedures, this.backToHome = false});

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
    editEventProcedureStore.setPayment(widget.eventProcedures.payment ?? "");
    editEventProcedureStore.fetchAllData(
        widget.eventProcedures.patient ?? "",
        widget.eventProcedures.procedure ?? "",
        widget.eventProcedures.healthInsurance ?? "");
    editEventProcedureStore.setPatientServiceNumber(
        widget.eventProcedures.patientServiceNumber ?? "");
    editEventProcedureStore.setPayd(widget.eventProcedures.payd ?? false);
    editEventProcedureStore.setUrgency(widget.eventProcedures.urgency ?? false);
    editEventProcedureStore
        .setAccommodation(widget.eventProcedures.roomType ?? "");
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
              title: 'Procedimento editado com sucesso!',
              goToPage: EventProceduresPage(),
            ));
      } else if (validationState == SaveEventProcedureState.error) {
        CustomToast.show(context,
            type: ToastType.error,
            title: "Editar procedimento",
            description: "Ocorreu um erro ao tentar editar evento.");
      }
    }));
  }

  @override
  void dispose() {
    for (var disposer in _disposers) {
      disposer();
    }
    editEventProcedureStore.dispose();
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
        appBar: MyAppBar(
          title: 'Editar procedimento',
          hideLeading: true,
          onPressed: () {
            to(context, const EventProceduresPage());
          },
          image: null,
        ),
        body: Observer(
          builder: (BuildContext context) {
            if (editEventProcedureStore.state ==
                EditEventProcedureState.error) {
              return Center(
                  child: ErrorRetryWidget(
                      'Algo deu errado', 'Por favor, tente novamente', () {
                editEventProcedureStore.fetchAllData(
                    widget.eventProcedures.patient ?? "",
                    widget.eventProcedures.procedure ?? "",
                    widget.eventProcedures.healthInsurance ?? "");
              }));
            }
            if (editEventProcedureStore.state ==
                EditEventProcedureState.loading) {
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
                  Observer(builder: (_) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropdownSearchPatients(
                            patientList: editEventProcedureStore.patientList,
                            selectedPatient: editEventProcedureStore.patient ??
                                editEventProcedureStore.findPatient(
                                    widget.eventProcedures.patient ?? "")!,
                            onChanged: (Patient? patient) =>
                                editEventProcedureStore.setPatient(patient!)),
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
                            validators: const {
                              'required': true,
                              'minLength': 4
                            },
                            onChanged: editEventProcedureStore
                                .setPatientServiceNumber),
                        const SizedBox(
                          height: 15,
                        ),
                        MyInputDate(
                          onChanged: editEventProcedureStore.setCreatedDate,
                          label: 'Data',
                          textColor: Theme.of(context).colorScheme.primary,
                          selectedDate: convertStringToDate(
                              widget.eventProcedures.date ?? ""),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        DropdownSearchHospitals(
                          hospitalList: editEventProcedureStore.hospitalList,
                          selectedHospital:
                              editEventProcedureStore.findHospital(
                                  widget.eventProcedures.hospital ?? "")!,
                          onChanged: (Hospital? hospital) =>
                              editEventProcedureStore
                                  .setHospitalId(hospital?.id ?? 0),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        MyRadioGroupPayment(
                            initialValue: widget.eventProcedures.payment,
                            onValueChanged: (value) {
                              editEventProcedureStore.setPayment(value);
                            }),
                        const SizedBox(
                          height: 15,
                        ),
                        Visibility(
                          visible: !editEventProcedureStore.isOtherPayment,
                          child: Column(
                            children: [
                              DropdownHealthInsurances(
                                healthInsuranceList:
                                    editEventProcedureStore.healthInsuranceList,
                                selectedHealthInsurance: editEventProcedureStore
                                        .healthInsurance ??
                                    editEventProcedureStore.findHealthInsurance(
                                        widget.eventProcedures
                                                .healthInsurance ??
                                            "")!,
                                onChanged: (HealthInsurance? healthInsurance) =>
                                    editEventProcedureStore
                                        .setHealthInsurance(healthInsurance!),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: !editEventProcedureStore.isOtherPayment,
                          child: Column(
                            children: [
                              DropdownSearchProcedures(
                                procedureList:
                                    editEventProcedureStore.procedureList,
                                selectedProcedure:
                                    editEventProcedureStore.procedure ??
                                        editEventProcedureStore.findProcedure(
                                            widget.eventProcedures.procedure ??
                                                "")!,
                                onChanged: (Procedure? procedure) =>
                                    editEventProcedureStore
                                        .setProcedure(procedure!),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: !editEventProcedureStore.isOtherPayment,
                          child: const Text("Acomodação",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        Visibility(
                          visible: !editEventProcedureStore.isOtherPayment,
                          child: MyRadioGroup(
                              initialValue: widget.eventProcedures.roomType,
                              onValueChanged: (value) {
                                editEventProcedureStore.setAccommodation(value);
                              }),
                        ),
                        Visibility(
                          visible: !editEventProcedureStore.isOtherPayment,
                          child: Column(
                            children: [
                              CustomSwitch(
                                labelText: "Urgência",
                                initialValue:
                                    editEventProcedureStore.urgency ?? false,
                                onChanged: (value) {
                                  editEventProcedureStore.setUrgency(value);
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: editEventProcedureStore.isOtherPayment,
                          child: Stack(
                            children: [
                              Card(
                                elevation: 10,
                                surfaceTintColor: Colors.white,
                                margin: const EdgeInsets.only(top: 8.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      DropdownSearchProceduresOthers(
                                        procedureList: editEventProcedureStore
                                            .procedureListOthers,
                                        selectedProcedure:
                                            editEventProcedureStore
                                                    .procedureOther ??
                                                editEventProcedureStore
                                                    .findProcedureCustom(widget
                                                            .eventProcedures
                                                            .procedure ??
                                                        "")!,
                                        onChanged: (Procedure? procedure) =>
                                            editEventProcedureStore
                                                .setProcedureOther(procedure!),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          MyTextFormField(
                                            initialValue: widget.eventProcedures
                                                .precedureDescription,
                                            fontSize: 16,
                                            label: 'Digite observação',
                                            placeholder:
                                                'Digite a observação do procedimento',
                                            inputType: TextInputType.text,
                                            onChanged: (value) {
                                              editEventProcedureStore
                                                  .setDescription(value);
                                            },
                                            validators: const {
                                              'required': true,
                                              'minLength': 3
                                            },
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          MyTextFormField(
                                            initialValue: widget
                                                .eventProcedures.procedureValue,
                                            fontSize: 16,
                                            label: 'Digite o valor',
                                            placeholder:
                                                'Digite o valor do procimento',
                                            inputType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              RealInputFormatter(moeda: true),
                                            ],
                                            onChanged: (value) {
                                              editEventProcedureStore
                                                  .setAmountCents(value);
                                            },
                                            validators: const {
                                              'required': true,
                                              'minLength': 3
                                            },
                                          ),
                                        ],
                                      ),
                                      DropdownHealthInsurancesOthers(
                                        healthInsuranceList:
                                            editEventProcedureStore
                                                .healthInsuranceListOthers,
                                        selectedHealthInsurance:
                                            editEventProcedureStore
                                                    .healthInsuranceOther ??
                                                editEventProcedureStore
                                                    .findHealthInsuranceCustom(
                                                        widget.eventProcedures
                                                                .healthInsurance ??
                                                            "")!,
                                        onChanged: (HealthInsurance?
                                                healthInsurance) =>
                                            editEventProcedureStore
                                                .setHealthInsuranceOther(
                                                    healthInsurance!),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 8.0,
                                      width: 5.0,
                                      child: CustomPaint(
                                        painter: TrianglePainter(),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(6.0),
                                              bottomLeft:
                                                  Radius.circular(6.0))),
                                      width: 120.0,
                                      height: 30.0,
                                      child: const Center(
                                        child: Text(
                                          'Outros',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomSwitch(
                          labelText: "Pago",
                          initialValue: editEventProcedureStore.payd ?? false,
                          onChanged: (value) {
                            editEventProcedureStore.setPayd(value);
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Center(child: Observer(builder: (_) {
                          return MyButtonWidget(
                            text: 'Editar procedimento',
                            isLoading: editEventProcedureStore.saveState ==
                                SaveEventProcedureState.loading,
                            disabledColor: Colors.grey,
                            onTap: editEventProcedureStore.isValidData
                                ? () async {
                                    _formKey.currentState?.save();
                                    if (_formKey.currentState!.validate()) {
                                      editEventProcedureStore
                                          .editEventProcedure(
                                              widget.eventProcedures.id ?? 0);
                                    } else {
                                      CustomToast.show(context,
                                          type: ToastType.error,
                                          title: "Editar evento",
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
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
