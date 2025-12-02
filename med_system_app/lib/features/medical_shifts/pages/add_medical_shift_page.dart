import 'package:distrito_medico/core/pages/success/success.page.dart';
import 'package:distrito_medico/core/utils/navigation_utils.dart';

import 'package:distrito_medico/core/widgets/error.widget.dart';
import 'package:distrito_medico/core/widgets/my_app_bar.widget.dart';
import 'package:distrito_medico/core/widgets/my_button_widget.dart';
import 'package:distrito_medico/core/widgets/my_date_input.widget.dart';
import 'package:distrito_medico/core/widgets/my_time_input.widget.dart';
import 'package:distrito_medico/core/widgets/my_toast.widget.dart';
import 'package:distrito_medico/core/widgets/custom_switch.widget.dart';
import 'package:distrito_medico/features/home/pages/home_page.dart';
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
  final bool backToHome;
  final DateTime? initialDate;

  const AddMedicalShiftPage({
    super.key,
    this.backToHome = false,
    this.initialDate,
  });

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

  List<String> addSpaceToCurrency(List<String> amounts) {
    return amounts.map((amount) {
      return amount.replaceFirst("R\$", "R\$ ");
    }).toList();
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
          if (widget.backToHome) {
            to(context, const HomePage());
          } else {
            to(context, const MedicalShiftsPage());
          }
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
                        Autocomplete(
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            if (textEditingValue.text.isEmpty) {
                              return const Iterable<String>.empty();
                            } else {
                              return addMedicalShiftStore
                                  .hospitalNameSuggestions
                                  .where((word) => word.toLowerCase().contains(
                                      textEditingValue.text.toLowerCase()));
                            }
                          },
                          onSelected: addMedicalShiftStore.setHospitalName,
                          fieldViewBuilder: (context, controller, focusNode,
                              onEditingComplete) {
                            return TextField(
                              controller: controller,
                              onChanged: addMedicalShiftStore.setHospitalName,
                              focusNode: focusNode,
                              onEditingComplete: onEditingComplete,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ),
                                  hintText: "Digite nome do hospital",
                                  label: const Text("Nome hospital")),
                            );
                          },
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
                          selectedDate: widget.initialDate ?? DateTime.now(),
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
                        Autocomplete(
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            String query = textEditingValue.text;
                            List<String> suggestions =
                                addMedicalShiftStore.amountSuggestions;

                            String cleanString(String str) {
                              return str.replaceAll(RegExp(r'[^0-9]'), '');
                            }

                            if (query.isEmpty) {
                              return const Iterable<String>.empty();
                            } else {
                              String cleanedQuery = cleanString(query);
                              return suggestions.where((suggestion) {
                                String cleanedSuggestion =
                                    cleanString(suggestion);
                                return cleanedSuggestion.contains(cleanedQuery);
                              });
                            }
                          },
                          onSelected: addMedicalShiftStore.setAmountCents,
                          fieldViewBuilder: (context, controller, focusNode,
                              onEditingComplete) {
                            return TextField(
                              controller: controller,
                              onChanged: addMedicalShiftStore.setAmountCents,
                              focusNode: focusNode,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                RealInputFormatter(moeda: true),
                              ],
                              onEditingComplete: onEditingComplete,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ),
                                  hintText: "Digite valor do plantão",
                                  label: const Text("Valor plantão")),
                            );
                          },
                        ),
                        // AutoCompleteReal(
                        //   isCurrency: true,
                        //   fontSize: 16,
                        //   label: 'Valor plantão',
                        //   placeholder: 'Digite o valor do plantão',
                        //   suggestions: addMedicalShiftStore.amountSuggestions,
                        //   inputType: TextInputType.number,
                        //   inputFormatters: [
                        //     FilteringTextInputFormatter.digitsOnly,
                        //     RealInputFormatter(moeda: true),
                        //   ],
                        //   onChanged: addMedicalShiftStore.setAmountCents,
                        //   validators: const {'required': true, 'minLength': 3},
                        // ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomSwitch(
                          labelText: "Pago",
                          initialValue: false,
                          onChanged: addMedicalShiftStore.setpaid,
                        ),
                        // Recurrence Section
                        Observer(builder: (_) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomSwitch(
                                labelText: "Recorrente",
                                initialValue: addMedicalShiftStore.isRecurrent,
                                onChanged: addMedicalShiftStore.setIsRecurrent,
                              ),
                              if (addMedicalShiftStore.isRecurrent) ...[
                                const SizedBox(height: 15),
                                const Text(
                                  "Frequência",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                DropdownButtonFormField<String>(
                                  value: addMedicalShiftStore.frequency,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                    ),
                                    hintText: "Selecione a frequência",
                                  ),
                                  items: const [
                                    DropdownMenuItem(
                                      value: "weekly",
                                      child: Text("Semanal"),
                                    ),
                                    DropdownMenuItem(
                                      value: "biweekly",
                                      child: Text("Quinzenal"),
                                    ),
                                    DropdownMenuItem(
                                      value: "monthly_fixed_day",
                                      child: Text("Escolha um dia"),
                                    ),
                                  ],
                                  onChanged: addMedicalShiftStore.setFrequency,
                                ),
                                if (addMedicalShiftStore.frequency != null &&
                                    addMedicalShiftStore.frequency !=
                                        'monthly_fixed_day') ...[
                                  const SizedBox(height: 15),
                                  const Text(
                                    "Dia da Semana",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  DropdownButtonFormField<int>(
                                    value: addMedicalShiftStore.dayOfWeek,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                      ),
                                      hintText: "Selecione o dia da semana",
                                    ),
                                    items: const [
                                      DropdownMenuItem(
                                          value: 0, child: Text("Domingo")),
                                      DropdownMenuItem(
                                          value: 1, child: Text("Segunda")),
                                      DropdownMenuItem(
                                          value: 2, child: Text("Terça")),
                                      DropdownMenuItem(
                                          value: 3, child: Text("Quarta")),
                                      DropdownMenuItem(
                                          value: 4, child: Text("Quinta")),
                                      DropdownMenuItem(
                                          value: 5, child: Text("Sexta")),
                                      DropdownMenuItem(
                                          value: 6, child: Text("Sábado")),
                                    ],
                                    onChanged:
                                        addMedicalShiftStore.setDayOfWeek,
                                  ),
                                ],
                                if (addMedicalShiftStore.frequency ==
                                    'monthly_fixed_day') ...[
                                  const SizedBox(height: 15),
                                  const Text(
                                    "Dia do Mês",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  DropdownButtonFormField<int>(
                                    value: addMedicalShiftStore.dayOfMonth,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                      ),
                                      hintText: "Selecione o dia do mês",
                                    ),
                                    items: List.generate(
                                      31,
                                      (index) => DropdownMenuItem(
                                        value: index + 1,
                                        child: Text("${index + 1}"),
                                      ),
                                    ),
                                    onChanged:
                                        addMedicalShiftStore.setDayOfMonth,
                                  ),
                                ],
                                const SizedBox(height: 15),
                                const Text(
                                  "Data Final (Opcional)",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () async {
                                          final ThemeData theme =
                                              Theme.of(context);
                                          final ColorScheme colorScheme =
                                              theme.colorScheme.copyWith(
                                            primary: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            onPrimary: Colors.white,
                                            onBackground: Colors.white,
                                            surfaceTint: Colors.white,
                                          );

                                          final date = await showDatePicker(
                                            context: context,
                                            helpText: 'Selecione a data final',
                                            locale: const Locale('pt', 'BR'),
                                            initialEntryMode:
                                                DatePickerEntryMode.calendar,
                                            initialDate: addMedicalShiftStore
                                                        .endDate !=
                                                    null
                                                ? _parseDate(
                                                    addMedicalShiftStore
                                                        .endDate!)
                                                : DateTime.now()
                                                    .add(Duration(days: 30)),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(
                                                DateTime.now().year + 5),
                                            builder: (BuildContext context,
                                                Widget? child) {
                                              return Theme(
                                                data: theme.copyWith(
                                                    colorScheme: colorScheme),
                                                child: child ?? Container(),
                                              );
                                            },
                                          );

                                          if (date != null) {
                                            String formattedDate =
                                                "${date.day}/${date.month}/${date.year}";

                                            // Validate end date is after start date
                                            if (addMedicalShiftStore
                                                .startDate.isNotEmpty) {
                                              DateTime startDate = _parseDate(
                                                  addMedicalShiftStore
                                                      .startDate);
                                              if (date.isBefore(startDate) ||
                                                  date.isAtSameMomentAs(
                                                      startDate)) {
                                                CustomToast.show(context,
                                                    type: ToastType.error,
                                                    title: "Data inválida",
                                                    description:
                                                        "A data final deve ser maior que a data inicial.");
                                                return;
                                              }
                                            }

                                            addMedicalShiftStore
                                                .setEndDate(formattedDate);
                                          }
                                        },
                                        child: InputDecorator(
                                          decoration: InputDecoration(
                                            hintText: "Selecione a data final",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ),
                                            ),
                                          ),
                                          child: Text(
                                            addMedicalShiftStore.endDate ??
                                                "Selecione a data final",
                                            style: TextStyle(
                                              color: addMedicalShiftStore
                                                          .endDate !=
                                                      null
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .primary
                                                  : Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (addMedicalShiftStore.endDate != null)
                                      IconButton(
                                        icon: const Icon(Icons.clear),
                                        color: Colors.red,
                                        onPressed: () {
                                          addMedicalShiftStore.setEndDate(null);
                                        },
                                      ),
                                  ],
                                ),
                              ],
                            ],
                          );
                        }),
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

  DateTime _parseDate(String dateString) {
    // Parse date in format dd/MM/yyyy
    final parts = dateString.split('/');
    if (parts.length == 3) {
      return DateTime(
        int.parse(parts[2]), // year
        int.parse(parts[1]), // month
        int.parse(parts[0]), // day
      );
    }
    return DateTime.now();
  }
}
