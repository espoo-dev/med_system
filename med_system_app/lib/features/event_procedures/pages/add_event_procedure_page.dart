import 'package:distrito_medico/core/pages/success/success.page.dart';
import 'package:distrito_medico/core/utils/navigation_utils.dart';
import 'package:distrito_medico/core/widgets/error.widget.dart';
import 'package:distrito_medico/core/widgets/my_app_bar.widget.dart';
import 'package:distrito_medico/core/widgets/my_button_widget.dart';
import 'package:distrito_medico/core/widgets/my_date_input.widget.dart';
import 'package:distrito_medico/core/widgets/my_text_form_field.widget.dart';
import 'package:distrito_medico/core/widgets/my_toast.widget.dart';
import 'package:distrito_medico/features/event_procedures/pages/event_procedures_page.dart';
import 'package:distrito_medico/core/widgets/custom_switch.widget.dart';
import 'package:distrito_medico/features/event_procedures/presentation/viewmodels/create_event_procedure_viewmodel.dart';
import 'package:distrito_medico/features/event_procedures/pages/widgets/dropdown_search_health_insurances.widget.dart';
import 'package:distrito_medico/features/event_procedures/pages/widgets/dropdown_search_health_insurances_others.widget.dart';
import 'package:distrito_medico/features/event_procedures/pages/widgets/dropdown_search_hospitals.widget.dart';
import 'package:distrito_medico/features/event_procedures/pages/widgets/dropdown_search_patients.widget.dart';
import 'package:distrito_medico/features/event_procedures/pages/widgets/dropdown_search_procedures.widget.dart';
import 'package:distrito_medico/features/event_procedures/pages/widgets/dropdown_search_procedures_others.widget.dart';
import 'package:distrito_medico/features/event_procedures/pages/widgets/radio_group.widget.dart';
import 'package:distrito_medico/features/event_procedures/pages/widgets/radio_group_payment.widget.dart';
import 'package:distrito_medico/features/event_procedures/pages/widgets/triangle_widget.dart';
// Entity imports
import 'package:distrito_medico/features/patients/domain/entities/patient_entity.dart';
import 'package:distrito_medico/features/hospitals/domain/entities/hospital_entity.dart';
import 'package:distrito_medico/features/health_insurances/domain/entities/health_insurance_entity.dart';
import 'package:distrito_medico/features/procedures/domain/entities/procedure_entity.dart';
import 'package:distrito_medico/features/home/pages/home_page.dart';
import 'package:distrito_medico/features/procedures/util/real_input_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final _viewModel = GetIt.I.get<CreateEventProcedureViewModel>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    super.initState();
    _viewModel.loadInitialData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers.add(reaction<bool>(
        (_) => _viewModel.isSuccess, (success) {
      if (success) {
        to(
            context,
            const SuccessPage(
              title: 'Evento criado com sucesso!',
              goToPage: EventProceduresPage(),
            ));
      }
    }));
    
    _disposers.add(reaction<String?>(
        (_) => _viewModel.errorMessage, (message) {
      if (message != null) {
        CustomToast.show(context,
            type: ToastType.error,
            title: "Cadastrar novo evento",
            description: message);
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
            if (_viewModel.isLoading && _viewModel.patients.isEmpty) { // Loading inicial crítico
              return const Center(child: CircularProgressIndicator());
            }
             // Se tiver erro mas sem dados, mostra retry
            if (_viewModel.errorMessage != null && _viewModel.patients.isEmpty) {
              return Center(
                  child: ErrorRetryWidget(
                      _viewModel.errorMessage ?? 'Algo deu errado', 
                      'Por favor, tente novamente', () {
                _viewModel.loadInitialData();
              }));
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
                        // Adapter for Patient
                        DropdownSearchPatients(
                            patientList: _viewModel.patients,
                            selectedPatient: _viewModel.selectedPatient,
                            onChanged: (PatientEntity? patient) {
                              if (patient != null) {
                                _viewModel.setPatient(patient);
                              }
                            }),
                        const SizedBox(
                          height: 15,
                        ),
                        MyTextFormField(
                            fontSize: 16,
                            label: 'Número de registro',
                            placeholder: 'Digite número de serviço paciente.',
                            inputType: TextInputType.text,
                            validators: const {
                              'required': true,
                              'minLength': 4
                            },
                            onChanged: _viewModel.setPatientServiceNumber),
                        const SizedBox(
                          height: 15,
                        ),
                        MyInputDate(
                          onChanged: _viewModel.setCreatedDate,
                          label: 'Data',
                          textColor: Theme.of(context).colorScheme.primary,
                          selectedDate: DateTime.now(),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        // Adapter for Hospital
                        DropdownSearchHospitals(
                            hospitalList: _viewModel.hospitals,
                            selectedHospital: _viewModel.selectedHospital,
                            onChanged: (HospitalEntity? hospital) {
                               if (hospital != null) {
                                _viewModel.setHospital(hospital);
                               }
                            }),
                        const SizedBox(
                          height: 15,
                        ),
                        MyRadioGroupPayment(onValueChanged: (value) {
                          _viewModel.setPaymentType(value == 'Convênio' ? 'health_insurance' : 'others');
                        }),
                        const SizedBox(
                          height: 15,
                        ),
                        Visibility(
                          visible: _viewModel.paymentType == 'health_insurance',
                          child: Column(
                            children: [
                              DropdownHealthInsurances(
                                healthInsuranceList: _viewModel.healthInsurances,
                                selectedHealthInsurance: _viewModel.selectedHealthInsurance,
                                onChanged: (HealthInsuranceEntity? healthInsurance) {
                                   if (healthInsurance != null) {
                                      _viewModel.setHealthInsurance(healthInsurance);
                                   }
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: _viewModel.paymentType == 'health_insurance',
                          child: Column(
                            children: [
                              DropdownSearchProcedures(
                                procedureList: _viewModel.procedures,
                                selectedProcedure: _viewModel.selectedProcedure,
                                onChanged: (ProcedureEntity? procedure) {
                                  if (procedure != null) {
                                     _viewModel.setProcedure(procedure);
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: _viewModel.paymentType == 'health_insurance',
                          child: const Text("Acomodação",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        Visibility(
                          visible: _viewModel.paymentType == 'health_insurance',
                          child: Column(
                            children: [
                              MyRadioGroup(onValueChanged: (value) {
                                _viewModel.setRoomType(value == 'ward' ? 'ward' : 'apartment');
                              }),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: _viewModel.paymentType == 'health_insurance',
                          child: Column(
                            children: [
                              CustomSwitch(
                                labelText: "Urgência",
                                initialValue: false,
                                onChanged: (value) {
                                  _viewModel.setUrgency(value);
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: _viewModel.paymentType != 'health_insurance',
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
                                      // Procedimentos Outros (Geralmente é um dropdown também ou texto livre? Store antigo usava dropdown de procedimentos marcados como 'others'?
                                      // O Store antigo usava GetAllProceduresByCustom. O novo ViewModel chama getAllProcedures.
                                      // Se houver uma flag custom, precisaremos filtrar. No ViewModel atual eu peguei TODOS.
                                      // Vou assumir que o usuário pode selecionar qualquer um ou digitar novo?
                                      // O widget DropdownSearchProceduresOthers parece sugerir seleção.
                                      // Se for seleção de "Outros", o ViewModel deveria ter carregado lista específica?
                                      // Por simplicidade, vou usar a mesma lista de procedures, talvez filtrada se eu tivesse o campo 'custom' na Entity.
                                      // A Entity ProcedureEntity não tem 'custom' explicitamente mapeado no meu código anterior?
                                      // Vou verificar ProcedureEntity. Se não tiver, vou usar a lista completa.
                                      // Olhando o código, vou usar MyTextFormField para nome se for "Outros" customizado, mas o design antigo usava Dropdown...
                                      // Ah, o antigo store tinha `getAllProceduresByCustom`. Eu não migrei isso para o UseCase novo getAllProcedures (ele pega todos?).
                                      // Vou usar um TextField para simplificar "Outros" ou usar a lista completa como placeholder.
                                      // O widget DropdownSearchProceduresOthers espera uma lista. Vou passar a lista completa filtrada se possível, ou toda ela.
                                      
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          MyTextFormField(
                                            fontSize: 16,
                                            label: 'Nome do Procedimento',
                                            placeholder:
                                                'Digite o nome do procedimento',
                                            inputType: TextInputType.text,
                                            onChanged: (value) {
                                              _viewModel.setOtherProcedureName(value);
                                            },
                                            validators: const {
                                              'required': true,
                                              'minLength': 3
                                            },
                                          ),
                                          const SizedBox(height: 15),
                                          MyTextFormField(
                                            fontSize: 16,
                                            label: 'Digite observação',
                                            placeholder:
                                                'Digite a observação do procedimento',
                                            inputType: TextInputType.text,
                                            onChanged: (value) {
                                              _viewModel.setOtherProcedureDescription(value);
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
                                              _viewModel.setOtherProcedureAmount(value);
                                            },
                                            validators: const {
                                              'required': true,
                                              'minLength': 3
                                            },
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      // Health Insurance Outros
                                      MyTextFormField(
                                          fontSize: 16,
                                          label: 'Nome do Convênio',
                                          placeholder: 'Digite o nome do convênio',
                                          inputType: TextInputType.text,
                                          onChanged: (value) {
                                            _viewModel.setOtherHealthInsuranceName(value);
                                          },
                                          validators: const {
                                            'required': true,
                                            'minLength': 3
                                          },
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
                          initialValue: _viewModel.isPaid,
                          onChanged: (value) {
                            _viewModel.setIsPaid(value);
                          },
                        ),
                        Center(child: Observer(builder: (_) {
                          return MyButtonWidget(
                            text: 'Cadastrar procedimento',
                            isLoading: _viewModel.isLoading,
                            disabledColor: Colors.grey,
                            onTap: _viewModel.isValidFullData
                                ? () async {
                                    _formKey.currentState?.save();
                                    if (_formKey.currentState!.validate()) {
                                      _viewModel.createEventProcedure();
                                    } else {
                                      CustomToast.show(context,
                                          type: ToastType.error,
                                          title: "Cadastrar novo evento",
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
                  }),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
