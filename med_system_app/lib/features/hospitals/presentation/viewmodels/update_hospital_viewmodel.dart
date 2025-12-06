import 'package:distrito_medico/features/hospitals/domain/entities/hospital_entity.dart';
import 'package:distrito_medico/features/hospitals/domain/usecases/update_hospital_usecase.dart';
import 'package:mobx/mobx.dart';

part 'update_hospital_viewmodel.g.dart';

/// Estados possíveis da atualização de hospital
enum UpdateHospitalState { idle, loading, success, error }

// ignore: library_private_types_in_public_api
class UpdateHospitalViewModel = _UpdateHospitalViewModelBase
    with _$UpdateHospitalViewModel;

abstract class _UpdateHospitalViewModelBase with Store {
  final UpdateHospitalUseCase updateHospitalUseCase;

  _UpdateHospitalViewModelBase({required this.updateHospitalUseCase});

  // ========== Observables ==========

  @observable
  int? hospitalId;

  @observable
  String name = '';

  @observable
  String address = '';

  @observable
  UpdateHospitalState state = UpdateHospitalState.idle;

  @observable
  String errorMessage = '';

  @observable
  HospitalEntity? updatedHospital;

  // ========== Computed ==========

  @computed
  bool get isLoading => state == UpdateHospitalState.loading;

  @computed
  bool get canSubmit =>
      name.trim().isNotEmpty && address.trim().isNotEmpty && hospitalId != null;

  @computed
  bool get isValidName => name.trim().length >= 3;

  @computed
  bool get isValidAddress => address.trim().length >= 5;

  // ========== Actions ==========

  @action
  void setHospitalId(int id) {
    hospitalId = id;
  }

  @action
  void setName(String value) {
    name = value;
  }

  @action
  void setAddress(String value) {
    address = value;
  }

  @action
  void loadHospital(HospitalEntity hospital) {
    hospitalId = hospital.id;
    name = hospital.name;
    address = hospital.address;
  }

  @action
  Future<void> updateHospital() async {
    if (hospitalId == null) {
      errorMessage = 'ID do hospital não definido';
      state = UpdateHospitalState.error;
      return;
    }

    state = UpdateHospitalState.loading;
    errorMessage = '';

    final params = UpdateHospitalParams(
      id: hospitalId!,
      name: name,
      address: address,
    );

    final result = await updateHospitalUseCase(params);

    result.fold(
      (failure) {
        errorMessage = failure.message;
        state = UpdateHospitalState.error;
      },
      (hospital) {
        updatedHospital = hospital;
        state = UpdateHospitalState.success;
      },
    );
  }

  @action
  void resetState() {
    state = UpdateHospitalState.idle;
    errorMessage = '';
  }

  @action
  void reset() {
    hospitalId = null;
    name = '';
    address = '';
    state = UpdateHospitalState.idle;
    errorMessage = '';
    updatedHospital = null;
  }
}
