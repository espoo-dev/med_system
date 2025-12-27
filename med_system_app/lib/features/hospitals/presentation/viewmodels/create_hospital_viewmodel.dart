import 'package:distrito_medico/features/hospitals/domain/entities/hospital_entity.dart';
import 'package:distrito_medico/features/hospitals/domain/usecases/create_hospital_usecase.dart';
import 'package:mobx/mobx.dart';

part 'create_hospital_viewmodel.g.dart';

/// Estados possíveis da criação de hospital
enum CreateHospitalState { idle, loading, success, error }

// ignore: library_private_types_in_public_api
class CreateHospitalViewModel = _CreateHospitalViewModelBase
    with _$CreateHospitalViewModel;

abstract class _CreateHospitalViewModelBase with Store {
  final CreateHospitalUseCase createHospitalUseCase;

  _CreateHospitalViewModelBase({required this.createHospitalUseCase});

  // ========== Observables ==========

  @observable
  String name = '';

  @observable
  String address = '';

  @observable
  CreateHospitalState state = CreateHospitalState.idle;

  @observable
  String errorMessage = '';

  @observable
  HospitalEntity? createdHospital;

  // ========== Computed ==========

  @computed
  bool get isLoading => state == CreateHospitalState.loading;

  @computed
  bool get canSubmit => name.trim().isNotEmpty && address.trim().isNotEmpty;

  @computed
  bool get isValidName => name.trim().length >= 3;

  @computed
  bool get isValidAddress => address.trim().length >= 5;

  // ========== Actions ==========

  @action
  void setName(String value) {
    name = value;
  }

  @action
  void setAddress(String value) {
    address = value;
  }

  @action
  Future<void> createHospital() async {
    state = CreateHospitalState.loading;
    errorMessage = '';

    final params = CreateHospitalParams(name: name, address: address);
    final result = await createHospitalUseCase(params);

    result.fold(
      (failure) {
        errorMessage = failure.message;
        state = CreateHospitalState.error;
      },
      (hospital) {
        createdHospital = hospital;
        state = CreateHospitalState.success;
      },
    );
  }

  @action
  void resetState() {
    state = CreateHospitalState.idle;
    errorMessage = '';
  }

  @action
  void reset() {
    name = '';
    address = '';
    state = CreateHospitalState.idle;
    errorMessage = '';
    createdHospital = null;
  }
}
