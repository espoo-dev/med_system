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
  final filterMedicalShiftStore = GetIt.I.get<MedicalShiftStore>();
  @override
  void initState() {
    super.initState();
    filterMedicalShiftStore.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Filtros',
        hideLeading: true,
        trailingIcons: const [
          Text('Limpar'),
        ],
        onTrailingPressed: [
          () {
            filterMedicalShiftStore.clearFilters();
          },
        ],
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
                    'Ano',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  DropdownButton<int>(
                    value: filterMedicalShiftStore.selectedYear,
                    hint: const Text('Selecione um ano'),
                    onChanged: (int? newValue) {
                      filterMedicalShiftStore.setSelectedYear(newValue);
                    },
                    items: filterMedicalShiftStore.years
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
                    'Mês',
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
                      itemCount: filterMedicalShiftStore.months.length,
                      itemBuilder: (context, index) {
                        final month = filterMedicalShiftStore.months[index];
                        return Observer(builder: (_) {
                          return FilterChip(
                            label: Text(
                                filterMedicalShiftStore.getMonthName(month)),
                            selected:
                                filterMedicalShiftStore.selectedMonth == month,
                            onSelected: (isSelected) {
                              filterMedicalShiftStore
                                  .setSelectedMonth(isSelected ? month : null);
                            },
                          );
                        });
                      },
                    ),
                  ),
                  const Text(
                    'Status de pagamento',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<bool>(
                            title: const Text('Recebidos',
                                style: TextStyle(fontSize: 12)),
                            value: true,
                            groupValue:
                                filterMedicalShiftStore.selectedPaymentStatus,
                            onChanged: (value) {
                              filterMedicalShiftStore
                                  .setSelectedPaymentStatus(value);
                            },
                            contentPadding: EdgeInsets.zero),
                      ),
                      Expanded(
                        child: RadioListTile<bool>(
                          title: const Text('A Receber',
                              style: TextStyle(fontSize: 12)),
                          value: false,
                          groupValue:
                              filterMedicalShiftStore.selectedPaymentStatus,
                          onChanged: (value) {
                            filterMedicalShiftStore
                                .setSelectedPaymentStatus(value);
                          },
                          contentPadding: EdgeInsets.zero,
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
                        filterMedicalShiftStore.setHospitalName(value),
                    initialValue: filterMedicalShiftStore.hospitalName ?? '',
                  ),
                  const SizedBox(height: 20),
                  MyButtonWidget(
                    text: 'Filtrar',
                    isLoading: false,
                    disabledColor: Colors.grey,
                    onTap: () {
                      filterMedicalShiftStore.getAllMedicalShiftByFilters();
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
