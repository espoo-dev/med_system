import 'package:distrito_medico/features/patients/domain/entities/patient_entity.dart';
import 'package:distrito_medico/features/patients/domain/usecases/create_patient_usecase.dart';
import 'package:mobx/mobx.dart';

part 'create_patient_viewmodel.g.dart';

/// Estados possíveis da criação de paciente
enum CreatePatientState { idle, loading, success, error }

// ignore: library_private_types_in_public_api
class CreatePatientViewModel = _CreatePatientViewModelBase
    with _$CreatePatientViewModel;

abstract class _CreatePatientViewModelBase with Store {
  final CreatePatientUseCase createPatientUseCase;

  _CreatePatientViewModelBase({required this.createPatientUseCase});

  // ========== Observables ==========

  @observable
  String name = '';

  @observable
  CreatePatientState state = CreatePatientState.idle;

  @observable
  String errorMessage = '';

  @observable
  PatientEntity? createdPatient;

  // ========== Computed ==========

  @computed
  bool get isLoading => state == CreatePatientState.loading;

  @computed
  bool get canSubmit => name.trim().isNotEmpty;

  @computed
  bool get isValidName => name.trim().length >= 3;

  // ========== Actions ==========

  @action
  void setName(String value) {
    name = value;
  }

  @action
  Future<void> createPatient() async {
    state = CreatePatientState.loading;
    errorMessage = '';

    final params = CreatePatientParams(name: name);
    final result = await createPatientUseCase(params);

    result.fold(
      (failure) {
        errorMessage = failure.message;
        state = CreatePatientState.error;
      },
      (patient) {
        createdPatient = patient;
        state = CreatePatientState.success;
      },
    );
  }

  @action
  void resetState() {
    state = CreatePatientState.idle;
    errorMessage = '';
  }

  @action
  void reset() {
    name = '';
    state = CreatePatientState.idle;
    errorMessage = '';
    createdPatient = null;
  }
}
