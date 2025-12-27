import 'package:distrito_medico/features/patients/domain/entities/patient_entity.dart';
import 'package:distrito_medico/features/patients/domain/usecases/delete_patient_usecase.dart';
import 'package:distrito_medico/features/patients/domain/usecases/get_all_patients_usecase.dart';
import 'package:mobx/mobx.dart';

part 'patient_list_viewmodel.g.dart';

/// Estados possíveis da listagem de pacientes
enum PatientListState { idle, loading, success, error }

/// Estados possíveis da deleção de paciente
enum DeletePatientState { idle, loading, success, error }

// ignore: library_private_types_in_public_api
class PatientListViewModel = _PatientListViewModelBase
    with _$PatientListViewModel;

abstract class _PatientListViewModelBase with Store {
  final GetAllPatientsUseCase getAllPatientsUseCase;
  final DeletePatientUseCase deletePatientUseCase;

  _PatientListViewModelBase({
    required this.getAllPatientsUseCase,
    required this.deletePatientUseCase,
  });

  // ========== Observables ==========

  @observable
  ObservableList<PatientEntity> patients = ObservableList<PatientEntity>();

  @observable
  PatientListState state = PatientListState.idle;

  @observable
  DeletePatientState deleteState = DeletePatientState.idle;

  @observable
  String errorMessage = '';

  @observable
  int currentPage = 1;

  @observable
  int perPage = 10000;

  // ========== Computed ==========

  @computed
  bool get isLoading => state == PatientListState.loading;

  @computed
  bool get isDeleting => deleteState == DeletePatientState.loading;

  @computed
  bool get hasPatients => patients.isNotEmpty;

  @computed
  int get patientsCount => patients.length;

  // ========== Actions ==========

  @action
  Future<void> loadPatients({bool refresh = false}) async {
    if (refresh) {
      currentPage = 1;
      patients.clear();
    }

    state = PatientListState.loading;
    errorMessage = '';

    final params = GetAllPatientsParams(
      page: currentPage,
      perPage: perPage,
    );

    final result = await getAllPatientsUseCase(params);

    result.fold(
      (failure) {
        errorMessage = failure.message;
        state = PatientListState.error;
      },
      (patientList) {
        if (refresh) {
          patients.clear();
        }
        patients.addAll(patientList);
        state = PatientListState.success;
        
        if (!refresh) {
          currentPage++;
        }
      },
    );
  }

  @action
  Future<void> deletePatient(int patientId) async {
    deleteState = DeletePatientState.loading;
    errorMessage = '';

    final params = DeletePatientParams(id: patientId);
    final result = await deletePatientUseCase(params);

    result.fold(
      (failure) {
        errorMessage = failure.message;
        deleteState = DeletePatientState.error;
      },
      (_) {
        // Remove da lista local
        patients.removeWhere((patient) => patient.id == patientId);
        deleteState = DeletePatientState.success;
      },
    );
  }

  @action
  void resetDeleteState() {
    deleteState = DeletePatientState.idle;
    errorMessage = '';
  }

  @action
  void resetState() {
    state = PatientListState.idle;
    errorMessage = '';
  }

  @action
  void dispose() {
    patients.clear();
    currentPage = 1;
    state = PatientListState.idle;
    deleteState = DeletePatientState.idle;
  }
}
