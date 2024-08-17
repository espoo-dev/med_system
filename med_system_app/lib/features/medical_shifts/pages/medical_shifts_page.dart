import 'package:distrito_medico/core/theme/animations.dart';
import 'package:distrito_medico/core/theme/icons.dart';
import 'package:distrito_medico/core/utils/ui.dart';
import 'package:distrito_medico/core/widgets/error.widget.dart';
import 'package:distrito_medico/core/widgets/ext_fab.widget.dart';
import 'package:distrito_medico/core/widgets/fab.widget.dart';
import 'package:distrito_medico/core/widgets/my_app_bar.widget.dart';
import 'package:distrito_medico/features/event_procedures/pages/widgets/bottom_bar_widget.dart';
import 'package:distrito_medico/features/event_procedures/pages/widgets/dialog_filter_months.wdiget.dart';
import 'package:distrito_medico/features/home/pages/home_page.dart';
import 'package:distrito_medico/features/medical_shifts/model/medical_shift.model.dart';
import 'package:distrito_medico/features/medical_shifts/pages/add_medical_shift_page.dart';
import 'package:distrito_medico/features/medical_shifts/store/medical_shift.store.dart';
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

class MedicalShiftsPage extends StatefulWidget {
  final bool backToHome;
  final InitialFilter? initialFilter;

  const MedicalShiftsPage(
      {super.key, this.backToHome = false, this.initialFilter});

  @override
  State<MedicalShiftsPage> createState() => _MedicalShiftsPageState();
}

class _MedicalShiftsPageState extends State<MedicalShiftsPage> {
  final medicalShiftStore = GetIt.I.get<MedicalShiftStore>();
  List<MedicalShiftModel>? _listMedicalShift = [];
  final ScrollController _scrollController = ScrollController();
  bool isFab = false;
  final List<ReactionDisposer> _disposers = [];

  @override
  void dispose() {
    for (var disposer in _disposers) {
      disposer();
    }
    medicalShiftStore.dispose();
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
    setInitialFilter();
    medicalShiftStore.getAllMedicalShifts(isRefresh: true);
  }

  void setInitialFilter() {
    if (widget.initialFilter != null) {
      if (widget.initialFilter == InitialFilter.paid) {
        medicalShiftStore.updateFilter(false, true, false, false);
      } else if (widget.initialFilter == InitialFilter.unpaid) {
        medicalShiftStore.updateFilter(false, false, true, false);
      } else {
        medicalShiftStore.updateFilter(true, false, false, false);
      }
    }
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
        !(medicalShiftStore.state == MedicalShiftState.loading)) {
      medicalShiftStore.getAllMedicalShifts(isRefresh: false);
    }
  }

  Future _refreshMedicalShifts() async {
    debugPrint('_refreshMedicalShifts');
    await medicalShiftStore.getAllMedicalShifts(isRefresh: true);
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
        appBar: const MyAppBar(
          title: 'Plantões',
          hideLeading: true,
          image: null,
        ),
        bottomNavigationBar: Observer(builder: (_) {
          return BottomAppBarContent(
            total: medicalShiftStore.medicalShift?.total ?? "",
            totalUnpayd: medicalShiftStore.medicalShift?.totalUnpayd ?? "",
            totalPayd: medicalShiftStore.medicalShift?.totalPayd ?? "",
          );
        }),
        floatingActionButton: isFab
            ? buildFAB(context, () {
                to(context, const AddMedicalShiftPage());
              })
            : buildExtendedFAB(
                context,
                "Novo plantão",
                () {
                  to(context, const AddMedicalShiftPage());
                },
              ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Observer(builder: (_) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FilterChip(
                          label: const Text('Mês'),
                          selected: medicalShiftStore.showMonth!,
                          onSelected: (selected) async {
                            medicalShiftStore.updateFilter(
                                false, false, false, true);
                            int? selectedMonth = await showDialogMonths(context,
                                initialMonth: medicalShiftStore.month);
                            if (selectedMonth != null) {
                              medicalShiftStore.updateMonth(selectedMonth);
                              _refreshMedicalShifts();
                            }
                          },
                          showCheckmark: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FilterChip(
                          label: const Text('Todos'),
                          selected: medicalShiftStore.showAll!,
                          onSelected: (selected) {
                            medicalShiftStore.updateFilter(
                                selected, false, false, false);
                            _refreshMedicalShifts();
                          },
                          showCheckmark: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FilterChip(
                          label: const Text('Recebidos'),
                          selected: medicalShiftStore.showPaid!,
                          onSelected: (selected) {
                            medicalShiftStore.updateFilter(
                                false, selected, false, false);
                            _refreshMedicalShifts();
                          },
                          showCheckmark: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FilterChip(
                          label: const Text('A Receber'),
                          selected: medicalShiftStore.showUnpaid!,
                          onSelected: (selected) {
                            medicalShiftStore.updateFilter(
                                false, false, selected, false);
                            _refreshMedicalShifts();
                          },
                          showCheckmark: false,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshMedicalShifts,
                child: Observer(
                  builder: (BuildContext context) {
                    if (medicalShiftStore.state == MedicalShiftState.error) {
                      return Center(
                          child: ErrorRetryWidget(
                              'Algo deu errado', 'Por favor, tente novamente',
                              () {
                        medicalShiftStore.getAllMedicalShifts(isRefresh: true);
                      }));
                    }
                    if (medicalShiftStore.state == MedicalShiftState.loading &&
                        _listMedicalShift!.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (medicalShiftStore.medicalShiftList.isEmpty) {
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
                                    'Plantão não encontrado.',
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
                    _listMedicalShift = medicalShiftStore.medicalShiftList;
                    return Stack(
                      children: [
                        SlidableAutoCloseBehavior(
                          closeWhenOpened: true,
                          child: ListView.separated(
                              controller: _scrollController,
                              itemCount: medicalShiftStore.state ==
                                      MedicalShiftState.loading
                                  ? _listMedicalShift!.length + 1
                                  : _listMedicalShift!.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (index < _listMedicalShift!.length) {
                                  MedicalShiftModel medicalShiftModel =
                                      _listMedicalShift![index];
                                  return Slidable(
                                    key: ValueKey(_listMedicalShift?.length),
                                    startActionPane: !medicalShiftModel.payd!
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
                                                    // pagar plantão
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
                                                title: 'Excluir Plantão',
                                                content:
                                                    'Tem certeza que deseja excluir este plantão?',
                                                textYes: 'Sim',
                                                textNo: 'Não',
                                                onPressedConfirm: () {},
                                                onPressedCancel: () {},
                                              );
                                            })
                                      ],
                                    ),
                                    child: ListTile(
                                      onTap: () {
                                        //Editar plantao
                                      },
                                      leading: SvgPicture.asset(
                                        medicalShiftModel.payd!
                                            ? iconCheckCoreAsset
                                            : iconCloseCoreAsset,
                                        width: 32,
                                        height: 32,
                                        colorFilter: ColorFilter.mode(
                                          medicalShiftModel.payd!
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                              : const Color(0xFFEC2A58),
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                      title: Text(
                                        medicalShiftModel.title ?? "",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Horário: ${medicalShiftModel.hour ?? ""}",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                  medicalShiftModel
                                                      .shiftDescription,
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                  )),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Text(medicalShiftModel.date ?? "",
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
                                          medicalShiftModel.amountCents ?? ""),
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
