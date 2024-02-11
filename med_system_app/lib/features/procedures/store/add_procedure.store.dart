// ignore: library_private_types_in_public_api

import 'package:med_system_app/core/api/network_exceptions.dart';
import 'package:med_system_app/features/procedures/model/add_procedure.model.dart';
import 'package:med_system_app/features/procedures/repository/procedure_repository.dart';
import 'package:mobx/mobx.dart';

part 'add_procedure.store.g.dart';

// ignore: library_private_types_in_public_api
class AddProcedureStore = _AddProcedureStoreBase with _$AddProcedureStore;

enum SaveProcedureState { idle, success, error, loading }

abstract class _AddProcedureStoreBase with Store {
  final ProcedureRepository _procedureRepository;

  @observable
  SaveProcedureState saveState = SaveProcedureState.idle;

  _AddProcedureStoreBase(
    this._procedureRepository,
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

  @observable
  String _code = "";
  get code => _code;
  @action
  void setCode(String code) {
    _code = code;
  }

  @observable
  String _description = "";
  get description => _description;
  @action
  void setDescription(String description) {
    _description = description;
  }

  @observable
  String _amountCents = "";
  get amountCents => _amountCents;
  @action
  void setAmountCents(String amountCents) {
    _amountCents = amountCents;
  }

  bool validateName() {
    if (_name.isEmpty) {
      return false;
    }
    return true;
  }

  bool validateCode() {
    if (_code.isEmpty) {
      return false;
    }
    return true;
  }

  bool validateDescription() {
    if (_description.isEmpty) {
      return false;
    }
    return true;
  }

  bool validateAmountCents() {
    if (_amountCents.isEmpty) {
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
    if (!validateCode()) {
      isValid = false;
    }
    if (!validateDescription()) {
      isValid = false;
    }
    if (!validateAmountCents()) {
      isValid = false;
    }
    return isValid;
  }

  @action
  createProcedure() async {
    if (isValidData) {
      saveState = SaveProcedureState.loading;
      var registerPatientResult = await _procedureRepository.registerProcedure(
          AddProcedureRequestModel(
              name: _name,
              code: _code,
              description: _description,
              amountCents: parseReal(_amountCents)));
      registerPatientResult?.when(success: (patient) {
        saveState = SaveProcedureState.success;
      }, failure: (NetworkExceptions error) {
        handleError(NetworkExceptions.getErrorMessage(error));
        saveState = SaveProcedureState.error;
      });
    }
  }

  handleError(String reason) {
    _errorMessage = reason;
  }

  dispose() {
    _name = "";
    _code = "";
    _description = "";
    _amountCents = "";
    saveState = SaveProcedureState.idle;
  }

  int parseReal(String text) {
    String cleanedText = text.replaceAll(RegExp('[^0-9]'), '');
    int value = int.tryParse(cleanedText) ?? 0;

    return value;
  }
}
