import 'package:distrito_medico/core/widgets/my_app_bar.widget.dart';
import 'package:distrito_medico/core/widgets/my_text_form_field.widget.dart';
import 'package:distrito_medico/features/medical_shifts/store/medical_shift.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../../core/widgets/my_button_widget.dart';

class FilterMedicalShiftsPage extends StatefulWidget {
  const FilterMedicalShiftsPage({super.key});

  @override
  State<FilterMedicalShiftsPage> createState() =>
      _FilterMedicalShiftsPageState();
}

class _FilterMedicalShiftsPageState extends State<FilterMedicalShiftsPage> {
  final filterEventProcedureStore = GetIt.I.get<MedicalShiftStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Filtros',
        hideLeading: true,
        trailingIcon: const Text('Limpar'),
        onTrailingPressed: () {
          filterEventProcedureStore.clearFilters();
        },
        image: null,
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(left: 30, right: 20, top: 30, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Observer(builder: (_) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Selecione o ano',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  DropdownButton<int>(
                    value: filterEventProcedureStore.selectedYear,
                    hint: const Text('Selecione um ano'),
                    onChanged: (int? newValue) {
                      filterEventProcedureStore.setSelectedYear(newValue);
                    },
                    items: filterEventProcedureStore.years
                        .map<DropdownMenuItem<int>>(
                          (int year) => DropdownMenuItem<int>(
                            value: year,
                            child: Text(year.toString()),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Selecione o mês',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: filterEventProcedureStore.months.length,
                      itemBuilder: (context, index) {
                        final month = filterEventProcedureStore.months[index];
                        return Observer(builder: (_) {
                          return FilterChip(
                            label: Text(
                                filterEventProcedureStore.getMonthName(month)),
                            selected: filterEventProcedureStore.selectedMonth ==
                                month,
                            onSelected: (isSelected) {
                              filterEventProcedureStore
                                  .setSelectedMonth(isSelected ? month : null);
                            },
                          );
                        });
                      },
                    ),
                  ),
                  const Text(
                    'Selecione o status de pagamento',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<bool>(
                          title: const Text('Recebidos'),
                          value: true,
                          groupValue:
                              filterEventProcedureStore.selectedPaymentStatus,
                          onChanged: (value) {
                            filterEventProcedureStore
                                .setSelectedPaymentStatus(value);
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<bool>(
                          title: const Text('A Receber'),
                          value: false,
                          groupValue:
                              filterEventProcedureStore.selectedPaymentStatus,
                          onChanged: (value) {
                            filterEventProcedureStore
                                .setSelectedPaymentStatus(value);
                          },
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    'Nome do hospital',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  MyTextFormField(
                    label: 'Nome hospital',
                    placeholder: 'Digite nome do hospital',
                    inputType: TextInputType.text,
                    validators: const {
                      'required': true,
                      'minLength': 4,
                    },
                    onChanged: (value) =>
                        filterEventProcedureStore.setHospitalName(value),
                    initialValue: filterEventProcedureStore.hospitalName ?? '',
                  ),
                  const SizedBox(height: 20),
                  MyButtonWidget(
                    text: 'Filtrar',
                    isLoading: false,
                    disabledColor: Colors.grey,
                    onTap: () {
                      filterEventProcedureStore.getAllMedicalShiftByFilters();
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}