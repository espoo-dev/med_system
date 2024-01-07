import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:med_system_app/core/widgets/error.widget.dart';
import 'package:med_system_app/core/widgets/my_app_bar.widget.dart';
import 'package:med_system_app/features/procedures/model/procedure.model.dart';
import 'package:med_system_app/features/procedures/store/procedure.store.dart';

class ProceduresPage extends StatefulWidget {
  const ProceduresPage({super.key});

  @override
  State<ProceduresPage> createState() => _ProceduresPageState();
}

class _ProceduresPageState extends State<ProceduresPage> {
  final procedureStore = GetIt.I.get<ProcedureStore>();
  List<Procedure>? _listProcedures;
  @override
  void initState() {
    super.initState();
    debugPrint('initstate');
    procedureStore.getAllProcedures();
  }

  Future _refreshProcedures() async {
    debugPrint('refreshProcedures');
    await procedureStore.getAllProcedures();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Meus Procedimento',
        hideLeading: false,
        image: null,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshProcedures,
        child: Observer(
          builder: (BuildContext context) {
            if (procedureStore.state == ProcedureState.error) {
              return Center(
                  child: ErrorRetryWidget(
                      'Algo deu errado', 'Por favor, tente novamente', () {
                procedureStore.getAllProcedures();
              }));
            }
            if (procedureStore.state == ProcedureState.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (procedureStore.procedureList.isEmpty) {
              return const Center(
                  child: Text('Você não possui procedimentos cadastrados.'));
            }
            _listProcedures = procedureStore.procedureList;
            return ListView.builder(
                itemCount: _listProcedures!.length,
                itemBuilder: (BuildContext context, int index) {
                  Procedure procedure = _listProcedures![index];
                  return Text(procedure.name ?? "");
                });
          },
        ),
      ),
    );
  }
}
