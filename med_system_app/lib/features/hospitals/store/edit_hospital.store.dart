// ignore: library_private_types_in_public_api
import 'package:med_system_app/core/api/network_exceptions.dart';
import 'package:med_system_app/features/hospitals/model/add_hospital_request.model.dart';
import 'package:med_system_app/features/hospitals/model/hospital.model.dart';
import 'package:med_system_app/features/hospitals/respository/hospital_repository.dart';
import 'package:mobx/mobx.dart';

part 'edit_hospital.store.g.dart';

// ignore: library_private_types_in_public_api
class EditHospitalStore = _EditHospitalStoreBase with _$EditHospitalStore;

enum SaveHospitalState { idle, success, error, loading }

abstract class _EditHospitalStoreBase with Store {
  final HospitalRepository _hospitalRepository;

  @observable
  SaveHospitalState saveState = SaveHospitalState.idle;

  _EditHospitalStoreBase(
    this._hospitalRepository,
  );

  @observable
  String _errorMessage = "";

  get errorMessage => _errorMessage;

  @observable
  String _hospitalName = "";

  get hospitalName => _hospitalName;

  @action
  void setNameHospital(String nameHospital) {
    _hospitalName = nameHospital;
  }

  bool validateNameHospital() {
    if (_hospitalName.isEmpty) {
      return false;
    }
    return true;
  }

  @observable
  String _address = "";

  get address => _address;

  @action
  void setAddress(String address) {
    _address = address;
  }

  @action
  void getData(Hospital hospital) {
    setNameHospital(hospital.name ?? "");
    setAddress(hospital.address ?? "");
  }

  bool validateAddress() {
    if (_address.isEmpty) {
      return false;
    }
    return true;
  }

  @computed
  bool get isValidData {
    bool isValid = true;

    if (!validateNameHospital()) {
      isValid = false;
    }
    if (!validateAddress()) {
      isValid = false;
    }
    return isValid;
  }

  @action
  editHospital(int hospitalId) async {
    if (isValidData) {
      saveState = SaveHospitalState.loading;
      var registerHospitalResult = await _hospitalRepository.editHospital(
          hospitalId,
          AddHospitalRequestModel(name: _hospitalName, address: _address));
      registerHospitalResult?.when(success: (patient) {
        saveState = SaveHospitalState.success;
      }, failure: (NetworkExceptions error) {
        handleError(NetworkExceptions.getErrorMessage(error));
        saveState = SaveHospitalState.error;
      });
    }
  }

  handleError(String reason) {
    _errorMessage = reason;
  }

  dispose() {
    _hospitalName = "";
    _address = "";
    saveState = SaveHospitalState.idle;
  }
}
