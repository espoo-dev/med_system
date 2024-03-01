import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:med_system_app/core/utils/navigation_utils.dart';
import 'package:med_system_app/core/widgets/error.widget.dart';
import 'package:med_system_app/core/widgets/ext_fab.widget.dart';
import 'package:med_system_app/core/widgets/fab.widget.dart';
import 'package:med_system_app/core/widgets/my_app_bar.widget.dart';
import 'package:med_system_app/features/procedures/model/procedure.model.dart';
import 'package:med_system_app/features/procedures/pages/add_procedure_page.dart';
import 'package:med_system_app/features/procedures/pages/edit_procedure_page.dart';
import 'package:med_system_app/features/procedures/store/procedure.store.dart';

class ProcedurePage extends StatefulWidget {
  const ProcedurePage({super.key});

  @override
  State<ProcedurePage> createState() => _ProcedurePageState();
}

class _ProcedurePageState extends State<ProcedurePage> {
  final _procedureStore = GetIt.I.get<ProcedureStore>();
  List<Procedure>? _listProcedure = [];
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
    _procedureStore.getAllProcedures(isRefresh: true);
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
      _procedureStore.getAllProcedures(isRefresh: false);
    }
  }

  Future _refreshProcedures() async {
    await _procedureStore.getAllProcedures(isRefresh: true);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _procedureStore.dispose();
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
            if (_procedureStore.state == ProcedureState.error) {
              return Center(
                  child: ErrorRetryWidget(
                      'Algo deu errado', 'Por favor, tente novamente', () {
                _procedureStore.getAllProcedures(isRefresh: true);
              }));
            }
            if (_procedureStore.state == ProcedureState.loading &&
                _listProcedure!.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            if (_procedureStore.procedureList.isEmpty) {
              return const Center(
                  child: Text('Você não possui hospitais cadastrados.'));
            }
            _listProcedure = _procedureStore.procedureList;
            return Stack(
              children: [
                ListView.separated(
                    controller: _scrollController,
                    itemCount: _procedureStore.state == ProcedureState.loading
                        ? _listProcedure!.length + 1
                        : _listProcedure!.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index < _listProcedure!.length) {
                        Procedure procedure = _listProcedure![index];
                        return ListTile(
                          onTap: () {
                            to(
                                context,
                                EditProcedurePage(
                                  procedure: procedure,
                                ));
                          },
                          title: Text(
                            procedure.name ?? "",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(procedure.description ?? ""),
                          trailing: Icon(
                            size: 10.0,
                            Icons.arrow_forward_ios,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          // trailing: IconButton(
                          //   onPressed: () {
                          //     showAlert(
                          //       title: 'Excluir Procedimento',
                          //       content:
                          //           'Tem certeza que deseja excluir este procedimento?',
                          //       textYes: 'Sim',
                          //       textNo: 'Não',
                          //       onPressedConfirm: () {},
                          //       onPressedCancel: () {
                          //         Navigator.pop(context);
                          //       },
                          //       context: context,
                          //     );
                          //   },
                          //   icon: Icon(
                          //     Icons.delete,
                          //     color: Theme.of(context).colorScheme.primary,
                          //   ),
                          // ),
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
