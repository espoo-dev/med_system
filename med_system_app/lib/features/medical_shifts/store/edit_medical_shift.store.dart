// ignore: library_private_types_in_public_api

import 'package:distrito_medico/core/api/network_exceptions.dart';
import 'package:distrito_medico/features/medical_shifts/model/add_medical_shift.model.dart';
import 'package:distrito_medico/features/medical_shifts/model/medical_shift.model.dart';
import 'package:distrito_medico/features/medical_shifts/repository/medical_shift_repository.dart';
import 'package:mobx/mobx.dart';

part 'edit_medical_shift.store.g.dart';

// ignore: library_private_types_in_public_api
class EditMedicalShiftStore = _EditMedicalShiftStoreBase
    with _$EditMedicalShiftStore;

enum EditMedicalShiftState { idle, success, error, loading }

enum MedicalShiftState { idle, success, error, loading }

abstract class _EditMedicalShiftStoreBase with Store {
  final MedicalShiftRepository _medicalShiftRepository;

  @observable
  EditMedicalShiftState saveState = EditMedicalShiftState.idle;

  @observable
  MedicalShiftState medicalShiftState = MedicalShiftState.idle;

  _EditMedicalShiftStoreBase(this._medicalShiftRepository);

  ObservableList<String> hospitalNameSuggestions = ObservableList<String>();
  ObservableList<String> amountSuggestions = ObservableList<String>();

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
  bool _paid = false;
  get paid => _paid;
  @action
  void setpaid(bool paid) {
    _paid = paid;
  }

  @observable
  String? _color;
  get color => _color;
  @action
  void setColor(String? color) {
    _color = color;
  }

  @action
  void initializeWithShift(MedicalShiftModel shift) {
    _hospitalName = shift.hospitalName ?? "";
    _workload = parseWorkload(shift.workload ?? "");
    _startDate = shift.date ?? "";
    _startHour = shift.hour ?? "";
    _amountCents = shift.amountCents?.toString() ?? "";
    _paid = shift.paid ?? false;
    _color = shift.color;
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
  updateMedicalShift(int medicalShiftId) async {
    if (isValidData) {
      saveState = EditMedicalShiftState.loading;
      var updateShiftResult = await _medicalShiftRepository.editMedicalShift(
        medicalShiftId,
        AddMedicalShiftRequestModel(
          hospitalName: _hospitalName,
          workload: _workload,
          startDate: _startDate,
          startHour: _startHour,
          amountCents: parseReal(_amountCents),
          paid: _paid,
          color: _color,
        ),
      );

      updateShiftResult?.when(success: (shift) {
        saveState = EditMedicalShiftState.success;
      }, failure: (NetworkExceptions error) {
        handleError(NetworkExceptions.getErrorMessage(error));
        saveState = EditMedicalShiftState.error;
      });
    }
  }

  @action
  fetchAllData() async {
    try {
      medicalShiftState = MedicalShiftState.loading;

      await Future.wait([getHospitalNameSuggestions(), getAmountSuggestions()]);

      medicalShiftState = MedicalShiftState.success;
    } catch (error) {
      medicalShiftState = MedicalShiftState.error;
      handleError(error.toString());
    }
  }

  @action
  Future getHospitalNameSuggestions() async {
    hospitalNameSuggestions.clear();
    var resultProcedures = await _medicalShiftRepository
        .getHospitalNameSuggestions()
        .asObservable();
    resultProcedures?.when(success: (List<String>? listNames) {
      hospitalNameSuggestions.addAll(listNames!);
    }, failure: (NetworkExceptions error) {
      handleError(NetworkExceptions.getErrorMessage(error));
    });
  }

  @action
  Future getAmountSuggestions() async {
    amountSuggestions.clear();
    var resultProcedures =
        await _medicalShiftRepository.getAmountSuggestions().asObservable();
    resultProcedures?.when(success: (List<String>? listNames) {
      amountSuggestions.addAll(listNames!);
    }, failure: (NetworkExceptions error) {
      handleError(NetworkExceptions.getErrorMessage(error));
    });
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
    _paid = false;
    _color = null;
    saveState = EditMedicalShiftState.idle;
  }

  String parseWorkload(String workload) {
    switch (workload) {
      case '6h':
        return 'six';
      case '12h':
        return 'twelve';
      case '24h':
        return 'twenty_four';
      default:
        return 'six';
    }
  }

  int parseReal(String text) {
    String cleanedText = text.replaceAll(RegExp('[^0-9]'), '');
    int value = int.tryParse(cleanedText) ?? 0;
    return value;
  }
}
