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
import 'package:distrito_medico/core/widgets/color_picker.widget.dart';
import 'package:distrito_medico/core/utils/color_helper.dart';
import 'package:distrito_medico/features/medical_shifts/pages/medical_shifts_page.dart';
import 'package:distrito_medico/features/medical_shifts/pages/widgets/radio_group_workload.widget.dart';
import 'package:distrito_medico/features/medical_shifts/store/edit_medical_shift.store.dart';
import 'package:distrito_medico/features/procedures/util/real_input_format.dart';
import 'package:distrito_medico/features/medical_shifts/model/medical_shift.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

class EditMedicalShiftPage extends StatefulWidget {
  final MedicalShiftModel medicalShift;

  const EditMedicalShiftPage({super.key, required this.medicalShift});

  @override
  State<EditMedicalShiftPage> createState() => _EditMedicalShiftPageState();
}

class _EditMedicalShiftPageState extends State<EditMedicalShiftPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final editMedicalShiftStore = GetIt.I.get<EditMedicalShiftStore>();
  final List<ReactionDisposer> _disposers = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers.add(reaction<EditMedicalShiftState>(
        (_) => editMedicalShiftStore.saveState, (validationState) {
      if (validationState == EditMedicalShiftState.success) {
        to(
            context,
            const SuccessPage(
              title: 'Plantão editado com sucesso!',
              goToPage: MedicalShiftsPage(),
            ));
      } else if (validationState == EditMedicalShiftState.error) {
        CustomToast.show(context,
            type: ToastType.error,
            title: "Editar plantão",
            description: "Ocorreu um erro ao tentar editar plantão.");
      }
    }));
  }

  @override
  void initState() {
    super.initState();
    editMedicalShiftStore.initializeWithShift(widget.medicalShift);
    editMedicalShiftStore.getAmountSuggestions();
    editMedicalShiftStore.getHospitalNameSuggestions();
    if (editMedicalShiftStore.color == null) {
      editMedicalShiftStore.setColor(
          ColorHelper.colorToHex(ColorHelper.defaultMedicalShiftColor));
    }
  }

  @override
  void dispose() {
    for (var disposer in _disposers) {
      disposer();
    }
    editMedicalShiftStore.dispose();
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
          title: 'Editar Plantão',
          hideLeading: true,
          image: null,
        ),
        body: Observer(
          builder: (BuildContext context) {
            if (editMedicalShiftStore.medicalShiftState ==
                MedicalShiftState.error) {
              return Center(
                child: ErrorRetryWidget(
                  'Algo deu errado',
                  'Por favor, tente novamente',
                  () {
                    editMedicalShiftStore.fetchAllData();
                  },
                ),
              );
            }
            if (editMedicalShiftStore.medicalShiftState ==
                MedicalShiftState.loading) {
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
                      return editMedicalShiftStore.hospitalNameSuggestions
                          .where((word) => word
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase()));
                    }
                  },
                  onSelected: (String selectedHospital) {
                    editMedicalShiftStore.setHospitalName(selectedHospital);
                  },
                  fieldViewBuilder:
                      (context, controller, focusNode, onEditingComplete) {
                    controller.text = editMedicalShiftStore.hospitalName;
                    return TextField(
                      controller: controller,
                      onChanged: editMedicalShiftStore.setHospitalName,
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
                  onValueChanged: editMedicalShiftStore.setWorkload,
                  initialValue: editMedicalShiftStore.workload,
                ),
                const SizedBox(height: 15),
                MyInputDate(
                  onChanged: editMedicalShiftStore.setStartDate,
                  label: 'Data início',
                  selectedDate:
                      convertStringToDate(editMedicalShiftStore.startDate),
                  textColor: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 15),
                MyInputTime(
                  label: 'Hora início',
                  selectedTime:
                      stringToTimeOfDay(editMedicalShiftStore.startHour),
                  onChanged: editMedicalShiftStore.setStartHour,
                  textColor: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 15),
                Autocomplete(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    String query = textEditingValue.text;
                    List<String> suggestions =
                        editMedicalShiftStore.amountSuggestions;

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
                    editMedicalShiftStore.setAmountCents(selectedAmount);
                  },
                  fieldViewBuilder:
                      (context, controller, focusNode, onEditingComplete) {
                    controller.text = editMedicalShiftStore.amountCents;
                    return TextField(
                      controller: controller,
                      onChanged: editMedicalShiftStore.setAmountCents,
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
                // AutoCompleteReal(
                //   key: UniqueKey(),
                //   isCurrency: true,
                //   fontSize: 16,
                //   label: 'Valor plantão',
                //   placeholder: 'Digite o valor do plantão',
                //   suggestions: editMedicalShiftStore.amountSuggestions,
                //   initialValue: editMedicalShiftStore.amountCents,
                //   inputType: TextInputType.number,
                //   inputFormatters: [
                //     FilteringTextInputFormatter.digitsOnly,
                //     RealInputFormatter(moeda: true),
                //   ],
                //   onChanged: editMedicalShiftStore.setAmountCents,
                //   validators: const {'required': true, 'minLength': 3},
                // ),
                const SizedBox(height: 15),
                CustomSwitch(
                  labelText: "Pago",
                  initialValue: editMedicalShiftStore.paid,
                  onChanged: editMedicalShiftStore.setpaid,
                ),
                const SizedBox(height: 15),
                Observer(builder: (_) {
                  return ColorPickerWidget(
                    currentColor: ColorHelper.hexToColor(
                      editMedicalShiftStore.color,
                      defaultColor: ColorHelper.defaultMedicalShiftColor,
                    ),
                    onColorChanged: (color) {
                      editMedicalShiftStore.setColor(
                        ColorHelper.colorToHex(color),
                      );
                    },
                    label: 'Cor do Plantão',
                  );
                }),
                const SizedBox(height: 15),
                Center(
                  child: Observer(builder: (_) {
                    return MyButtonWidget(
                      text: 'Salvar alterações',
                      isLoading: editMedicalShiftStore.saveState ==
                          EditMedicalShiftState.loading,
                      disabledColor: Colors.grey,
                      onTap: editMedicalShiftStore.isValidData
                          ? () async {
                              _formKey.currentState?.save();
                              if (_formKey.currentState!.validate()) {
                                editMedicalShiftStore.updateMedicalShift(
                                    widget.medicalShift.id!);
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
