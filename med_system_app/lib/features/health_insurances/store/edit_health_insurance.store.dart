// ignore: library_private_types_in_public_api
import 'package:distrito_medico/core/api/network_exceptions.dart';
import 'package:distrito_medico/features/health_insurances/model/add_health_insurances_request.model.dart';
import 'package:distrito_medico/features/health_insurances/repository/health_insurances_repository.dart';
import 'package:mobx/mobx.dart';

part 'edit_health_insurance.store.g.dart';

// ignore: library_private_types_in_public_api
class EditHealthInsuranceStore = _EditHealthInsuranceStoreBase
    with _$EditHealthInsuranceStore;

enum SaveHealthInsurancetState { idle, success, error, loading }

abstract class _EditHealthInsuranceStoreBase with Store {
  final HealthInsurancesRepository _healthInsurancesRepository;

  @observable
  SaveHealthInsurancetState saveState = SaveHealthInsurancetState.idle;

  _EditHealthInsuranceStoreBase(
    this._healthInsurancesRepository,
  );

  @observable
  String _errorMessage = "";
  get errorMessage => _errorMessage;

  @observable
  String _name = "";
  get name => _name;
  @action
  void setName(String name) {
    _name = name;
  }

  bool validateName() {
    if (_name.isEmpty) {
      return false;
    }
    return true;
  }

  @computed
  bool get isValidData {
    bool isValid = true;

    if (!validateName()) {
      isValid = false;
    }
    return isValid;
  }

  @action
  editHealthInsurance(int healthInsuranceId) async {
    if (isValidData) {
      saveState = SaveHealthInsurancetState.loading;
      var result = await _healthInsurancesRepository.editHealthInsurance(
          healthInsuranceId,
          AddHealthInsurancesRequestModel(
            name: _name,
          ));
      result?.when(success: (healthInsurance) {
        saveState = SaveHealthInsurancetState.success;
      }, failure: (NetworkExceptions error) {
        handleError(NetworkExceptions.getErrorMessage(error));
        saveState = SaveHealthInsurancetState.error;
      });
    }
  }

  handleError(String reason) {
    _errorMessage = reason;
  }

  dispose() {
    _name = "";
    saveState = SaveHealthInsurancetState.idle;
  }
}
