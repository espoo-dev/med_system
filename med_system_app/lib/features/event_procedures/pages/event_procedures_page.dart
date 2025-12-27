import 'package:distrito_medico/core/theme/animations.dart';
import 'package:distrito_medico/core/theme/icons.dart';
import 'package:distrito_medico/core/utils/ui.dart';
import 'package:distrito_medico/core/widgets/bottom_bar_widget.dart';
import 'package:distrito_medico/core/widgets/error.widget.dart';
import 'package:distrito_medico/core/widgets/ext_fab.widget.dart';
import 'package:distrito_medico/core/widgets/fab.widget.dart';
import 'package:distrito_medico/core/widgets/my_app_bar.widget.dart';
import 'package:distrito_medico/core/widgets/my_toast.widget.dart';
import 'package:distrito_medico/features/event_procedures/pages/add_event_procedure_page.dart';
import 'package:distrito_medico/features/event_procedures/pages/edit_event_procedure_page.dart';
import 'package:distrito_medico/features/event_procedures/pages/filter_event_procedures_page.dart';
import 'package:distrito_medico/features/event_procedures/pages/generate_pdf_screen.page.dart';
import 'package:distrito_medico/features/event_procedures/presentation/viewmodels/event_procedures_list_viewmodel.dart';
import 'package:distrito_medico/features/home/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:mobx/mobx.dart'; // Mantido para reaction, se necessário, mas pode ser removido se não usar Reactions diretas aqui

import '../../../core/utils/navigation_utils.dart';

enum InitialFilter { paid, unpaid, all }

enum Actions { pay, delete }

class EventProceduresPage extends StatefulWidget {
  final bool backToHome;
  final InitialFilter? initialFilter;

  const EventProceduresPage(
      {super.key, this.backToHome = false, this.initialFilter});

  @override
  State<EventProceduresPage> createState() => _EventProceduresPageState();
}

class _EventProceduresPageState extends State<EventProceduresPage> {
  final _viewModel = GetIt.I.get<EventProceduresListViewModel>();
  final ScrollController _scrollController = ScrollController();
  bool isFab = false;
  final List<ReactionDisposer> _disposers = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Reações podem ser adicionadas aqui se necessário, por exemplo, observando mensagens de erro globais
    _disposers.add(reaction<String?>(
        (_) => _viewModel.errorMessage, (message) {
      if (message != null) {
        CustomToast.show(context,
            type: ToastType.error,
            title: "Erro",
            description: message);
      }
    }));
  }

  @override
  void dispose() {
    for (var disposer in _disposers) {
      disposer();
    }
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    debugPrint('initstate');
    _scrollController.addListener(() {
      infiniteScrolling();
      showFabButton();
    });
    
    // Configura filtros iniciais se houver
    bool? initialPaidFilter;
    if (widget.initialFilter == InitialFilter.paid) {
      initialPaidFilter = true;
    } else if (widget.initialFilter == InitialFilter.unpaid) {
      initialPaidFilter = false;
    }

    _viewModel.loadEventProcedures(
      refresh: true, 
      paid: initialPaidFilter
    );
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

  void infiniteScrolling() {
    if (_scrollController.position.maxScrollExtent ==
            _scrollController.position.pixels &&
        !_viewModel.isLoading) {
      // ViewModel controla a paginação internamente
      // Passamos os mesmos filtros atuais (o ViewModel poderia idealmente guardar o estado dos filtros, 
      // mas aqui vamos apenas chamar load sem refresh para carregar a próxima página)
      _viewModel.loadEventProcedures(refresh: false);
    }
  }

  Future _refreshProcedures() async {
    debugPrint('refreshProcedures');
    await _viewModel.loadEventProcedures(refresh: true);
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
        appBar: MyAppBar(
          title: 'Procedimentos',
          hideLeading: true,
          trailingIcons: const [
            Icon(Icons.description),
            Icon(Icons.filter_list)
          ],
          onTrailingPressed: [
            () => push(
                  context,
                  const EventProcedureGeneratePdfPage(),
                ),
            () async {
              final filters = await push(
                context,
                const FilterEventProceduresPage(),
              );
              if (filters != null && filters is Map<String, dynamic>) {
                 _viewModel.loadEventProcedures(
                   refresh: true,
                   month: filters['month'],
                   year: filters['year'],
                   paid: filters['paid'],
                   healthInsuranceName: filters['healthInsuranceName'],
                   hospitalName: filters['hospitalName']
                 );
              }
            },
          ],
          image: null,
        ),
        bottomNavigationBar: Observer(builder: (_) {
          return BottomAppBarContent(
            total: _viewModel.total ?? "",
            totalUnpaid: _viewModel.totalUnpaid ?? "",
            totalpaid: _viewModel.totalPaid ?? "",
          );
        }),
        floatingActionButton: isFab
            ? buildFAB(context, () {
                to(context, const AddEventProcedurePage());
              })
            : buildExtendedFAB(
                context,
                "Novo procedimento",
                () {
                  to(context, const AddEventProcedurePage());
                },
              ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshProcedures,
                child: Observer(
                  builder: (BuildContext context) {
                    if (_viewModel.isLoading && _viewModel.eventProcedures.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    
                    if (_viewModel.eventProcedures.isEmpty && !_viewModel.isLoading) {
                      if (_viewModel.errorMessage != null) {
                         return Center(
                          child: ErrorRetryWidget(
                              'Algo deu errado', 
                              'Por favor, tente novamente.',
                              () {
                                _viewModel.loadEventProcedures(refresh: true);
                              }
                          )
                        );
                      }

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 30, right: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Center(
                                  child: Lottie.asset(animationEventProcedure,
                                      height: 250, width: 250),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                const Center(
                                  child: Text(
                                    'Procedimento(s) não encontrado(s).',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                    
                    return Stack(
                      children: [
                        SlidableAutoCloseBehavior(
                          closeWhenOpened: true,
                          child: ListView.separated(
                              controller: _scrollController,
                              itemCount: _viewModel.isLoading 
                                  ? _viewModel.eventProcedures.length + 1
                                  : _viewModel.eventProcedures.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (index < _viewModel.eventProcedures.length) {
                                  final eventProcedures = _viewModel.eventProcedures[index];
                                  return Slidable(
                                    key: ValueKey(eventProcedures.id),
                                    startActionPane: !(eventProcedures.paid ?? false)
                                        ? ActionPane(
                                            motion: const StretchMotion(),
                                            children: [
                                              SlidableAction(
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .primary,
                                                  icon: Icons.check,
                                                  label: 'Pagar',
                                                  onPressed: (context) {
                                                    if (eventProcedures.id != null) {
                                                      _viewModel.updatePaymentStatus(
                                                          eventProcedures.id!, true);
                                                    }
                                                  })
                                            ],
                                          )
                                        : null,
                                    endActionPane: ActionPane(
                                      motion: const BehindMotion(),
                                      children: [
                                        SlidableAction(
                                            backgroundColor: Colors.red,
                                            icon: Icons.delete,
                                            label: 'Deletar',
                                            onPressed: (context) {
                                              showAlert(
                                                context: context,
                                                title: 'Excluir Procedimento',
                                                content:
                                                    'Tem certeza que deseja excluir este procedimento?',
                                                textYes: 'Sim',
                                                textNo: 'Não',
                                                onPressedConfirm: () {
                                                  if (eventProcedures.id != null) {
                                                    _viewModel.deleteEventProcedure(
                                                        eventProcedures.id!);
                                                  }
                                                },
                                                onPressedCancel: () {},
                                              );
                                            })
                                      ],
                                    ),
                                    child: ListTile(
                                      onTap: () {
                                        to(
                                            context,
                                            EditEventProcedurePage(
                                                eventProcedure:
                                                    eventProcedures));
                                      },
                                      leading: SvgPicture.asset(
                                        (eventProcedures.paid ?? false)
                                            ? iconCheckCoreAsset
                                            : iconCloseCoreAsset,
                                        width: 32,
                                        height: 32,
                                        colorFilter: ColorFilter.mode(
                                          (eventProcedures.paid ?? false)
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                              : const Color(0xFFEC2A58),
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                      title: Text(
                                        eventProcedures.patient ?? "",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              eventProcedures.procedure ?? ""),
                                          Row(
                                            children: [
                                              Text(
                                                  eventProcedures
                                                          .healthInsurance ??
                                                      "",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                  )),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Text(eventProcedures.date ?? "",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
                                      trailing: Text(
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                          eventProcedures.totalAmountCents ??
                                              ""),
                                    ),
                                  );
                                } else {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                              },
                              separatorBuilder: (_, __) => const Divider()),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
