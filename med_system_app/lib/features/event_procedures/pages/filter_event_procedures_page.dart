import 'package:distrito_medico/core/widgets/my_app_bar.widget.dart';
import 'package:distrito_medico/features/event_procedures/pages/widgets/dropdown_search_health_insurances.widget.dart';
import 'package:distrito_medico/features/event_procedures/pages/widgets/dropdown_search_hospitals.widget.dart';
// Models for compatibility with widgets
import 'package:distrito_medico/features/health_insurances/model/health_insurances.model.dart';
import 'package:distrito_medico/features/hospitals/model/hospital.model.dart';
// ViewModel and Entities
import 'package:distrito_medico/features/event_procedures/presentation/viewmodels/filter_event_procedures_viewmodel.dart';
import 'package:distrito_medico/features/hospitals/domain/entities/hospital_entity.dart';
import 'package:distrito_medico/features/health_insurances/domain/entities/health_insurance_entity.dart';
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
  final _viewModel = GetIt.I.get<FilterEventProceduresViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.loadFiltersData();
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
              _viewModel.clearFilters();
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
              if (_viewModel.isLoading && _viewModel.hospitals.isEmpty) {
                 return const Center(child: CircularProgressIndicator());
              }
              
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ano',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  DropdownButton<int>(
                    value: _viewModel.selectedYear,
                    hint: const Text('Selecione um ano'),
                    onChanged: (int? newValue) {
                      _viewModel.setSelectedYear(newValue);
                    },
                    items: _viewModel.years
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
                      itemCount: _viewModel.months.length,
                      itemBuilder: (context, index) {
                        final month = _viewModel.months[index];
                        return Observer(builder: (_) {
                          return FilterChip(
                            label: Text(
                                _viewModel.getMonthName(month)),
                            selected: _viewModel.selectedMonth ==
                                month,
                            onSelected: (isSelected) {
                              _viewModel
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
                              _viewModel.selectedPaymentStatus,
                          onChanged: (value) {
                            _viewModel
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
                              _viewModel.selectedPaymentStatus,
                          onChanged: (value) {
                            _viewModel
                                .setSelectedPaymentStatus(value);
                          },
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  DropdownSearchHospitals(
                      hospitalList: _viewModel.hospitals,
                      selectedHospital: _viewModel.selectedHospital,
                      onChanged: (HospitalEntity? hospital) {
                        _viewModel.setSelectedHospital(hospital);
                      }),
                  
                  const SizedBox(height: 15),
                  DropdownHealthInsurances(
                    healthInsuranceList: _viewModel.healthInsurances,
                    selectedHealthInsurance: _viewModel.selectedHealthInsurance,
                    onChanged: (HealthInsuranceEntity? healthInsurance) {
                      _viewModel.setSelectedHealthInsurance(healthInsurance);
                    }
                  ),
                 
                  const SizedBox(height: 15),
                  MyButtonWidget(
                    text: 'Filtrar',
                    isLoading: false,
                    disabledColor: Colors.grey,
                    onTap: () {
                      final filters = {
                        'month': _viewModel.selectedMonth,
                        'year': _viewModel.selectedYear,
                        'paid': _viewModel.selectedPaymentStatus,
                        'healthInsuranceName': _viewModel.selectedHealthInsurance?.name,
                        'hospitalName': _viewModel.selectedHospital?.name
                      };
                      Navigator.pop(context, filters);
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
