import 'package:med_system_app/core/api/network_exceptions.dart';
import 'package:med_system_app/features/patients/model/patient.model.dart';
import 'package:med_system_app/features/patients/repository/patient_repository.dart';
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

  _PatientStoreBase(PatientRepository patientRepository)
      : _patientRepository = patientRepository;

  @action
  getAllPatients() async {
    patientList.clear();
    state = PatientState.loading;
    var resultPatient =
        await _patientRepository.getAllPatients().asObservable();
    resultPatient?.when(success: (List<Patient>? listPatient) {
      patientList.addAll(listPatient!);
      state = PatientState.success;
    }, failure: (NetworkExceptions error) {
      handleError(NetworkExceptions.getErrorMessage(error));
      state = PatientState.error;
    });
  }

  handleError(String reason) {
    _errorMessage = reason;
  }

  dispose() {
    patientList.clear();
  }
}
