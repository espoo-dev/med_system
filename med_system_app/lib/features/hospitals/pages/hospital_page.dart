import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:med_system_app/core/widgets/error.widget.dart';
import 'package:med_system_app/core/widgets/ext_fab.widget.dart';
import 'package:med_system_app/core/widgets/fab.widget.dart';
import 'package:med_system_app/core/widgets/my_app_bar.widget.dart';
import 'package:med_system_app/features/hospitals/model/hospital.model.dart';
import 'package:med_system_app/features/hospitals/pages/add_hospital_page.dart';
import 'package:med_system_app/features/hospitals/pages/edit_hospital_page.dart';
import 'package:med_system_app/features/hospitals/store/hospital.store.dart';

import '../../../core/utils/navigation_utils.dart';

class HospitalPage extends StatefulWidget {
  const HospitalPage({super.key});

  @override
  State<HospitalPage> createState() => _HospitalPageState();
}

class _HospitalPageState extends State<HospitalPage> {
  final _hostpialStore = GetIt.I.get<HospitalStore>();
  List<Hospital>? _listHospital = [];
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
    _hostpialStore.getAllHospitals(isRefresh: true);
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
      _hostpialStore.getAllHospitals(isRefresh: false);
    }
  }

  Future _refreshProcedures() async {
    await _hostpialStore.getAllHospitals(isRefresh: true);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _hostpialStore.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Hospitais',
        hideLeading: true,
        image: null,
      ),
      floatingActionButton: isFab
          ? buildFAB(context, () {
              to(context, const AddHospitalPage());
            })
          : buildExtendedFAB(
              context,
              "Novo Hospital",
              () {
                to(context, const AddHospitalPage());
              },
            ),
      body: RefreshIndicator(
        onRefresh: _refreshProcedures,
        child: Observer(
          builder: (BuildContext context) {
            if (_hostpialStore.state == HospitalState.error) {
              return Center(
                  child: ErrorRetryWidget(
                      'Algo deu errado', 'Por favor, tente novamente', () {
                _hostpialStore.getAllHospitals(isRefresh: true);
              }));
            }
            if (_hostpialStore.state == HospitalState.loading &&
                _listHospital!.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            if (_hostpialStore.hospitalList.isEmpty) {
              return const Center(
                  child: Text('Você não possui hospitais cadastrados.'));
            }
            _listHospital = _hostpialStore.hospitalList;
            return Stack(
              children: [
                ListView.separated(
                    controller: _scrollController,
                    itemCount: _hostpialStore.state == HospitalState.loading
                        ? _listHospital!.length + 1
                        : _listHospital!.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index < _listHospital!.length) {
                        Hospital hospital = _listHospital![index];
                        return ListTile(
                          onTap: () {
                            to(context, EditHospitaltPage(hospital: hospital));
                          },
                          title: Text(
                            hospital.name ?? "",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(hospital.address ?? ""),
                          trailing: Icon(
                            size: 10.0,
                            Icons.arrow_forward_ios,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          // trailing: IconButton(
                          //   onPressed: () {
                          //     showAlert(
                          //       title: 'Excluir Hospital',
                          //       content:
                          //           'Tem certeza que deseja excluir este hospital?',
                          //       textYes: 'Sim',
                          //       textNo: 'Não',
                          //       onPressedConfirm: () {},
                          //       onPressedCancel: () {
                          //         Navigator.pop(context);
                          //       },
                          //       context: context,
                          //     );
                          //   },
                          //   icon: Icon(
                          //     Icons.delete,
                          //     color: Theme.of(context).colorScheme.primary,
                          //   ),
                          // ),
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
