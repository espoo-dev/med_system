import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:med_system_app/core/utils/ui.dart';
import 'package:med_system_app/core/widgets/error.widget.dart';
import 'package:med_system_app/core/widgets/my_horizontal_menu.widget.dart';
import 'package:med_system_app/features/event_procedures/model/event_procedure.model.dart';
import 'package:med_system_app/features/home/model/menu_home.model.dart';
import 'package:med_system_app/features/home/store/home.store.dart';
import 'package:med_system_app/features/home/widgets/build_header.widget.dart';
import 'package:med_system_app/features/home/widgets/build_welcome.widget.dart';
import 'package:med_system_app/features/home/widgets/list_events.widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            const HeaderHomeWidget(),
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
