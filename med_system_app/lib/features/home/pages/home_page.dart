import 'package:distrito_medico/core/utils/navigation_utils.dart';
import 'package:distrito_medico/core/widgets/error.widget.dart';
import 'package:distrito_medico/core/widgets/my_horizontal_menu.widget.dart';
import 'package:distrito_medico/features/event_procedures/model/event_procedure.model.dart';
import 'package:distrito_medico/features/event_procedures/pages/add_event_procedure_page.dart';
import 'package:distrito_medico/features/home/model/menu_home.model.dart';
import 'package:distrito_medico/features/home/pages/empty_events_procedures_page.dart';
import 'package:distrito_medico/features/home/store/home.store.dart';
import 'package:distrito_medico/features/home/widgets/build_header.widget.dart';
import 'package:distrito_medico/features/home/widgets/build_welcome.widget.dart';
import 'package:distrito_medico/features/home/widgets/list_events.widget.dart';
import 'package:distrito_medico/features/home/widgets/my_app_bar.widget.dart';
import 'package:distrito_medico/features/home/widgets/my_drawer.widget.dart';
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
    return Material(
      child: Scaffold(
        key: _scaffoldKey,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Observer(builder: (BuildContext context) {
          return Visibility(
            visible: homeStore.showFloatingActionButton,
            child: FloatingActionButton(
              onPressed: () {
                push(
                    context,
                    const AddEventProcedurePage(
                      backToHome: true,
                    ));
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
            ],
          ),
        ),
      ),
    );
  }
}
