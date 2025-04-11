import 'package:distrito_medico/core/theme/animations.dart';
import 'package:distrito_medico/core/theme/icons.dart';
import 'package:distrito_medico/core/utils/ui.dart';
import 'package:distrito_medico/core/widgets/bottom_bar_widget.dart';
import 'package:distrito_medico/core/widgets/error.widget.dart';
import 'package:distrito_medico/core/widgets/ext_fab.widget.dart';
import 'package:distrito_medico/core/widgets/fab.widget.dart';
import 'package:distrito_medico/core/widgets/my_app_bar.widget.dart';
import 'package:distrito_medico/core/widgets/my_toast.widget.dart';
import 'package:distrito_medico/features/event_procedures/model/event_procedure.model.dart';
import 'package:distrito_medico/features/event_procedures/pages/add_event_procedure_page.dart';
import 'package:distrito_medico/features/event_procedures/pages/edit_event_procedure_page.dart';
import 'package:distrito_medico/features/event_procedures/pages/filter_event_procedures_page.dart';
import 'package:distrito_medico/features/event_procedures/pages/generate_pdf_screen.page.dart';
import 'package:distrito_medico/features/event_procedures/store/event_procedure.store.dart';
import 'package:distrito_medico/features/home/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:mobx/mobx.dart';

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
  final eventProcedureStore = GetIt.I.get<EventProcedureStore>();
  List<EventProcedures>? _listEventProcedures = [];
  final ScrollController _scrollController = ScrollController();
  bool isFab = false;
  final List<ReactionDisposer> _disposers = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers.add(reaction<EditEventProcedureState>(
        (_) => eventProcedureStore.editState, (validationState) {
      if (validationState == EditEventProcedureState.success) {
        CustomToast.show(context,
            type: ToastType.success,
            title: "Edição de procedimento",
            description: "Procedimento editado com sucesso!");
      } else if (validationState == EditEventProcedureState.error) {
        CustomToast.show(context,
            type: ToastType.error,
            title: "Edição de procedimeto",
            description: "Ocorreu um erro ao tentar editar procedimento.");
      }
    }));
    _disposers.add(reaction<DeleteEventProcedureState>(
        (_) => eventProcedureStore.deleteSate, (validationState) {
      if (validationState == DeleteEventProcedureState.success) {
        CustomToast.show(context,
            type: ToastType.success,
            title: "Exclusão de procedimento",
            description: "Procedimento excluído com sucesso!");
      } else if (validationState == DeleteEventProcedureState.error) {
        CustomToast.show(context,
            type: ToastType.error,
            title: "Exclusão de procedimeto",
            description: "Ocorreu um erro ao tentar excluir procedimento.");
      }
    }));
  }

  @override
  void dispose() {
    for (var disposer in _disposers) {
      disposer();
    }
    eventProcedureStore.dispose();
    _scrollController.dispose();
    eventProcedureStore.dispose();
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
    // setInitialFilter();
    eventProcedureStore.getAllEventProcedures(isRefresh: true, perPage: 10);
  }

  // void setInitialFilter() {
  //   if (widget.initialFilter != null) {
  //     if (widget.initialFilter == InitialFilter.paid) {
  //       eventProcedureStore.updateFilter(false, true, false, false);
  //     } else if (widget.initialFilter == InitialFilter.unpaid) {
  //       eventProcedureStore.updateFilter(false, false, true, false);
  //     } else {
  //       eventProcedureStore.updateFilter(true, false, false, false);
  //     }
  //   }
  // }

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
        !(eventProcedureStore.state == EventProcedureState.loading)) {
      eventProcedureStore.getAllEventProcedures(isRefresh: false, perPage: 10);
    }
  }
  // void infiniteScrolling() {
  //   if (_scrollController.position.atEdge) {
  //     bool isBottom = _scrollController.position.pixels == _scrollController.position.maxScrollExtent;
  //     if (isBottom) {
  //       eventProcedureStore.getAllEventProcedures(isRefresh: false);
  //     }
  //   }
  // }

  // inifiteScrolling() {
  //   var maxScroll = _scrollController.position.maxScrollExtent;
  //   if (maxScroll == _scrollController.offset) {
  //     eventProcedureStore.getAllEventProcedures(isRefresh: false);
  //   }
  // }

  Future _refreshProcedures() async {
    debugPrint('refreshProcedures');
    await eventProcedureStore.getAllEventProcedures(
        isRefresh: true, perPage: 10);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) {}
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
            () => push(
                  context,
                  const FilterEventProceduresPage(),
                ),
          ],
          image: null,
        ),
        bottomNavigationBar: Observer(builder: (_) {
          return BottomAppBarContent(
            total: eventProcedureStore.eventProcedureModel?.total ?? "",
            totalUnpaid:
                eventProcedureStore.eventProcedureModel?.totalUnpaid ?? "",
            totalpaid: eventProcedureStore.eventProcedureModel?.totalpaid ?? "",
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
            // Observer(builder: (_) {
            //   return BottomAppBarContent(
            //     total: eventProcedureStore.eventProcedureModel?.total ?? "",
            //     totalUnpaid:
            //         eventProcedureStore.eventProcedureModel?.totalUnpaid ?? "",
            //     totalpaid:
            //         eventProcedureStore.eventProcedureModel?.totalpaid ?? "",
            //   );
            // }),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshProcedures,
                child: Observer(
                  builder: (BuildContext context) {
                    if (eventProcedureStore.state ==
                        EventProcedureState.error) {
                      return Center(
                          child: ErrorRetryWidget(
                              'Algo deu errado', 'Por favor, tente novamente',
                              () {
                        eventProcedureStore.getAllEventProcedures(
                            isRefresh: true, perPage: 10);
                      }));
                    }
                    if (eventProcedureStore.state ==
                            EventProcedureState.loading &&
                        _listEventProcedures!.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (eventProcedureStore.eventProcedureList.isEmpty) {
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
                    _listEventProcedures =
                        eventProcedureStore.eventProcedureList;
                    return Stack(
                      children: [
                        SlidableAutoCloseBehavior(
                          closeWhenOpened: true,
                          child: ListView.separated(
                              controller: _scrollController,
                              itemCount: eventProcedureStore.state ==
                                      EventProcedureState.loading
                                  ? _listEventProcedures!.length + 1
                                  : _listEventProcedures!.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (index < _listEventProcedures!.length) {
                                  EventProcedures eventProcedures =
                                      _listEventProcedures![index];
                                  return Slidable(
                                    key: ValueKey(_listEventProcedures?.length),
                                    startActionPane: !eventProcedures.paid!
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
                                                    eventProcedureStore
                                                        .editPaymentEventProcedure(
                                                            eventProcedures
                                                                    .id ??
                                                                0,
                                                            index);
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
                                                  eventProcedureStore
                                                      .deleteEventProcedure(
                                                          eventProcedures.id ??
                                                              0,
                                                          index);
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
                                                eventProcedures:
                                                    eventProcedures));
                                      },
                                      leading: SvgPicture.asset(
                                        eventProcedures.paid!
                                            ? iconCheckCoreAsset
                                            : iconCloseCoreAsset,
                                        width: 32,
                                        height: 32,
                                        colorFilter: ColorFilter.mode(
                                          eventProcedures.paid!
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
