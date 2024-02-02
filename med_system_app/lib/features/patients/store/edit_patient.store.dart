// ignore: library_private_types_in_public_api
import 'package:med_system_app/core/api/network_exceptions.dart';
import 'package:med_system_app/features/patients/model/add_patient_request.model.dart';
import 'package:med_system_app/features/patients/repository/patient_repository.dart';
import 'package:mobx/mobx.dart';

part 'edit_patient.store.g.dart';

// ignore: library_private_types_in_public_api
class EditPatientStore = _EditPatientStoreBase with _$EditPatientStore;

enum SavePatientState { idle, success, error, loading }

abstract class _EditPatientStoreBase with Store {
  final PatientRepository _patientRepository;

  @observable
  SavePatientState saveState = SavePatientState.idle;

  _EditPatientStoreBase(
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
  editPatient(int patientId) async {
    if (isValidData) {
      saveState = SavePatientState.loading;
      var registerPatientResult = await _patientRepository.editPatient(
          patientId,
          AddPatientRequestModel(
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
