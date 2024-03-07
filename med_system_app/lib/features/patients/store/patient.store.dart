import 'package:distrito_medico/core/api/network_exceptions.dart';
import 'package:distrito_medico/features/patients/model/patient.model.dart';
import 'package:distrito_medico/features/patients/repository/patient_repository.dart';
import 'package:mobx/mobx.dart';

part 'patient.store.g.dart';

// ignore: library_private_types_in_public_api
class PatientStore = _PatientStoreBase with _$PatientStore;

enum PatientState { idle, success, error, loading }

abstract class _PatientStoreBase with Store {
  final PatientRepository _patientRepository;

  ObservableList<Patient> patientList = ObservableList<Patient>();

  @observable
  PatientState state = PatientState.idle;

  @observable
  String _errorMessage = "";
  get errorMessage => _errorMessage;

  @observable
  int _page = 1;
  get page => _page;

  _PatientStoreBase(PatientRepository patientRepository)
      : _patientRepository = patientRepository;

  @action
  getAllPatients({bool isRefresh = false}) async {
    if (isRefresh) {
      _page = 1;
      patientList.clear();
    }
    state = PatientState.loading;
    if (!isRefresh) {
      _page++;
    }
    state = PatientState.loading;
    var resultPatient =
        await _patientRepository.getAllPatients(_page).asObservable();
    resultPatient?.when(success: (List<Patient>? listPatient) {
      patientList.addAll(listPatient!);
      state = PatientState.success;
    }, failure: (NetworkExceptions error) {
      handleError(NetworkExceptions.getErrorMessage(error));
      state = PatientState.error;
    });
  }

  @action
  deletePatient(int patientId) async {
    state = PatientState.loading;
    var registerPatientResult =
        await _patientRepository.deletePatient(patientId);
    registerPatientResult?.when(success: (patient) {
      getAllPatients(isRefresh: true);
      state = PatientState.success;
    }, failure: (NetworkExceptions error) {
      handleError(NetworkExceptions.getErrorMessage(error));
      state = PatientState.error;
    });
  }

  handleError(String reason) {
    _errorMessage = reason;
  }

  @action
  dispose() {
    patientList.clear();
    _page = 1;
  }
}
