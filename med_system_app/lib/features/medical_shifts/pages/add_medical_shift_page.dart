import 'package:distrito_medico/core/pages/success/success.page.dart';
import 'package:distrito_medico/core/utils/navigation_utils.dart';
import 'package:distrito_medico/core/widgets/my_app_bar.widget.dart';
import 'package:distrito_medico/core/widgets/my_button_widget.dart';
import 'package:distrito_medico/core/widgets/my_date_input.widget.dart';
import 'package:distrito_medico/core/widgets/my_time_input.widget.dart';
import 'package:distrito_medico/core/widgets/my_toast.widget.dart';
import 'package:distrito_medico/core/widgets/custom_switch.widget.dart';
import 'package:distrito_medico/features/home/pages/home_page.dart';
import 'package:distrito_medico/features/medical_shifts/pages/medical_shifts_page.dart';
import 'package:distrito_medico/features/medical_shifts/pages/widgets/radio_group_workload.widget.dart';
import 'package:distrito_medico/features/medical_shifts/presentation/viewmodels/create_medical_shift_viewmodel.dart';
import 'package:distrito_medico/features/procedures/util/real_input_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
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
  final _viewModel = GetIt.I.get<CreateMedicalShiftViewModel>();
  final List<ReactionDisposer> _disposers = [];
  bool _isColorInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers.add(reaction<CreateMedicalShiftState>(
        (_) => _viewModel.state, (state) {
      if (state == CreateMedicalShiftState.success) {
        to(
            context,
            const SuccessPage(
              title: 'Plantão criado com sucesso!',
              goToPage: MedicalShiftsPage(),
            ));
      } else if (state == CreateMedicalShiftState.error) {
        CustomToast.show(context,
            type: ToastType.error,
            title: "Cadastrar novo Plantão",
            description: _viewModel.errorMessage.isNotEmpty 
                ? _viewModel.errorMessage 
                : "Ocorreu um erro ao tentar cadastrar.");
      }
    }));

    if (!_isColorInitialized) {
      final primary = Theme.of(context).colorScheme.primary;
      String hexInt = primary.value.toRadixString(16).padLeft(8, '0').toUpperCase();
      // toRadixString returns ARGB, we want RGB usually for hex codes if opacity isn't key, but format #AARRGGBB is fine if parsed correctly.
      // The parser used later is: int.parse(_viewModel.color!.replaceAll('#', '0xFF')) which assumes the stored string is #RRGGBB and replaces # with 0xFF (full opacity).
      // So I should store #RRGGBB.
      if (hexInt.length == 8) {
          hexInt = hexInt.substring(2);
      }
      String hex = '#$hexInt';
      
      // Only set if not already set (e.g. by user navigation back and forth without dispose? but reset is called on initState)
      if (_viewModel.color == null) {
          _viewModel.setColor(hex);
      }
      _isColorInitialized = true;
    }
  }

  @override
  void initState() {
    super.initState();
    _viewModel.reset(); // Reset viewmodel on entry
    _viewModel.loadSuggestions();
    
    // Set initial date if provided
    if (widget.initialDate != null) {
      // Assuming format needed is String
      // MyInputDate expects what? It emits normalized string.
      // But _viewModel.startDate expects String.
      String formatted = "${widget.initialDate!.day.toString().padLeft(2, '0')}/${widget.initialDate!.month.toString().padLeft(2, '0')}/${widget.initialDate!.year}";
      _viewModel.setStartDate(formatted);
    }
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
    // _viewModel.dispose? Store mixin doesn't have dispose, but we can call reset if we want.
    // _viewModel.reset(); // Done at initState
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
              /*
              // Since state is singular, 'loading' blocks the whole form?
              // The original only showed loading instead of form.
              if (_viewModel.state == CreateMedicalShiftState.loading) {
                 return const Center(child: CircularProgressIndicator());
              }
              // But 'loading' also happens when fetching suggestions?
              // No, 'loadSuggestions' doesn't set state to loading in ViewModel (it's async void).
              // Only createMedicalShift sets state to loading.
              */
              if (_viewModel.state == CreateMedicalShiftState.loading) {
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
                              return _viewModel
                                  .hospitalSuggestions
                                  .where((word) => word.toLowerCase().contains(
                                      textEditingValue.text.toLowerCase()));
                            }
                          },
                          onSelected: _viewModel.setHospitalName,
                          fieldViewBuilder: (context, controller, focusNode,
                              onEditingComplete) {
                            return TextField(
                              controller: controller,
                              onChanged: _viewModel.setHospitalName,
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
                            onValueChanged: _viewModel.setWorkload,
                            initialValue: _viewModel.workload,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        MyInputDate(
                          onChanged: _viewModel.setStartDate,
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
                            onChanged: _viewModel.setStartHour,
                            textColor: Theme.of(context).colorScheme.primary),
                        const SizedBox(
                          height: 15,
                        ),
                        Autocomplete(
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            String query = textEditingValue.text;
                            List<String> suggestions =
                                _viewModel.amountSuggestions;

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
                          onSelected: _viewModel.setAmountCents,
                          fieldViewBuilder: (context, controller, focusNode,
                              onEditingComplete) {
                            return TextField(
                              controller: controller,
                              onChanged: _viewModel.setAmountCents,
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
                        const SizedBox(
                          height: 15,
                        ),
                        CustomSwitch(
                          labelText: "Pago",
                          initialValue: false,
                          onChanged: _viewModel.setPaid,
                        ),
                        // Recurrence Section
                        Observer(builder: (_) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomSwitch(
                                labelText: "Recorrente",
                                initialValue: _viewModel.isRecurrent,
                                onChanged: _viewModel.setIsRecurrent,
                              ),
                              if (_viewModel.isRecurrent) ...[
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
                                  value: _viewModel.frequency,
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
                                  onChanged: _viewModel.setFrequency,
                                ),
                                if (_viewModel.frequency != null &&
                                    _viewModel.frequency !=
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
                                    value: _viewModel.dayOfWeek,
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
                                        _viewModel.setDayOfWeek,
                                  ),
                                ],
                                if (_viewModel.frequency ==
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
                                    value: _viewModel.dayOfMonth,
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
                                        _viewModel.setDayOfMonth,
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
                                            initialDate: _viewModel
                                                        .endDate !=
                                                    null
                                                ? _parseDate(
                                                    _viewModel
                                                        .endDate!)
                                                : DateTime.now()
                                                    .add(const Duration(days: 30)),
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

                                          if (!context.mounted) return;

                                          if (date != null) {
                                            String formattedDate =
                                                "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";

                                            // Validate end date is after start date
                                            if (_viewModel
                                                .startDate.isNotEmpty) {
                                              DateTime startDate = _parseDate(
                                                  _viewModel
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

                                            _viewModel
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
                                            _viewModel.endDate ??
                                                "Selecione a data final",
                                            style: TextStyle(
                                              color: _viewModel
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
                                    if (_viewModel.endDate != null)
                                      IconButton(
                                        icon: const Icon(Icons.clear),
                                        color: Colors.red,
                                        onPressed: () {
                                          _viewModel.setEndDate(null);
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
                        // Color Picker
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Cor do evento",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        const SizedBox(height: 8),
                        Observer(builder: (_) {
                          Color currentColor = _viewModel.color != null
                              ? Color(int.parse(_viewModel.color!.replaceAll('#', '0xFF')))
                              : Theme.of(context).colorScheme.primary;

                          return GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  Color pickerColor = currentColor;
                                  return AlertDialog(
                                    title: const Text('Escolha uma cor'),
                                    content: SingleChildScrollView(
                                      child: BlockPicker(
                                        pickerColor: pickerColor,
                                        onColorChanged: (Color color) {
                                          pickerColor = color;
                                        },
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Cancelar'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: const Text('Selecionar'),
                                        onPressed: () {
                                          // Format FF0000 -> #000000
                                          String hex = pickerColor.value.toRadixString(16).padLeft(8, '0').toUpperCase();
                                          if (hex.length == 8) {
                                            hex = hex.substring(2);
                                          }
                                          String hexColor = '#$hex';
                                          _viewModel.setColor(hexColor);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: currentColor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.palette, color: currentColor.computeLuminance() > 0.5 ? Colors.black : Colors.white),
                                  const SizedBox(width: 8),
                                  Text(
                                    _viewModel.color ?? "Toque para selecionar",
                                    style: TextStyle(
                                      color: currentColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                        const SizedBox(
                          height: 15,
                        ),
                        Center(child: Observer(builder: (_) {
                          return MyButtonWidget(
                            text: 'Cadastrar plantão',
                            isLoading: _viewModel.state ==
                                CreateMedicalShiftState.loading,
                            disabledColor: Colors.grey,
                            onTap: _viewModel.isValidData
                                ? () async {
                                    _formKey.currentState?.save();
                                    if (_formKey.currentState!.validate()) {
                                      _viewModel.createMedicalShift();
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
