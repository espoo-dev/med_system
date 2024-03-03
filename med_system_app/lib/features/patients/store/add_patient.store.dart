// ignore: library_private_types_in_public_api
import 'package:distrito_medico/core/api/network_exceptions.dart';
import 'package:distrito_medico/features/patients/model/add_patient_request.model.dart';
import 'package:distrito_medico/features/patients/repository/patient_repository.dart';
import 'package:mobx/mobx.dart';

part 'add_patient.store.g.dart';

// ignore: library_private_types_in_public_api
class AddPatientStore = _AddPatientStoreBase with _$AddPatientStore;

enum SavePatientState { idle, success, error, loading }

abstract class _AddPatientStoreBase with Store {
  final PatientRepository _patientRepository;

  @observable
  SavePatientState saveState = SavePatientState.idle;

  _AddPatientStoreBase(
    this._patientRepository,
  );

  @observable
  String _errorMessage = "";
  get errorMessage => _errorMessage;

  @observable
  String _patientName = "";
  get patientName => _patientName;
  @action
  void setNamePatient(String namePatient) {
    _patientName = namePatient;
  }

  bool validateNamePatient() {
    if (_patientName.isEmpty) {
      return false;
    }
    return true;
  }

  @computed
  bool get isValidData {
    bool isValid = true;

    if (!validateNamePatient()) {
      isValid = false;
    }
    return isValid;
  }

  @action
  createPatient() async {
    if (isValidData) {
      saveState = SavePatientState.loading;
      var registerPatientResult =
          await _patientRepository.registerPatient(AddPatientRequestModel(
        name: _patientName,
      ));
      registerPatientResult?.when(success: (patient) {
        saveState = SavePatientState.success;
      }, failure: (NetworkExceptions error) {
        handleError(NetworkExceptions.getErrorMessage(error));
        saveState = SavePatientState.error;
      });
    }
  }

  handleError(String reason) {
    _errorMessage = reason;
  }

  dispose() {
    _patientName = "";
    saveState = SavePatientState.idle;
  }
}
