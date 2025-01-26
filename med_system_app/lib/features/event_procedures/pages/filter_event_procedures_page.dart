import 'package:distrito_medico/core/widgets/my_app_bar.widget.dart';
import 'package:distrito_medico/features/event_procedures/pages/widgets/dropdown_search_health_insurances.widget.dart';
import 'package:distrito_medico/features/event_procedures/pages/widgets/dropdown_search_hospitals.widget.dart';
import 'package:distrito_medico/features/event_procedures/store/event_procedure.store.dart';
import 'package:distrito_medico/features/health_insurances/model/health_insurances.model.dart';
import 'package:distrito_medico/features/hospitals/model/hospital.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../../core/widgets/my_button_widget.dart';

class FilterEventProceduresPage extends StatefulWidget {
  const FilterEventProceduresPage({super.key});

  @override
  State<FilterEventProceduresPage> createState() =>
      _FilterEventProceduresPageState();
}

class _FilterEventProceduresPageState extends State<FilterEventProceduresPage> {
  final filterEventProcedureStore = GetIt.I.get<EventProcedureStore>();

  @override
  void initState() {
    super.initState();
    filterEventProcedureStore.fetchAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Filtros',
        hideLeading: true,
        trailingIcons: [
          TextButton(
            onPressed: () {
              filterEventProcedureStore.clearFilters();
            },
            child: const Text('Limpar'),
          ),
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
                              filterEventProcedureStore.selectedPaymentStatus,
                          onChanged: (value) {
                            filterEventProcedureStore
                                .setSelectedPaymentStatus(value);
                          },
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<bool>(
                          title: const Text('A Receber',
                              style: TextStyle(fontSize: 12)),
                          value: false,
                          groupValue:
                              filterEventProcedureStore.selectedPaymentStatus,
                          onChanged: (value) {
                            filterEventProcedureStore
                                .setSelectedPaymentStatus(value);
                          },
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  DropdownSearchHospitals(
                      hospitalList: filterEventProcedureStore.hospitalList,
                      selectedHospital:
                          filterEventProcedureStore.hospital ?? Hospital(),
                      onChanged: (Hospital? hospital) {
                        filterEventProcedureStore.setHospitalName(hospital!);
                      }),
                  // MyTextFormField(
                  //   label: 'Nome hospital',
                  //   placeholder: 'Digite nome do hospital',
                  //   inputType: TextInputType.text,
                  //   validators: const {
                  //     'required': true,
                  //     'minLength': 4,
                  //   },
                  //   onChanged: (value) =>
                  //       filterEventProcedureStore.setHospitalName(value),
                  //   initialValue: filterEventProcedureStore.hospitalName ?? '',
                  // ),
                  const SizedBox(height: 15),
                  DropdownHealthInsurances(
                    healthInsuranceList:
                        filterEventProcedureStore.healthInsuranceList,
                    selectedHealthInsurance:
                        filterEventProcedureStore.healthInsurance ??
                            HealthInsurance(),
                    onChanged: (HealthInsurance? healthInsurance) =>
                        filterEventProcedureStore
                            .setHealthInsuranceName(healthInsurance!),
                  ),
                  // const Text(
                  //   'Nome do plano de saúde',
                  //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  // ),
                  // const SizedBox(height: 10),
                  // MyTextFormField(
                  //   label: 'Nome plano de saúde',
                  //   placeholder: 'Digite nome do plano de saúde',
                  //   inputType: TextInputType.text,
                  //   validators: const {
                  //     'required': true,
                  //     'minLength': 4,
                  //   },
                  //   onChanged: (value) =>
                  //       filterEventProcedureStore.setHealthInsuranceName(value),
                  //   initialValue:
                  //       filterEventProcedureStore.healthInsuranceName ?? '',
                  // ),
                  const SizedBox(height: 15),
                  MyButtonWidget(
                    text: 'Filtrar',
                    isLoading: false,
                    disabledColor: Colors.grey,
                    onTap: () {
                      filterEventProcedureStore
                          .getAllEventProceduresByFilters();
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
