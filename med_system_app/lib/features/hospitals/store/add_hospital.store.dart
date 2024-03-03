// ignore: library_private_types_in_public_api
import 'package:distrito_medico/core/api/network_exceptions.dart';
import 'package:distrito_medico/features/hospitals/model/add_hospital_request.model.dart';
import 'package:distrito_medico/features/hospitals/respository/hospital_repository.dart';
import 'package:mobx/mobx.dart';

part 'add_hospital.store.g.dart';

// ignore: library_private_types_in_public_api
class AddHospitalStore = _AddHospitalStoreBase with _$AddHospitalStore;

enum SaveHospitalState { idle, success, error, loading }

abstract class _AddHospitalStoreBase with Store {
  final HospitalRepository _hospitalRepository;

  @observable
  SaveHospitalState saveState = SaveHospitalState.idle;

  _AddHospitalStoreBase(
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
  createHospital() async {
    if (isValidData) {
      saveState = SaveHospitalState.loading;
      var registerHospitalResult = await _hospitalRepository.registerHospital(
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
