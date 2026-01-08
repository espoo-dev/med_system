// ignore: library_private_types_in_public_api

import 'package:distrito_medico/core/api/network_exceptions.dart';
import 'package:distrito_medico/features/medical_shifts/model/add_medical_shift.model.dart';
import 'package:distrito_medico/features/medical_shifts/repository/medical_shift_repository.dart';
import 'package:distrito_medico/features/medical_shift_recurrences/model/medical_shift_recurrence.model.dart';
import 'package:distrito_medico/features/medical_shift_recurrences/repository/medical_shift_recurrence_repository.dart';
import 'package:mobx/mobx.dart';

part 'add_medical_shift.store.g.dart';

// ignore: library_private_types_in_public_api
class AddMedicalShiftStore = _AddMedicalShiftStoreBase
    with _$AddMedicalShiftStore;

enum SaveMedicalShiftState { idle, success, error, loading }

enum MedicalShiftState { idle, success, error, loading }

abstract class _AddMedicalShiftStoreBase with Store {
  final MedicalShiftRepository _medicalShiftRepository;
  final MedicalShiftRecurrenceRepository _recurrenceRepository =
      MedicalShiftRecurrenceRepository();

  @observable
  SaveMedicalShiftState saveState = SaveMedicalShiftState.idle;

  @observable
  MedicalShiftState medicalShiftState = MedicalShiftState.idle;

  _AddMedicalShiftStoreBase(this._medicalShiftRepository);

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

  // Recurrence fields
  @observable
  bool _isRecurrent = false;
  get isRecurrent => _isRecurrent;
  @action
  void setIsRecurrent(bool isRecurrent) {
    _isRecurrent = isRecurrent;
    // Reset recurrence fields when disabled
    if (!isRecurrent) {
      _frequency = null;
      _dayOfWeek = null;
      _dayOfMonth = null;
      _endDate = null;
    }
  }

  @observable
  String? _frequency;
  get frequency => _frequency;
  @action
  void setFrequency(String? frequency) {
    _frequency = frequency;
    // Reset day fields when frequency changes
    if (frequency != 'monthly_fixed_day') {
      _dayOfMonth = null;
    }
    if (frequency == 'monthly_fixed_day') {
      _dayOfWeek = null;
    }
  }

  @observable
  int? _dayOfWeek;
  get dayOfWeek => _dayOfWeek;
  @action
  void setDayOfWeek(int? dayOfWeek) {
    _dayOfWeek = dayOfWeek;
  }

  @observable
  int? _dayOfMonth;
  get dayOfMonth => _dayOfMonth;
  @action
  void setDayOfMonth(int? dayOfMonth) {
    _dayOfMonth = dayOfMonth;
  }

  @observable
  String? _endDate;
  get endDate => _endDate;
  @action
  void setEndDate(String? endDate) {
    _endDate = endDate;
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
          paid: _paid,
          color: _color,
        ),
      );

      registerShiftResult?.when(success: (shift) async {
        // If recurrence is enabled, create the recurrence
        if (_isRecurrent && _frequency != null) {
          await _createRecurrence();
        }
        saveState = SaveMedicalShiftState.success;
      }, failure: (NetworkExceptions error) {
        handleError(NetworkExceptions.getErrorMessage(error));
        saveState = SaveMedicalShiftState.error;
      });
    }
  }

  @action
  Future<void> _createRecurrence() async {
    try {
      final recurrenceModel = MedicalShiftRecurrenceModel(
        frequency: _frequency,
        dayOfWeek: _dayOfWeek,
        dayOfMonth: _dayOfMonth,
        endDate: _endDate,
        workload: _workload,
        startDate: _startDate,
        amountCents: parseReal(_amountCents),
        hospitalName: _hospitalName,
        startHour: _startHour,
        color: _color,
      );

      await _recurrenceRepository.createMedicalShiftRecurrence(recurrenceModel);
    } catch (e) {
      // Log error but don't fail the shift creation
      handleError('Erro ao criar recorrência: ${e.toString()}');
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
    _workload = "six";
    _startDate = "";
    _startHour = "";
    _amountCents = "";
    _paid = false;
    _color = null;
    _isRecurrent = false;
    _frequency = null;
    _dayOfWeek = null;
    _dayOfMonth = null;
    _endDate = null;
    saveState = SaveMedicalShiftState.idle;
  }

  int parseReal(String text) {
    String cleanedText = text.replaceAll(RegExp('[^0-9]'), '');
    int value = int.tryParse(cleanedText) ?? 0;
    return value;
  }
}
