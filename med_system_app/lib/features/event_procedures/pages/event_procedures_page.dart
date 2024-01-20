import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:med_system_app/core/theme/icons.dart';
import 'package:med_system_app/core/widgets/error.widget.dart';
import 'package:med_system_app/core/widgets/my_app_bar.widget.dart';
import 'package:med_system_app/features/event_procedures/model/event_procedure.model.dart';
import 'package:med_system_app/features/event_procedures/pages/widgets/ext_fab.widget.dart';
import 'package:med_system_app/features/event_procedures/pages/widgets/fab.widget.dart';
import 'package:med_system_app/features/event_procedures/store/event_procedure.store.dart';

class EventProceduresPage extends StatefulWidget {
  const EventProceduresPage({super.key});

  @override
  State<EventProceduresPage> createState() => _EventProceduresPageState();
}

class _EventProceduresPageState extends State<EventProceduresPage> {
  final eventProcedureStore = GetIt.I.get<EventProcedureStore>();
  List<EventProcedures>? _listEventProcedures = [];
  final ScrollController _scrollController = ScrollController();
  bool isFab = false;
  @override
  void initState() {
    super.initState();
    debugPrint('initstate');
    _scrollController.addListener(() {
      inifiteScrolling();
      showFabButton();
    });
    eventProcedureStore.getAllEventProcedures(isRefresh: true);
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

  inifiteScrolling() {
    var maxScroll = _scrollController.position.maxScrollExtent;
    if (maxScroll == _scrollController.offset) {
      eventProcedureStore.getAllEventProcedures(isRefresh: false);
    }
  }

  Future _refreshProcedures() async {
    debugPrint('refreshProcedures');
    await eventProcedureStore.getAllEventProcedures(isRefresh: true);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    eventProcedureStore.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Eventos Procedimentos',
        hideLeading: true,
        image: null,
      ),
      floatingActionButton:
          isFab ? buildFAB(context) : buildExtendedFAB(context),
      body: RefreshIndicator(
        onRefresh: _refreshProcedures,
        child: Observer(
          builder: (BuildContext context) {
            if (eventProcedureStore.state == EventProcedureState.error) {
              return Center(
                  child: ErrorRetryWidget(
                      'Algo deu errado', 'Por favor, tente novamente', () {
                eventProcedureStore.getAllEventProcedures(isRefresh: true);
              }));
            }
            if (eventProcedureStore.state == EventProcedureState.loading &&
                _listEventProcedures!.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            if (eventProcedureStore.eventProcedureList.isEmpty) {
              return const Center(
                  child: Text(
                      'Você não possui eventos procedimentos cadastrados.'));
            }
            _listEventProcedures = eventProcedureStore.eventProcedureList;
            return Stack(
              children: [
                ListView.separated(
                    controller: _scrollController,
                    itemCount:
                        eventProcedureStore.state == EventProcedureState.loading
                            ? _listEventProcedures!.length + 1
                            : _listEventProcedures!.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index < _listEventProcedures!.length) {
                        EventProcedures eventProcedures =
                            _listEventProcedures![index];
                        return ListTile(
                          leading: SvgPicture.asset(
                            iconWaterDropCoreAsset,
                            width: 32,
                            height: 32,
                            color: eventProcedures.isPaid()
                                ? const Color(0xFF388E3C)
                                : const Color(0xFFEC2A58),
                          ),
                          title: Text(
                            eventProcedures.procedure ?? "",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(eventProcedures.patient ?? ""),
                          trailing: Icon(
                            size: 10.0,
                            Icons.arrow_forward_ios,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                    separatorBuilder: (_, __) => const Divider()),
              ],
            );
          },
        ),
      ),
    );
  }
}
