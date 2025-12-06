import 'package:distrito_medico/features/patients/domain/entities/patient_entity.dart';
import 'package:distrito_medico/features/patients/domain/usecases/update_patient_usecase.dart';
import 'package:mobx/mobx.dart';

part 'update_patient_viewmodel.g.dart';

/// Estados possíveis da atualização de paciente
enum UpdatePatientState { idle, loading, success, error }

// ignore: library_private_types_in_public_api
class UpdatePatientViewModel = _UpdatePatientViewModelBase
    with _$UpdatePatientViewModel;

abstract class _UpdatePatientViewModelBase with Store {
  final UpdatePatientUseCase updatePatientUseCase;

  _UpdatePatientViewModelBase({required this.updatePatientUseCase});

  // ========== Observables ==========

  @observable
  int? patientId;

  @observable
  String name = '';

  @observable
  UpdatePatientState state = UpdatePatientState.idle;

  @observable
  String errorMessage = '';

  @observable
  PatientEntity? updatedPatient;

  // ========== Computed ==========

  @computed
  bool get isLoading => state == UpdatePatientState.loading;

  @computed
  bool get canSubmit => name.trim().isNotEmpty && patientId != null;

  @computed
  bool get isValidName => name.trim().length >= 3;

  // ========== Actions ==========

  @action
  void setPatientId(int id) {
    patientId = id;
  }

  @action
  void setName(String value) {
    name = value;
  }

  @action
  void loadPatient(PatientEntity patient) {
    patientId = patient.id;
    name = patient.name;
  }

  @action
  Future<void> updatePatient() async {
    if (patientId == null) {
      errorMessage = 'ID do paciente não definido';
      state = UpdatePatientState.error;
      return;
    }

    state = UpdatePatientState.loading;
    errorMessage = '';

    final params = UpdatePatientParams(
      id: patientId!,
      name: name,
    );

    final result = await updatePatientUseCase(params);

    result.fold(
      (failure) {
        errorMessage = failure.message;
        state = UpdatePatientState.error;
      },
      (patient) {
        updatedPatient = patient;
        state = UpdatePatientState.success;
      },
    );
  }

  @action
  void resetState() {
    state = UpdatePatientState.idle;
    errorMessage = '';
  }

  @action
  void reset() {
    patientId = null;
    name = '';
    state = UpdatePatientState.idle;
    errorMessage = '';
    updatedPatient = null;
  }
}
