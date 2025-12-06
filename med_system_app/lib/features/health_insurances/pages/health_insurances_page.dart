import 'package:distrito_medico/core/pages/error/error_retry_page.dart';
import 'package:distrito_medico/core/utils/navigation_utils.dart';
import 'package:distrito_medico/core/widgets/ext_fab.widget.dart';
import 'package:distrito_medico/core/widgets/fab.widget.dart';
import 'package:distrito_medico/core/widgets/my_app_bar.widget.dart';
import 'package:distrito_medico/features/health_insurances/pages/add_health_insurances_page.dart';
import 'package:distrito_medico/features/health_insurances/pages/edit_health_insurance_page.dart';
import 'package:distrito_medico/features/health_insurances/presentation/viewmodels/health_insurance_list_viewmodel.dart';
import 'package:distrito_medico/features/home/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_it/get_it.dart';

class HealthInsurancesPage extends StatefulWidget {
  const HealthInsurancesPage({super.key});

  @override
  State<HealthInsurancesPage> createState() => _HealthInsurancesPageState();
}

class _HealthInsurancesPageState extends State<HealthInsurancesPage> {
  final _viewModel = GetIt.I.get<HealthInsuranceListViewModel>();
  final ScrollController _scrollController = ScrollController();
  bool isFab = false;

  @override
  void initState() {
    super.initState();
    _viewModel.loadHealthInsurances(refresh: true);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // Infinite scrolling logic
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (!_viewModel.isLoading && _viewModel.hasMore) {
        _viewModel.loadHealthInsurances();
      }
    }

    // FAB animation logic
    if (_scrollController.offset > 50) {
      if (!isFab) {
        setState(() {
          isFab = true;
        });
      }
    } else {
      if (isFab) {
        setState(() {
          isFab = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) return;
        to(context, const HomePage());
      },
      child: Scaffold(
        appBar: const MyAppBar(
          title: 'Convênios',
          image: null,
          hideLeading: true,
        ),
        floatingActionButton: isFab
            ? buildFAB(context, () {
                to(context, const AddHealthInsurancesPage());
              })
            : buildExtendedFAB(
                context,
                "Novo convênio",
                () {
                  to(context, const AddHealthInsurancesPage());
                },
              ),
        body: Observer(builder: (_) {
          if (_viewModel.state == HealthInsuranceListState.loading &&
              _viewModel.healthInsurances.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_viewModel.state == HealthInsuranceListState.error &&
              _viewModel.healthInsurances.isEmpty) {
            return Center(
              child: ErrorRetryPage(
                onRetry: () => _viewModel.loadHealthInsurances(refresh: true),
              ),
            );
          }

          if (_viewModel.healthInsurances.isEmpty) {
            return const Center(child: Text('Nenhum convênio encontrado.'));
          }

          return RefreshIndicator(
            onRefresh: () async {
              await _viewModel.loadHealthInsurances(refresh: true);
            },
            child: SlidableAutoCloseBehavior(
              closeWhenOpened: true,
              child: ListView.separated(
                controller: _scrollController,
                itemCount: _viewModel.healthInsurances.length + 1,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  if (index == _viewModel.healthInsurances.length) {
                    return _viewModel.hasMore
                        ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(child: CircularProgressIndicator()),
                          )
                        : const SizedBox.shrink();
                  }

                  final healthInsurance = _viewModel.healthInsurances[index];
                  return Slidable(
                    key: ValueKey(healthInsurance.id),
                    endActionPane: ActionPane(
                      motion: const BehindMotion(),
                      children: [
                        SlidableAction(
                          backgroundColor: Theme.of(context).primaryColor,
                          icon: Icons.edit,
                          label: 'Editar',
                          onPressed: (context) {
                            to(
                                context,
                                EditHealthInsurancePage(
                                  healthInsuranceEntity: healthInsurance,
                                ));
                          },
                        ),
                        // Adicionar botão de deletar futuramente se implementado
                      ],
                    ),
                    child: ListTile(
                      onTap: () {
                        to(
                            context,
                            EditHealthInsurancePage(
                              healthInsuranceEntity: healthInsurance,
                            ));
                      },
                      title: Text(
                        healthInsurance.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 10.0,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}
