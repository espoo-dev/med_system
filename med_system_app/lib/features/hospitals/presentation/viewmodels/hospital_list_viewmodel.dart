import 'package:distrito_medico/features/hospitals/domain/entities/hospital_entity.dart';
import 'package:distrito_medico/features/hospitals/domain/usecases/get_all_hospitals_usecase.dart';
import 'package:mobx/mobx.dart';

part 'hospital_list_viewmodel.g.dart';

/// Estados possíveis da listagem de hospitais
enum HospitalListState { idle, loading, success, error }

// ignore: library_private_types_in_public_api
class HospitalListViewModel = _HospitalListViewModelBase
    with _$HospitalListViewModel;

abstract class _HospitalListViewModelBase with Store {
  final GetAllHospitalsUseCase getAllHospitalsUseCase;

  _HospitalListViewModelBase({
    required this.getAllHospitalsUseCase,
  });

  // ========== Observables ==========

  @observable
  ObservableList<HospitalEntity> hospitals = ObservableList<HospitalEntity>();

  @observable
  HospitalListState state = HospitalListState.idle;

  @observable
  String errorMessage = '';

  @observable
  int currentPage = 1;

  @observable
  int perPage = 10000;

  // ========== Computed ==========

  @computed
  bool get isLoading => state == HospitalListState.loading;

  @computed
  bool get hasHospitals => hospitals.isNotEmpty;

  @computed
  int get hospitalsCount => hospitals.length;

  // ========== Actions ==========

  @action
  Future<void> loadHospitals({bool refresh = false}) async {
    if (refresh) {
      currentPage = 1;
      hospitals.clear();
    }

    state = HospitalListState.loading;
    errorMessage = '';

    final params = GetAllHospitalsParams(
      page: currentPage,
      perPage: perPage,
    );

    final result = await getAllHospitalsUseCase(params);

    result.fold(
      (failure) {
        errorMessage = failure.message;
        state = HospitalListState.error;
      },
      (hospitalList) {
        if (refresh) {
          hospitals.clear();
        }
        hospitals.addAll(hospitalList);
        state = HospitalListState.success;
        
        if (!refresh) {
          currentPage++;
        }
      },
    );
  }

  @action
  void resetState() {
    state = HospitalListState.idle;
    errorMessage = '';
  }

  @action
  void dispose() {
    hospitals.clear();
    currentPage = 1;
    state = HospitalListState.idle;
  }
}
