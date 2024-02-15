import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:med_system_app/core/utils/navigation_utils.dart';
import 'package:med_system_app/core/utils/ui.dart';
import 'package:med_system_app/core/widgets/error.widget.dart';
import 'package:med_system_app/core/widgets/ext_fab.widget.dart';
import 'package:med_system_app/core/widgets/fab.widget.dart';
import 'package:med_system_app/core/widgets/my_app_bar.widget.dart';
import 'package:med_system_app/features/health_insurances/model/health_insurances.model.dart';
import 'package:med_system_app/features/health_insurances/pages/add_health_insurances_page.dart';
import 'package:med_system_app/features/health_insurances/store/health_insurances.store.dart';

class HealthInsurancePage extends StatefulWidget {
  const HealthInsurancePage({super.key});

  @override
  State<HealthInsurancePage> createState() => _HealthInsurancePageState();
}

class _HealthInsurancePageState extends State<HealthInsurancePage> {
  final _healthInsuranceStore = GetIt.I.get<HealthInsurancesStore>();
  List<HealthInsurance>? _listHealthInsurance = [];
  final ScrollController _scrollController = ScrollController();
  bool isFab = false;
  @override
  void initState() {
    super.initState();
    debugPrint('initstate');
    _scrollController.addListener(() {
      inifiteScrolling();
      showFabButton();
    });
    _healthInsuranceStore.getAllHealthInsurances(isRefresh: true);
  }

  showFabButton() {
    if (_scrollController.offset > 50) {
      setState(() {
        isFab = true;
      });
    } else {
      setState(() {
        isFab = false;
      });
    }
  }

  inifiteScrolling() {
    var maxScroll = _scrollController.position.maxScrollExtent;
    if (maxScroll == _scrollController.offset) {
      _healthInsuranceStore.getAllHealthInsurances(isRefresh: false);
    }
  }

  Future _refreshProcedures() async {
    await _healthInsuranceStore.getAllHealthInsurances(isRefresh: true);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _healthInsuranceStore.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Convênios',
        hideLeading: true,
        image: null,
      ),
      floatingActionButton: isFab
          ? buildFAB(context, () {
              to(context, const AddHealthInsurances());
            })
          : buildExtendedFAB(
              context,
              "Novo convênio",
              () {
                to(context, const AddHealthInsurances());
              },
            ),
      body: RefreshIndicator(
        onRefresh: _refreshProcedures,
        child: Observer(
          builder: (BuildContext context) {
            if (_healthInsuranceStore.state == HealthInsuranceState.error) {
              return Center(
                  child: ErrorRetryWidget(
                      'Algo deu errado', 'Por favor, tente novamente', () {
                _healthInsuranceStore.getAllHealthInsurances(isRefresh: true);
              }));
            }
            if (_healthInsuranceStore.state == HealthInsuranceState.loading &&
                _listHealthInsurance!.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            if (_healthInsuranceStore.healthInsuranceList.isEmpty) {
              return const Center(
                  child: Text('Você não possui convênios cadastrados.'));
            }
            _listHealthInsurance = _healthInsuranceStore.healthInsuranceList;
            return Stack(
              children: [
                ListView.separated(
                    controller: _scrollController,
                    itemCount: _healthInsuranceStore.state ==
                            HealthInsuranceState.loading
                        ? _listHealthInsurance!.length + 1
                        : _listHealthInsurance!.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index < _listHealthInsurance!.length) {
                        HealthInsurance healthInsurance =
                            _listHealthInsurance![index];
                        return ListTile(
                          onTap: () {},
                          title: Text(
                            healthInsurance.name ?? "",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              showAlert(
                                title: 'Excluir convênio',
                                content:
                                    'Tem certeza que deseja excluir este convênio?',
                                textYes: 'Sim',
                                textNo: 'Não',
                                onPressedConfirm: () {},
                                onPressedCancel: () {
                                  Navigator.pop(context);
                                },
                                context: context,
                              );
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                    separatorBuilder: (_, __) => const Divider()),
              ],
            );
          },
        ),
      ),
    );
  }
}
