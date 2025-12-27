import 'package:distrito_medico/core/utils/navigation_utils.dart';
import 'package:distrito_medico/core/widgets/error.widget.dart';
import 'package:distrito_medico/core/widgets/ext_fab.widget.dart';
import 'package:distrito_medico/core/widgets/fab.widget.dart';
import 'package:distrito_medico/core/widgets/my_app_bar.widget.dart';
import 'package:distrito_medico/features/procedures/domain/entities/procedure_entity.dart';
import 'package:distrito_medico/features/procedures/pages/add_procedure_page.dart';
import 'package:distrito_medico/features/procedures/pages/edit_procedure_page.dart';
import 'package:distrito_medico/features/procedures/presentation/viewmodels/procedure_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class ProcedurePage extends StatefulWidget {
  const ProcedurePage({super.key});

  @override
  State<ProcedurePage> createState() => _ProcedurePageState();
}

class _ProcedurePageState extends State<ProcedurePage> {
  final _viewModel = GetIt.I.get<ProcedureListViewModel>();
  final ScrollController _scrollController = ScrollController();
  bool isFab = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      inifiteScrolling();
      showFabButton();
    });
    _viewModel.loadProcedures(refresh: true);
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
      _viewModel.loadProcedures(refresh: false);
    }
  }

  Future _refreshProcedures() async {
    await _viewModel.loadProcedures(refresh: true);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Procedimentos',
        hideLeading: true,
        image: null,
      ),
      floatingActionButton: isFab
          ? buildFAB(context, () {
              to(context, const AddProcedurePage());
            })
          : buildExtendedFAB(
              context,
              "Procedimento",
              () {
                to(context, const AddProcedurePage());
              },
            ),
      body: RefreshIndicator(
        onRefresh: _refreshProcedures,
        child: Observer(
          builder: (BuildContext context) {
            if (_viewModel.state == ProcedureListState.error) {
              return Center(
                  child: ErrorRetryWidget(
                      _viewModel.errorMessage.isNotEmpty
                          ? _viewModel.errorMessage
                          : 'Algo deu errado',
                      'Por favor, tente novamente', () {
                _viewModel.loadProcedures(refresh: true);
              }));
            }
            if (_viewModel.state == ProcedureListState.loading &&
                !_viewModel.hasProcedures) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!_viewModel.hasProcedures) {
              return const Center(
                  child: Text('Você não possui procedimentos cadastrados.'));
            }
            
            return Stack(
              children: [
                ListView.separated(
                    controller: _scrollController,
                    itemCount: _viewModel.isLoading
                        ? _viewModel.proceduresCount + 1
                        : _viewModel.proceduresCount,
                    itemBuilder: (BuildContext context, int index) {
                      if (index < _viewModel.proceduresCount) {
                        ProcedureEntity procedure = _viewModel.procedures[index];
                        return ListTile(
                          onTap: () {
                            to(
                                context,
                                EditProcedurePage(
                                  procedure: procedure,
                                ));
                          },
                          title: Text(
                            procedure.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(procedure.description),
                          trailing: Icon(
                            size: 10.0,
                            Icons.arrow_forward_ios,
                            color: Theme.of(context).colorScheme.primary,
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
