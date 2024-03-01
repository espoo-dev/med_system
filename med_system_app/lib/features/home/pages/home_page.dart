import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:med_system_app/core/theme/icons.dart';
import 'package:med_system_app/core/utils/navigation_utils.dart';
import 'package:med_system_app/core/utils/ui.dart';
import 'package:med_system_app/core/widgets/error.widget.dart';
import 'package:med_system_app/core/widgets/my_horizontal_menu.widget.dart';
import 'package:med_system_app/features/event_procedures/model/event_procedure.model.dart';
import 'package:med_system_app/features/event_procedures/pages/add_event_procedure_page.dart';
import 'package:med_system_app/features/event_procedures/pages/event_procedures_page.dart';
import 'package:med_system_app/features/home/model/menu_home.model.dart';
import 'package:med_system_app/features/home/store/home.store.dart';
import 'package:med_system_app/features/home/widgets/build_header.widget.dart';
import 'package:med_system_app/features/home/widgets/build_welcome.widget.dart';
import 'package:med_system_app/features/home/widgets/list_events.widget.dart';
import 'package:med_system_app/features/home/widgets/my_drawer.widget.dart';
import 'package:med_system_app/features/patients/pages/patient_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  MenuHomeModel menuHomeModel = MenuHomeModel();
  final homeStore = GetIt.I.get<HomeStore>();
  final List<EventProcedures> _listEventProcedures = [];
  @override
  void initState() {
    super.initState();

    homeStore.getLatestEventProcedures();
  }

  _buildPageBody(BuildContext context) {
    return Observer(builder: (BuildContext context) {
      if (homeStore.state == EventProcedureState.error) {
        return Center(
            child: ErrorRetryWidget(
                'Algo deu errado', 'Por favor, tente novamente', () {
          homeStore.getLatestEventProcedures();
        }));
      }
      if (homeStore.state == EventProcedureState.loading &&
          _listEventProcedures.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }
      if (homeStore.eventProcedureList.isEmpty) {
        return const Center(
            child: Text('Você não possui eventos procedimentos cadastrados.'));
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
            const SizedBox(height: 22),
            HorizontalMenuWidget(
              menuItems: menuHomeModel.buildMenuHome(
                  homeStore.eventProcedureModel.total,
                  homeStore.eventProcedureModel.totalPayd,
                  homeStore.eventProcedureModel.totalUnpayd,
                  context),
            ),
            ListEventsWidget(
              items: homeStore.eventProcedureList,
            )
          ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) {
          return;
        }
        showAlert(
            title: 'Você tem certeza?',
            content: 'Deseja fechar o aplicativo',
            textYes: 'Sim, quero sair',
            textNo: 'Não',
            onPressedConfirm: () {
              Navigator.pop(context);
              SystemNavigator.pop();
            },
            onPressedCancel: () {
              Navigator.pop(context);
            },
            context: context);
      },
      child: Material(
        child: Scaffold(
          key: _scaffoldKey,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              push(context, const AddEventProcedurePage());
            },
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          bottomNavigationBar: BottomAppBar(
              notchMargin: 5.0,
              shape: const CircularNotchedRectangle(),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(
                      icon: SvgPicture.asset(
                        iconMenuPlantao,
                        width: 24,
                        height: 24,
                      ),
                      onPressed: () {
                        push(context, const EventProceduresPage());
                      },
                    ),
                    IconButton(
                      icon: SvgPicture.asset(
                        iconMenuPatient,
                        width: 24,
                        height: 24,
                      ),
                      onPressed: () {
                        push(context, const PatientPage());
                      },
                    ),
                  ])),
          drawer: const MyDrawer(),
          body: SafeArea(
            child: Stack(
              children: [
                _buildPageBody(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
