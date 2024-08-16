// ignore: library_private_types_in_public_api

import 'package:distrito_medico/core/api/network_exceptions.dart';
import 'package:distrito_medico/features/medical_shifts/model/add_medical_shift.model.dart';
import 'package:distrito_medico/features/medical_shifts/repository/medical_shift_repository.dart';
import 'package:mobx/mobx.dart';

part 'add_medical_shift.store.g.dart';

// ignore: library_private_types_in_public_api
class AddMedicalShiftStore = _AddMedicalShiftStoreBase
    with _$AddMedicalShiftStore;

enum SaveMedicalShiftState { idle, success, error, loading }

abstract class _AddMedicalShiftStoreBase with Store {
  final MedicalShiftRepository _medicalShiftRepository;

  @observable
  SaveMedicalShiftState saveState = SaveMedicalShiftState.idle;

  _AddMedicalShiftStoreBase(this._medicalShiftRepository);

  @observable
  String _errorMessage = "";
  get errorMessage => _errorMessage;

  @observable
  String _hospitalName = "";
  get hospitalName => _hospitalName;
  @action
  void setHospitalName(String hospitalName) {
    _hospitalName = hospitalName;
  }

  @observable
  String _workload = "six";
  get workload => _workload;
  @action
  void setWorkload(String workload) {
    if (workload == 'six' ||
        workload == 'twelve' ||
        workload == 'twenty_four') {
      _workload = workload;
    } else {
      _workload = 'six';
    }
  }

  @observable
  String _startDate = "";
  get startDate => _startDate;
  @action
  void setStartDate(String startDate) {
    _startDate = startDate;
  }

  @observable
  String _startHour = "";
  get startHour => _startHour;
  @action
  void setStartHour(String startHour) {
    _startHour = startHour;
  }

  @observable
  String _amountCents = "";
  get amountCents => _amountCents;
  @action
  void setAmountCents(String amountCents) {
    _amountCents = amountCents;
  }

  @observable
  bool _payd = false;
  get payd => _payd;
  @action
  void setPayd(bool payd) {
    _payd = payd;
  }

  bool validateHospitalName() {
    return _hospitalName.isNotEmpty;
  }

  bool validateWorkload() {
    return _workload.isNotEmpty;
  }

  bool validateStartDate() {
    return _startDate.isNotEmpty;
  }

  bool validateStartHour() {
    return _startHour.isNotEmpty;
  }

  bool validateAmountCents() {
    return _amountCents.isNotEmpty;
  }

  @computed
  bool get isValidData {
    return validateHospitalName() &&
        validateWorkload() &&
        validateStartDate() &&
        validateStartHour() &&
        validateAmountCents();
  }

  @action
  createMedicalShift() async {
    if (isValidData) {
      saveState = SaveMedicalShiftState.loading;
      var registerShiftResult =
          await _medicalShiftRepository.registerMedicalShift(
        AddMedicalShiftRequestModel(
          hospitalName: _hospitalName,
          workload: _workload,
          startDate: _startDate,
          startHour: _startHour,
          amountCents: parseReal(_amountCents),
          payd: _payd,
        ),
      );

      registerShiftResult?.when(success: (shift) {
        saveState = SaveMedicalShiftState.success;
      }, failure: (NetworkExceptions error) {
        handleError(NetworkExceptions.getErrorMessage(error));
        saveState = SaveMedicalShiftState.error;
      });
    }
  }

  handleError(String reason) {
    _errorMessage = reason;
  }

  dispose() {
    _hospitalName = "";
    _workload = "";
    _startDate = "";
    _startHour = "";
    _amountCents = "";
    _payd = false;
    saveState = SaveMedicalShiftState.idle;
  }

  int parseReal(String text) {
    String cleanedText = text.replaceAll(RegExp('[^0-9]'), '');
    int value = int.tryParse(cleanedText) ?? 0;
    return value;
  }
}
