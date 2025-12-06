import 'package:distrito_medico/core/utils/navigation_utils.dart';
import 'package:distrito_medico/core/widgets/error.widget.dart';
import 'package:distrito_medico/core/widgets/ext_fab.widget.dart';
import 'package:distrito_medico/core/widgets/fab.widget.dart';
import 'package:distrito_medico/core/widgets/my_app_bar.widget.dart';
import 'package:distrito_medico/features/hospitals/domain/entities/hospital_entity.dart';
import 'package:distrito_medico/features/hospitals/pages/add_hospital_page.dart';
import 'package:distrito_medico/features/hospitals/pages/edit_hospital_page.dart';
import 'package:distrito_medico/features/hospitals/presentation/viewmodels/hospital_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class HospitalPage extends StatefulWidget {
  const HospitalPage({super.key});

  @override
  State<HospitalPage> createState() => _HospitalPageState();
}

class _HospitalPageState extends State<HospitalPage> {
  final _viewModel = GetIt.I.get<HospitalListViewModel>();
  final ScrollController _scrollController = ScrollController();
  bool isFab = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      infiniteScrolling();
      showFabButton();
    });
    _viewModel.loadHospitals(refresh: true);
  }

  void showFabButton() {
    if (_scrollController.offset > 50) {
      if (!isFab) {
        setState(() {
          isFab = true;
        });
      }
    } else {
      if (isFab) {
        setState(() {
          isFab = false;
        });
      }
    }
  }

  void infiniteScrolling() {
    var maxScroll = _scrollController.position.maxScrollExtent;
    if (maxScroll == _scrollController.offset) {
      _viewModel.loadHospitals(refresh: false);
    }
  }

  Future<void> _refreshHospitals() async {
    await _viewModel.loadHospitals(refresh: true);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    // Não damos dispose no ViewModel aqui pois ele é um Singleton
    // Mas podemos resetar o estado se necessário
    // _viewModel.dispose();
    super.dispose();
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
        onRefresh: _refreshHospitals,
        child: Observer(
          builder: (BuildContext context) {
            if (_viewModel.state == HospitalListState.error &&
                _viewModel.hospitals.isEmpty) {
              return Center(
                child: ErrorRetryWidget(
                  'Algo deu errado',
                  'Por favor, tente novamente',
                  () {
                    _viewModel.loadHospitals(refresh: true);
                  },
                ),
              );
            }

            if (_viewModel.state == HospitalListState.loading &&
                _viewModel.hospitals.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (_viewModel.hospitals.isEmpty &&
                _viewModel.state == HospitalListState.success) {
              return const Center(
                child: Text('Você não possui hospitais cadastrados.'),
              );
            }

            return Stack(
              children: [
                ListView.separated(
                  controller: _scrollController,
                  itemCount: _viewModel.state == HospitalListState.loading
                      ? _viewModel.hospitals.length + 1
                      : _viewModel.hospitals.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index < _viewModel.hospitals.length) {
                      HospitalEntity hospital = _viewModel.hospitals[index];
                      return ListTile(
                        onTap: () {
                          to(context, EditHospitaltPage(hospital: hospital));
                        },
                        title: Text(
                          hospital.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(hospital.address),
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
                  separatorBuilder: (_, __) => const Divider(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
