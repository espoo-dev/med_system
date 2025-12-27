import 'package:distrito_medico/core/theme/icons.dart';
import 'package:distrito_medico/core/utils/delete_recurrence_dialog.dart';
import 'package:distrito_medico/core/utils/ui.dart';
import 'package:distrito_medico/core/utils/navigation_utils.dart';
import 'package:distrito_medico/core/widgets/bottom_bar_widget.dart';
import 'package:distrito_medico/core/widgets/error.widget.dart';
import 'package:distrito_medico/core/widgets/ext_fab.widget.dart';
import 'package:distrito_medico/core/widgets/fab.widget.dart';
import 'package:distrito_medico/core/widgets/my_app_bar.widget.dart';
import 'package:distrito_medico/core/widgets/my_toast.widget.dart';
import 'package:distrito_medico/features/home/pages/home_page.dart';
import 'package:distrito_medico/features/medical_shifts/domain/entities/medical_shift_entity.dart';
import 'package:distrito_medico/features/medical_shifts/pages/add_medical_shift_page.dart';
import 'package:distrito_medico/features/medical_shifts/pages/edit_medical_shift_page.dart';
import 'package:distrito_medico/features/medical_shifts/pages/filter_medical_shifts_page.dart';
import 'package:distrito_medico/features/medical_shifts/pages/generate_pdf_medical_shift_screen.page.dart';
import 'package:distrito_medico/features/medical_shifts/pages/widgets/calendar_widget.dart';
import 'package:distrito_medico/features/medical_shifts/presentation/extensions/medical_shift_entity_extensions.dart';
import 'package:distrito_medico/features/medical_shifts/presentation/viewmodels/medical_shifts_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

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
  final _viewModel = GetIt.I.get<MedicalShiftsListViewModel>();
  List<MedicalShiftEntity>? _listMedicalShift = [];
  final ScrollController _scrollController = ScrollController();
  bool isFab = false;
  final List<ReactionDisposer> _disposers = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Reacoes de sucesso/erro podem ser globais ou especificas
    // O ViewModel atual tem um state geral. Se for pra toast de sucesso de delete,
    // ideal seria ter notification ou stream.
    // Mas vamos observar o state.
    // O ViewModel reseta state para success apos operações.

    // Como o ViewModel unico controla listagem e delete/edit, se 'state' for success, foi um loadSuccess. :(
    // Se o delete for feito, ele atualiza a lista e pronto.

    _disposers.add(reaction<MedicalShiftDeleteState>(
        (_) => _viewModel.deleteState, (state) {
      if (state == MedicalShiftDeleteState.success) {
        CustomToast.show(context,
            type: ToastType.success,
            title: "Sucesso",
            description: "Plantão deletado com sucesso!");
      } else if (state == MedicalShiftDeleteState.error) {
        CustomToast.show(context,
            type: ToastType.error,
            title: "Erro",
            description: _viewModel.errorMessage);
      }
    }));
    // Eu não criei states separados no ViewModel para simplificar (state unico).
    // Mas para Toast preciso saber QUAL operação.
    // Vou remover os Toasts por enquanto ou observar errorMessage para erro.
    // Se quiser toast de sucesso, deveria ter um 'notification' stream no VM.

    _disposers
        .add(reaction<MedicalShiftListState>((_) => _viewModel.state, (state) {
      if (state == MedicalShiftListState.error) {
        CustomToast.show(context,
            type: ToastType.error,
            title: "Erro",
            description: _viewModel.errorMessage);
      }
    }));
  }

  @override
  void dispose() {
    for (var disposer in _disposers) {
      disposer();
    }
    _scrollController.dispose();
    // Não devemos dar dispose no ViewModel se for Singleton Lazy, mas se quisermos resetar ao sair...
    // Ele é LazySingleton, então persiste.
    // Se quisermos limpar filtros, chamamos init no initState.
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _viewModel.init();
    _scrollController.addListener(() {
      infiniteScrolling();
      showFabButton();
    });

    _viewModel.loadMedicalShifts(isRefresh: true);
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
        _viewModel.state != MedicalShiftListState.loading) {
      _viewModel.loadMedicalShifts(isRefresh: false);
    }
  }

  Future _refreshMedicalShifts() async {
    await _viewModel.loadMedicalShifts(isRefresh: true);
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
            total: _viewModel.totalAmount ?? "",
            totalUnpaid: _viewModel.totalUnpaid ?? "",
            totalpaid: _viewModel.totalPaid ?? "",
          );
        }),
        floatingActionButton: isFab
            ? buildFAB(context, () {
                to(
                    context,
                    AddMedicalShiftPage(
                        initialDate: _viewModel.selectedDateDisplay));
              })
            : buildExtendedFAB(
                context,
                "Novo plantão",
                () {
                  to(
                      context,
                      AddMedicalShiftPage(
                        initialDate: _viewModel.selectedDateDisplay,
                      ));
                },
              ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Observer(
              builder: (_) {
                // Calendar should show regardless of success state if we want persistence,
                // but usually data is needed.
                if (_viewModel.allShiftsForCalendar.isNotEmpty ||
                    _viewModel.state == MedicalShiftListState.success) {
                  // Calendar expects List<MedicalShiftModel>?
                  // We have List<MedicalShiftEntity>.
                  // We need to cast or map or update CalendarWidget.
                  // CalendarWidget likely uses dynamic or model specific fields.
                  // I should check CalendarWidget.
                  // Assuming I can pass entities if properties match, but Dart is strong typed.
                  // I might need to update CalendarWidget to accept Entity.
                  // Or Map Entity to Model (if Model is in Data layer, Presentation shouldn't use it).
                  // I should update CalendarWidget to use Entity.
                  // I'll assume I'll Todo that.
                  // For now, I'll pass it and if it fails I'll fix CalendarWidget.
                  // Wait, CalendarWidget imports MedicalShiftModel.
                  // Ill update CalendarWidget logic in next step.
                  return Column(
                    children: [
                      CalendarWidget(
                        events: _viewModel.allShiftsForCalendar,
                        initialMonth:
                            _viewModel.selectedMonth ?? DateTime.now().month,
                        initialYear:
                            _viewModel.selectedYear ?? DateTime.now().year,
                        onDaySelected: (selectedDate) {
                          _viewModel.filterByDate(selectedDate);
                        },
                        onMonthChanged: _viewModel.setMonthAndYear,
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
                    if (_viewModel.state == MedicalShiftListState.error) {
                      return Center(
                          child: ErrorRetryWidget(
                              'Algo deu errado', 'Por favor, tente novamente',
                              () {
                        _viewModel.loadMedicalShifts(isRefresh: true);
                      }));
                    }
                    if (_viewModel.state == MedicalShiftListState.loading &&
                        _viewModel.medicalShifts.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (_viewModel.medicalShifts.isEmpty) {
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
                    _listMedicalShift = _viewModel.medicalShifts;
                    return Stack(
                      children: [
                        SlidableAutoCloseBehavior(
                          closeWhenOpened: true,
                          child: ListView.separated(
                              controller: _scrollController,
                              itemCount: _viewModel.state ==
                                      MedicalShiftListState.loading
                                  ? _listMedicalShift!.length + 1
                                  : _listMedicalShift!.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (index < _listMedicalShift!.length) {
                                  MedicalShiftEntity medicalShift =
                                      _listMedicalShift![index];
                                  return Slidable(
                                    key: ValueKey(_listMedicalShift?.length),
                                    startActionPane: !(medicalShift.paid ??
                                            false)
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
                                                    _viewModel.markAsPaid(
                                                        medicalShift.id ?? 0,
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
                                              final hasRecurrence = medicalShift
                                                      .medicalShiftRecurrenceId !=
                                                  null;

                                              if (hasRecurrence) {
                                                final result =
                                                    await showDeleteRecurrenceDialog(
                                                  context: context,
                                                );

                                                if (result == null) {
                                                  return;
                                                } else if (result == true) {
                                                  _viewModel.deleteMedicalShift(
                                                    medicalShift.id ?? 0,
                                                    index,
                                                    recurrenceId: medicalShift
                                                        .medicalShiftRecurrenceId,
                                                  );
                                                } else {
                                                  _viewModel.deleteMedicalShift(
                                                    medicalShift.id ?? 0,
                                                    index,
                                                    recurrenceId: null,
                                                  );
                                                }
                                              } else {
                                                showAlert(
                                                  context: context,
                                                  title: 'Excluir Plantão',
                                                  content:
                                                      'Tem certeza que deseja excluir este plantão?',
                                                  textYes: 'Sim',
                                                  textNo: 'Não',
                                                  onPressedConfirm: () {
                                                    _viewModel
                                                        .deleteMedicalShift(
                                                      medicalShift.id ?? 0,
                                                      index,
                                                      recurrenceId: null,
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
                                                medicalShift: medicalShift));
                                      },
                                      leading: SvgPicture.asset(
                                        (medicalShift.paid ?? false)
                                            ? iconCheckCoreAsset
                                            : iconCloseCoreAsset,
                                        width: 32,
                                        height: 32,
                                        colorFilter: ColorFilter.mode(
                                          (medicalShift.paid ?? false)
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                              : const Color(0xFFEC2A58),
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                      title: Text(
                                        medicalShift.title ?? "",
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
                                                "Horário: ${medicalShift.hour ?? ""}",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                  medicalShift.shiftDescription,
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
                                              Text(medicalShift.date ?? "",
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
                                          medicalShift.amountCents ?? ""),
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
