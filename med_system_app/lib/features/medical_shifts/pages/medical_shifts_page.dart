import 'package:distrito_medico/core/theme/icons.dart';
import 'package:distrito_medico/core/utils/delete_recurrence_dialog.dart';
import 'package:distrito_medico/core/utils/ui.dart';
import 'package:distrito_medico/core/widgets/bottom_bar_widget.dart';
import 'package:distrito_medico/core/widgets/error.widget.dart';
import 'package:distrito_medico/core/widgets/ext_fab.widget.dart';
import 'package:distrito_medico/core/widgets/fab.widget.dart';
import 'package:distrito_medico/core/widgets/my_app_bar.widget.dart';
import 'package:distrito_medico/core/widgets/my_toast.widget.dart';
import 'package:distrito_medico/features/home/pages/home_page.dart';
import 'package:distrito_medico/features/medical_shifts/model/medical_shift.model.dart';
import 'package:distrito_medico/features/medical_shifts/pages/add_medical_shift_page.dart';
import 'package:distrito_medico/features/medical_shifts/pages/edit_medical_shift_page.dart';
import 'package:distrito_medico/features/medical_shifts/pages/filter_medical_shifts_page.dart';
import 'package:distrito_medico/features/medical_shifts/pages/generate_pdf_medical_shift_screen.page.dart';
import 'package:distrito_medico/features/medical_shifts/pages/widgets/calendar_widget.dart';
import 'package:distrito_medico/features/medical_shifts/store/medical_shift.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers.add(reaction<EditMedicalShiftState>(
        (_) => medicalShiftStore.editState, (validationState) {
      if (validationState == EditMedicalShiftState.success) {
        CustomToast.show(context,
            type: ToastType.success,
            title: "Edição de plantão",
            description: "Plantão editado com sucesso!");
      } else if (validationState == EditMedicalShiftState.error) {
        CustomToast.show(context,
            type: ToastType.error,
            title: "Edição de plantão",
            description: "Ocorreu um erro ao tentar editar plantão.");
      }
    }));
    _disposers.add(reaction<DeleteMedicalShiftState>(
        (_) => medicalShiftStore.deleteState, (validationState) {
      if (validationState == DeleteMedicalShiftState.success) {
        CustomToast.show(context,
            type: ToastType.success,
            title: "Exclusão de plantão",
            description: "Plantão excluído com sucesso!");
      } else if (validationState == DeleteMedicalShiftState.error) {
        CustomToast.show(context,
            type: ToastType.error,
            title: "Exclusão de plantão",
            description: "Ocorreu um erro ao tentar excluir plantão.");
      }
    }));
  }

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

    medicalShiftStore.getAllMedicalShifts(isRefresh: true);
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
        appBar: MyAppBar(
          title: 'Plantões',
          hideLeading: true,
          trailingIcons: const [
            Icon(Icons.description),
            Icon(Icons.filter_list),
          ],
          onTrailingPressed: [
            () {
              push(
                context,
                const MedicalShiftGeneratePdfPage(),
              );
            },
            () {
              push(
                context,
                const FilterMedicalShiftsPage(),
              );
            },
          ],
          image: null,
        ),
        bottomNavigationBar: Observer(builder: (_) {
          return BottomAppBarContent(
            total: medicalShiftStore.medicalShift?.total ?? "",
            totalUnpaid: medicalShiftStore.medicalShift?.totalUnpaid ?? "",
            totalpaid: medicalShiftStore.medicalShift?.totalpaid ?? "",
          );
        }),
        floatingActionButton: isFab
            ? buildFAB(context, () {
                to(
                    context,
                    AddMedicalShiftPage(
                        initialDate: medicalShiftStore.selectedDate));
              })
            : buildExtendedFAB(
                context,
                "Novo plantão",
                () {
                  to(
                      context,
                      AddMedicalShiftPage(
                        initialDate: medicalShiftStore.selectedDate,
                      ));
                },
              ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Observer(
              builder: (_) {
                if (medicalShiftStore.state == MedicalShiftState.success) {
                  return Column(
                    children: [
                      CalendarWidget(
                        events: medicalShiftStore.medicalShiftListCalendar,
                        initialMonth: medicalShiftStore.selectedMonth ??
                            DateTime.now().month,
                        initialYear: medicalShiftStore.selectedYear ??
                            DateTime.now().year,
                        onDaySelected: (selectedDate) {
                          medicalShiftStore
                              .filterMedicalShiftsByDate(selectedDate);
                        },
                        onMonthChanged:
                            medicalShiftStore.setMonthAndYearAndFetchShifts,
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
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
                      return const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 30, right: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Center(
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
                                    startActionPane: !medicalShiftModel.paid!
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
                                                    medicalShiftStore
                                                        .editPaymentMedicalShift(
                                                            medicalShiftModel
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
                                            onPressed: (context) async {
                                              final hasRecurrence =
                                                  medicalShiftModel
                                                          .medicalShiftRecurrenceId !=
                                                      null;

                                              if (hasRecurrence) {
                                                // Show dialog with 3 options for recurrent shifts
                                                final result =
                                                    await showDeleteRecurrenceDialog(
                                                  context: context,
                                                );

                                                if (result == null) {
                                                  // User cancelled
                                                  return;
                                                } else if (result == true) {
                                                  // Delete all recurrences
                                                  medicalShiftStore
                                                      .deleteMedicalShift(
                                                    medicalShiftModel.id ?? 0,
                                                    index,
                                                    medicalShiftRecurrenceId:
                                                        medicalShiftModel
                                                            .medicalShiftRecurrenceId,
                                                  );
                                                } else {
                                                  // Delete only this shift
                                                  medicalShiftStore
                                                      .deleteMedicalShift(
                                                    medicalShiftModel.id ?? 0,
                                                    index,
                                                    medicalShiftRecurrenceId:
                                                        null,
                                                  );
                                                }
                                              } else {
                                                // Show normal confirmation dialog for non-recurrent shifts
                                                showAlert(
                                                  context: context,
                                                  title: 'Excluir Plantão',
                                                  content:
                                                      'Tem certeza que deseja excluir este plantão?',
                                                  textYes: 'Sim',
                                                  textNo: 'Não',
                                                  onPressedConfirm: () {
                                                    medicalShiftStore
                                                        .deleteMedicalShift(
                                                      medicalShiftModel.id ?? 0,
                                                      index,
                                                      medicalShiftRecurrenceId:
                                                          null,
                                                    );
                                                  },
                                                  onPressedCancel: () {},
                                                );
                                              }
                                            })
                                      ],
                                    ),
                                    child: ListTile(
                                      onTap: () {
                                        to(
                                            context,
                                            EditMedicalShiftPage(
                                                medicalShift:
                                                    medicalShiftModel));
                                      },
                                      leading: SvgPicture.asset(
                                        medicalShiftModel.paid!
                                            ? iconCheckCoreAsset
                                            : iconCloseCoreAsset,
                                        width: 32,
                                        height: 32,
                                        colorFilter: ColorFilter.mode(
                                          medicalShiftModel.paid!
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
