import 'package:distrito_medico/core/utils/navigation_utils.dart';
import 'package:distrito_medico/features/home/pages/search_patient_page.dart';
import 'package:distrito_medico/core/widgets/error.widget.dart';
import 'package:distrito_medico/core/widgets/my_horizontal_menu.widget.dart';
import 'package:distrito_medico/features/event_procedures/model/event_procedure.model.dart';
import 'package:distrito_medico/features/event_procedures/pages/add_event_procedure_page.dart';
import 'package:distrito_medico/features/home/model/menu_home.model.dart';
import 'package:distrito_medico/features/home/model/menu_home_medical_shift.dart';
import 'package:distrito_medico/features/home/pages/empty_events_procedures_page.dart';
import 'package:distrito_medico/features/home/store/home.store.dart';
import 'package:distrito_medico/features/home/widgets/build_header.widget.dart';
import 'package:distrito_medico/features/home/widgets/build_welcome.widget.dart';
import 'package:distrito_medico/features/home/widgets/list_events.widget.dart';
import 'package:distrito_medico/features/home/widgets/list_medical_shifts.widget.dart';
import 'package:distrito_medico/features/home/widgets/my_app_bar.widget.dart';
import 'package:distrito_medico/features/home/widgets/my_drawer.widget.dart';
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
  final homeStore = GetIt.I.get<HomeStore>();
  final List<EventProcedures> _listEventProcedures = [];
  
  bool _isSearchExpanded = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    homeStore.fetchAllData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchSubmit() {
    if (_searchController.text.isNotEmpty) {
      final query = _searchController.text;
      setState(() {
        _isSearchExpanded = false;
        _searchController.clear();
      });
      push(context, SearchPatientPage(initialQuery: query));
    }
  }

  _buildPageBody(BuildContext context) {
    return Observer(builder: (BuildContext context) {
      if (homeStore.state == HomeState.error) {
        return Center(
            child: ErrorRetryWidget(
                'Algo deu errado', 'Por favor, tente novamente', () {
          homeStore.fetchAllData();
        }));
      }
      if (homeStore.state == HomeState.loading &&
          _listEventProcedures.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }
      if (homeStore.eventProcedureList.isEmpty) {
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
                    selected:
                        homeStore.selectedFilter == HomeFilterType.procedures,
                    onSelected: (bool selected) {
                      if (selected) {
                        homeStore.setSelectedFilter(HomeFilterType.procedures);
                      }
                    },
                    selectedColor: Theme.of(context).colorScheme.primary,
                    showCheckmark: false,
                    labelStyle: TextStyle(
                      color:
                          homeStore.selectedFilter == HomeFilterType.procedures
                              ? Colors.white
                              : Colors.black,
                    ),
                  ),
                  FilterChip(
                    label: const Text('Plantões'),
                    selected: homeStore.selectedFilter ==
                        HomeFilterType.medicalShifts,
                    onSelected: (bool selected) {
                      if (selected) {
                        homeStore
                            .setSelectedFilter(HomeFilterType.medicalShifts);
                      }
                    },
                    selectedColor: Theme.of(context).colorScheme.primary,
                    showCheckmark: false,
                    labelStyle: TextStyle(
                      color: homeStore.selectedFilter ==
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
              menuItems: homeStore.selectedFilter == HomeFilterType.procedures
                  ? menuHomeModel.buildMenuHome(
                      homeStore.eventProcedureModel.total,
                      homeStore.eventProcedureModel.totalpaid,
                      homeStore.eventProcedureModel.totalUnpaid,
                      context)
                  : menuHomeMedicalShiftsaModel.buildMenuHome(
                      homeStore.medicalShift.total,
                      homeStore.medicalShift.totalpaid,
                      homeStore.medicalShift.totalUnpaid,
                      context),
            ),
            homeStore.selectedFilter == HomeFilterType.procedures
                ? ListEventsWidget(
                    items: homeStore.eventProcedureList,
                  )
                : ListMedicalShiftsWidget(
                    items: homeStore.medicalShiftList,
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
            visible: homeStore.showFloatingActionButton,
            child: FloatingActionButton(
              onPressed: () {
                if (homeStore.selectedFilter == HomeFilterType.procedures) {
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
          return MyBottomAppBar(visible: homeStore.showBottomAppBar);
        }),
        drawer: const MyDrawer(),
        body: SafeArea(
          child: Stack(
            children: [
              _buildPageBody(context),
              
              // Bubble Search Field (WhatsApp style)
              if (_isSearchExpanded)
                Positioned(
                  bottom: 90,
                  right: 20,
                  child: Material(
                    elevation: 8,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(5), // Tail effect
                    ),
                    color: Colors.white,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: MediaQuery.of(context).size.width * 0.75,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              autofocus: true,
                              decoration: const InputDecoration(
                                hintText: 'Nome do paciente...',
                                border: InputBorder.none,
                                hintStyle: TextStyle(fontSize: 14),
                              ),
                              onSubmitted: (_) => _onSearchSubmit(),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.send, color: Theme.of(context).colorScheme.primary),
                            onPressed: _onSearchSubmit,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              // Search FAB on the right
              Positioned(
                bottom: 20,
                right: 20,
                child: FloatingActionButton(
                  mini: true,
                  onPressed: () {
                    setState(() {
                      _isSearchExpanded = !_isSearchExpanded;
                      if (!_isSearchExpanded) {
                        _searchController.clear();
                      }
                    });
                  },
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Icon(
                    _isSearchExpanded ? Icons.close : Icons.search,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
