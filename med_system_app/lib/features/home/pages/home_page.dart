import 'package:distrito_medico/core/utils/navigation_utils.dart';
import 'package:distrito_medico/core/widgets/error.widget.dart';
import 'package:distrito_medico/core/widgets/my_horizontal_menu.widget.dart';
import 'package:distrito_medico/features/event_procedures/model/event_procedure.model.dart';
import 'package:distrito_medico/features/event_procedures/pages/add_event_procedure_page.dart';
import 'package:distrito_medico/features/home/model/menu_home.model.dart';
import 'package:distrito_medico/features/home/model/menu_home_medical_shift.dart';
import 'package:distrito_medico/features/home/pages/empty_events_procedures_page.dart';
import 'package:distrito_medico/features/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:distrito_medico/features/home/widgets/build_header.widget.dart';
import 'package:distrito_medico/features/home/widgets/build_welcome.widget.dart';
import 'package:distrito_medico/features/home/widgets/list_events.widget.dart';
import 'package:distrito_medico/features/home/widgets/list_medical_shifts.widget.dart';
import 'package:distrito_medico/features/home/widgets/my_app_bar.widget.dart';
import 'package:distrito_medico/features/home/widgets/my_drawer.widget.dart';
import 'package:distrito_medico/features/medical_shifts/domain/entities/medical_shift_entity.dart';
import 'package:distrito_medico/features/medical_shifts/pages/add_medical_shift_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  MenuHomeModel menuHomeModel = MenuHomeModel();
  MenuHomeMedicalSfhitModel menuHomeMedicalShiftsaModel =
      MenuHomeMedicalSfhitModel();
  final homeViewModel = GetIt.I.get<HomeViewModel>();
  final List<EventProcedures> _listEventProcedures = [];

  @override
  void initState() {
    super.initState();
    homeViewModel.fetchAllData();
  }

  _buildPageBody(BuildContext context) {
    return Observer(builder: (BuildContext context) {
      if (homeViewModel.errorMessage != null) {
        return Center(
            child: ErrorRetryWidget(
                'Algo deu errado', 'Por favor, tente novamente', () {
          homeViewModel.fetchAllData();
        }));
      }
      if (homeViewModel.isLoading && _listEventProcedures.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }
      if (homeViewModel.eventProcedures.isEmpty) {
        return const EmptyPageEventsProcedure();
      }
      return ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: <Widget>[
            HeaderHomeWidget(
              onMenuPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
            const WelcomeWidget(),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Wrap(
                spacing: 10.0,
                children: [
                  FilterChip(
                    label: const Text('Procedimentos'),
                    selected: homeViewModel.selectedFilter ==
                        HomeFilterType.procedures,
                    onSelected: (bool selected) {
                      if (selected) {
                        homeViewModel
                            .setSelectedFilter(HomeFilterType.procedures);
                      }
                    },
                    selectedColor: Theme.of(context).colorScheme.primary,
                    showCheckmark: false,
                    labelStyle: TextStyle(
                      color: homeViewModel.selectedFilter ==
                              HomeFilterType.procedures
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  FilterChip(
                    label: const Text('Plantões'),
                    selected: homeViewModel.selectedFilter ==
                        HomeFilterType.medicalShifts,
                    onSelected: (bool selected) {
                      if (selected) {
                        homeViewModel
                            .setSelectedFilter(HomeFilterType.medicalShifts);
                      }
                    },
                    selectedColor: Theme.of(context).colorScheme.primary,
                    showCheckmark: false,
                    labelStyle: TextStyle(
                      color: homeViewModel.selectedFilter ==
                              HomeFilterType.medicalShifts
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            HorizontalMenuWidget(
              menuItems:
                  homeViewModel.selectedFilter == HomeFilterType.procedures
                      ? menuHomeModel.buildMenuHome(
                          homeViewModel.totalProcedures.toString(),
                          homeViewModel.totalPaidProcedures.toString(),
                          homeViewModel.totalUnpaidProcedures.toString(),
                          context)
                      : menuHomeMedicalShiftsaModel.buildMenuHome(
                          homeViewModel.totalMedicalShifts.toString(),
                          homeViewModel.totalPaidMedicalShifts.toString(),
                          homeViewModel.totalUnpaidMedicalShifts.toString(),
                          context),
            ),
            homeViewModel.selectedFilter == HomeFilterType.procedures
                ? ListEventsWidget(
                    items: homeViewModel.eventProcedures
                        .map((e) => EventProcedures(
                              id: e.id,
                              patient: e.patient,
                              procedure: e.procedure,
                              hospital: e.hospital,
                              date: e.date,
                              paid: e.paid,
                              paidAt: e.paidAt,
                              payment: e.payment,
                            ))
                        .toList(),
                  )
                : ListMedicalShiftsWidget(
                    items: homeViewModel.medicalShifts
                        .map((s) => MedicalShiftEntity(
                              id: s.id,
                              hospitalName: s.hospitalName,
                              date: s.date,
                              workload: s.workload,
                              amountCents: s.amountCents,
                              paid: s.paid,
                            ))
                        .toList(),
                  ),
          ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        key: _scaffoldKey,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Observer(builder: (BuildContext context) {
          return Visibility(
            visible: homeViewModel.showFloatingActionButton,
            child: FloatingActionButton(
              onPressed: () {
                if (homeViewModel.selectedFilter == HomeFilterType.procedures) {
                  push(
                    context,
                    const AddEventProcedurePage(
                      backToHome: true,
                    ),
                  );
                } else {
                  push(
                    context,
                    const AddMedicalShiftPage(
                      backToHome: true,
                    ),
                  );
                }
              },
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          );
        }),
        bottomNavigationBar: Observer(builder: (BuildContext context) {
          return MyBottomAppBar(visible: homeViewModel.showBottomAppBar);
        }),
        drawer: const MyDrawer(),
        body: SafeArea(
          child: Stack(
            children: [
              _buildPageBody(context),
            ],
          ),
        ),
      ),
    );
  }
}
