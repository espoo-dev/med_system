import 'package:distrito_medico/core/pages/success/success.page.dart';
import 'package:distrito_medico/core/utils/navigation_utils.dart';
import 'package:distrito_medico/core/utils/utils.dart';
import 'package:distrito_medico/core/widgets/error.widget.dart';
import 'package:distrito_medico/core/widgets/my_app_bar.widget.dart';
import 'package:distrito_medico/core/widgets/my_button_widget.dart';
import 'package:distrito_medico/core/widgets/my_date_input.widget.dart';
import 'package:distrito_medico/core/widgets/my_time_input.widget.dart';
import 'package:distrito_medico/core/widgets/my_toast.widget.dart';
import 'package:distrito_medico/core/widgets/custom_switch.widget.dart';
import 'package:distrito_medico/features/medical_shifts/domain/entities/medical_shift_entity.dart';
import 'package:distrito_medico/features/medical_shifts/pages/medical_shifts_page.dart';
import 'package:distrito_medico/features/medical_shifts/pages/widgets/radio_group_workload.widget.dart';
import 'package:distrito_medico/features/medical_shifts/presentation/viewmodels/update_medical_shift_viewmodel.dart';
import 'package:distrito_medico/features/procedures/util/real_input_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

class EditMedicalShiftPage extends StatefulWidget {
  final MedicalShiftEntity medicalShift;

  const EditMedicalShiftPage({super.key, required this.medicalShift});

  @override
  State<EditMedicalShiftPage> createState() => _EditMedicalShiftPageState();
}

class _EditMedicalShiftPageState extends State<EditMedicalShiftPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _viewModel = GetIt.I.get<UpdateMedicalShiftViewModel>();
  final List<ReactionDisposer> _disposers = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers.add(
        reaction<UpdateMedicalShiftState>((_) => _viewModel.state, (state) {
      if (state == UpdateMedicalShiftState.success) {
        to(
            context,
            const SuccessPage(
              title: 'Plantão editado com sucesso!',
              goToPage: MedicalShiftsPage(),
            ));
      } else if (state == UpdateMedicalShiftState.error) {
        CustomToast.show(context,
            type: ToastType.error,
            title: "Editar plantão",
            description: _viewModel.errorMessage.isNotEmpty
                ? _viewModel.errorMessage
                : "Ocorreu um erro ao tentar editar plantão.");
      }
    }));
  }

  @override
  void initState() {
    super.initState();
    _viewModel.init(widget.medicalShift);
    _viewModel.loadSuggestions();
  }

  @override
  void dispose() {
    for (var disposer in _disposers) {
      disposer();
    }
    // _viewModel.dispose(); // Lazy singleton persists
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) return;
        to(context, const MedicalShiftsPage());
      },
      child: Scaffold(
        appBar: const MyAppBar(
          title: 'Editar Plantão',
          hideLeading: true,
          image: null,
        ),
        body: Observer(
          builder: (BuildContext context) {
            if (_viewModel.state == UpdateMedicalShiftState.error) {
              return Center(
                child: ErrorRetryWidget(
                  'Algo deu errado',
                  'Por favor, tente novamente',
                  () {
                    _viewModel.init(widget.medicalShift);
                    _viewModel.loadSuggestions();
                  },
                ),
              );
            }
            if (_viewModel.state == UpdateMedicalShiftState.loading) {
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
      padding: const EdgeInsets.all(20),
      children: [
        SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Autocomplete(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text.isEmpty) {
                      return const Iterable<String>.empty();
                    } else {
                      return _viewModel.hospitalSuggestions.where((word) => word
                          .toLowerCase()
                          .contains(textEditingValue.text.toLowerCase()));
                    }
                  },
                  onSelected: (String selectedHospital) {
                    _viewModel.setHospitalName(selectedHospital);
                  },
                  fieldViewBuilder:
                      (context, controller, focusNode, onEditingComplete) {
                    // Initial value only if empty or matching?
                    // Controller text must reflect viewModel.hospitalName.
                    // If we set it every build, cursor jumps?
                    // Better to set it once or if different.
                    // For Simplicity in MVVM with TextField, often controller is local and syncs with VM.
                    // Here we can initialize it.
                    if (controller.text.isEmpty &&
                        _viewModel.hospitalName.isNotEmpty) {
                      controller.text = _viewModel.hospitalName;
                    }

                    return TextField(
                      controller: controller,
                      onChanged: _viewModel.setHospitalName,
                      focusNode: focusNode,
                      onEditingComplete: onEditingComplete,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          hintText: "Digite nome do hospital",
                          label: const Text("Nome hospital")),
                    );
                  },
                ),
                const SizedBox(height: 15),
                const Text("Carga horária",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
                MyRadioGroupWorkLoad(
                  onValueChanged: _viewModel.setWorkload,
                  initialValue: _viewModel.workload,
                ),
                const SizedBox(height: 15),
                Observer(builder: (_) {
                  return MyInputDate(
                    key: ValueKey(_viewModel.startDate),
                    onChanged: _viewModel.setStartDate,
                    label: 'Data início',
                    selectedDate: convertStringToDate(_viewModel.startDate),
                    textColor: Theme.of(context).colorScheme.primary,
                  );
                }),
                const SizedBox(height: 15),
                Observer(builder: (_) {
                  return MyInputTime(
                    key: ValueKey(_viewModel.startHour),
                    label: 'Hora início',
                    selectedTime: stringToTimeOfDay(_viewModel.startHour),
                    onChanged: _viewModel.setStartHour,
                    textColor: Theme.of(context).colorScheme.primary,
                  );
                }),
                const SizedBox(height: 15),
                Autocomplete(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    String query = textEditingValue.text;
                    List<String> suggestions = _viewModel.amountSuggestions;

                    String cleanString(String str) {
                      return str.replaceAll(RegExp(r'[^0-9]'), '');
                    }

                    if (query.isEmpty) {
                      return const Iterable<String>.empty();
                    } else {
                      String cleanedQuery = cleanString(query);
                      return suggestions.where((suggestion) {
                        String cleanedSuggestion = cleanString(suggestion);
                        return cleanedSuggestion.contains(cleanedQuery);
                      });
                    }
                  },
                  onSelected: (String selectedAmount) {
                    _viewModel.setAmountCents(selectedAmount);
                  },
                  fieldViewBuilder:
                      (context, controller, focusNode, onEditingComplete) {
                    // Format intial amount
                    if (controller.text.isEmpty && _viewModel.amount > 0) {
                      controller.text =
                          NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$')
                              .format(_viewModel.amount);
                    }

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
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          hintText: "Digite valor do plantão",
                          label: const Text("Valor plantão")),
                    );
                  },
                ),
                const SizedBox(height: 15),
                CustomSwitch(
                  labelText: "Pago",
                  initialValue: _viewModel.paid,
                  onChanged: _viewModel.setPaid,
                ),
                const SizedBox(height: 15),
                // Color Picker
                const Text("Cor do evento",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 8),
                Observer(builder: (_) {
                  Color currentColor = _viewModel.color != null
                      ? Color(
                          int.parse(_viewModel.color!.replaceAll('#', '0xFF')))
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
                                  String hex = pickerColor.value
                                      .toRadixString(16)
                                      .padLeft(8, '0')
                                      .toUpperCase();
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
                          Icon(Icons.palette,
                              color: currentColor.computeLuminance() > 0.5
                                  ? Colors.black
                                  : Colors.white),
                          const SizedBox(width: 8),
                          Text(
                            _viewModel.color ?? "Toque para selecionar",
                            style: TextStyle(
                              color: currentColor.computeLuminance() > 0.5
                                  ? Colors.black
                                  : Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 15),
                Center(
                  child: Observer(builder: (_) {
                    return MyButtonWidget(
                      text: 'Salvar alterações',
                      isLoading:
                          _viewModel.state == UpdateMedicalShiftState.loading,
                      disabledColor: Colors.grey,
                      onTap: _viewModel.isValidData
                          ? () async {
                              _formKey.currentState?.save();
                              if (_formKey.currentState!.validate()) {
                                _viewModel.updateMedicalShift();
                              } else {
                                CustomToast.show(context,
                                    type: ToastType.error,
                                    title: "Editar Plantão",
                                    description:
                                        "Por favor, preencha os campos.");
                              }
                            }
                          : null,
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
