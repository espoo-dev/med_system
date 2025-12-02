// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_medical_shift.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddMedicalShiftStore on _AddMedicalShiftStoreBase, Store {
  Computed<bool>? _$isValidDataComputed;

  @override
  bool get isValidData =>
      (_$isValidDataComputed ??= Computed<bool>(() => super.isValidData,
              name: '_AddMedicalShiftStoreBase.isValidData'))
          .value;

  late final _$saveStateAtom =
      Atom(name: '_AddMedicalShiftStoreBase.saveState', context: context);

  @override
  SaveMedicalShiftState get saveState {
    _$saveStateAtom.reportRead();
    return super.saveState;
  }

  @override
  set saveState(SaveMedicalShiftState value) {
    _$saveStateAtom.reportWrite(value, super.saveState, () {
      super.saveState = value;
    });
  }

  late final _$medicalShiftStateAtom = Atom(
      name: '_AddMedicalShiftStoreBase.medicalShiftState', context: context);

  @override
  MedicalShiftState get medicalShiftState {
    _$medicalShiftStateAtom.reportRead();
    return super.medicalShiftState;
  }

  @override
  set medicalShiftState(MedicalShiftState value) {
    _$medicalShiftStateAtom.reportWrite(value, super.medicalShiftState, () {
      super.medicalShiftState = value;
    });
  }

  late final _$_errorMessageAtom =
      Atom(name: '_AddMedicalShiftStoreBase._errorMessage', context: context);

  @override
  String get _errorMessage {
    _$_errorMessageAtom.reportRead();
    return super._errorMessage;
  }

  @override
  set _errorMessage(String value) {
    _$_errorMessageAtom.reportWrite(value, super._errorMessage, () {
      super._errorMessage = value;
    });
  }

  late final _$_hospitalNameAtom =
      Atom(name: '_AddMedicalShiftStoreBase._hospitalName', context: context);

  @override
  String get _hospitalName {
    _$_hospitalNameAtom.reportRead();
    return super._hospitalName;
  }

  @override
  set _hospitalName(String value) {
    _$_hospitalNameAtom.reportWrite(value, super._hospitalName, () {
      super._hospitalName = value;
    });
  }

  late final _$_workloadAtom =
      Atom(name: '_AddMedicalShiftStoreBase._workload', context: context);

  @override
  String get _workload {
    _$_workloadAtom.reportRead();
    return super._workload;
  }

  @override
  set _workload(String value) {
    _$_workloadAtom.reportWrite(value, super._workload, () {
      super._workload = value;
    });
  }

  late final _$_startDateAtom =
      Atom(name: '_AddMedicalShiftStoreBase._startDate', context: context);

  @override
  String get _startDate {
    _$_startDateAtom.reportRead();
    return super._startDate;
  }

  @override
  set _startDate(String value) {
    _$_startDateAtom.reportWrite(value, super._startDate, () {
      super._startDate = value;
    });
  }

  late final _$_startHourAtom =
      Atom(name: '_AddMedicalShiftStoreBase._startHour', context: context);

  @override
  String get _startHour {
    _$_startHourAtom.reportRead();
    return super._startHour;
  }

  @override
  set _startHour(String value) {
    _$_startHourAtom.reportWrite(value, super._startHour, () {
      super._startHour = value;
    });
  }

  late final _$_amountCentsAtom =
      Atom(name: '_AddMedicalShiftStoreBase._amountCents', context: context);

  @override
  String get _amountCents {
    _$_amountCentsAtom.reportRead();
    return super._amountCents;
  }

  @override
  set _amountCents(String value) {
    _$_amountCentsAtom.reportWrite(value, super._amountCents, () {
      super._amountCents = value;
    });
  }

  late final _$_paidAtom =
      Atom(name: '_AddMedicalShiftStoreBase._paid', context: context);

  @override
  bool get _paid {
    _$_paidAtom.reportRead();
    return super._paid;
  }

  @override
  set _paid(bool value) {
    _$_paidAtom.reportWrite(value, super._paid, () {
      super._paid = value;
    });
  }

  late final _$_isRecurrentAtom =
      Atom(name: '_AddMedicalShiftStoreBase._isRecurrent', context: context);

  @override
  bool get _isRecurrent {
    _$_isRecurrentAtom.reportRead();
    return super._isRecurrent;
  }

  @override
  set _isRecurrent(bool value) {
    _$_isRecurrentAtom.reportWrite(value, super._isRecurrent, () {
      super._isRecurrent = value;
    });
  }

  late final _$_frequencyAtom =
      Atom(name: '_AddMedicalShiftStoreBase._frequency', context: context);

  @override
  String? get _frequency {
    _$_frequencyAtom.reportRead();
    return super._frequency;
  }

  @override
  set _frequency(String? value) {
    _$_frequencyAtom.reportWrite(value, super._frequency, () {
      super._frequency = value;
    });
  }

  late final _$_dayOfWeekAtom =
      Atom(name: '_AddMedicalShiftStoreBase._dayOfWeek', context: context);

  @override
  int? get _dayOfWeek {
    _$_dayOfWeekAtom.reportRead();
    return super._dayOfWeek;
  }

  @override
  set _dayOfWeek(int? value) {
    _$_dayOfWeekAtom.reportWrite(value, super._dayOfWeek, () {
      super._dayOfWeek = value;
    });
  }

  late final _$_dayOfMonthAtom =
      Atom(name: '_AddMedicalShiftStoreBase._dayOfMonth', context: context);

  @override
  int? get _dayOfMonth {
    _$_dayOfMonthAtom.reportRead();
    return super._dayOfMonth;
  }

  @override
  set _dayOfMonth(int? value) {
    _$_dayOfMonthAtom.reportWrite(value, super._dayOfMonth, () {
      super._dayOfMonth = value;
    });
  }

  late final _$_endDateAtom =
      Atom(name: '_AddMedicalShiftStoreBase._endDate', context: context);

  @override
  String? get _endDate {
    _$_endDateAtom.reportRead();
    return super._endDate;
  }

  @override
  set _endDate(String? value) {
    _$_endDateAtom.reportWrite(value, super._endDate, () {
      super._endDate = value;
    });
  }

  late final _$createMedicalShiftAsyncAction = AsyncAction(
      '_AddMedicalShiftStoreBase.createMedicalShift',
      context: context);

  @override
  Future createMedicalShift() {
    return _$createMedicalShiftAsyncAction
        .run(() => super.createMedicalShift());
  }

  late final _$_createRecurrenceAsyncAction = AsyncAction(
      '_AddMedicalShiftStoreBase._createRecurrence',
      context: context);

  @override
  Future<void> _createRecurrence() {
    return _$_createRecurrenceAsyncAction.run(() => super._createRecurrence());
  }

  late final _$fetchAllDataAsyncAction =
      AsyncAction('_AddMedicalShiftStoreBase.fetchAllData', context: context);

  @override
  Future fetchAllData() {
    return _$fetchAllDataAsyncAction.run(() => super.fetchAllData());
  }

  late final _$getHospitalNameSuggestionsAsyncAction = AsyncAction(
      '_AddMedicalShiftStoreBase.getHospitalNameSuggestions',
      context: context);

  @override
  Future<dynamic> getHospitalNameSuggestions() {
    return _$getHospitalNameSuggestionsAsyncAction
        .run(() => super.getHospitalNameSuggestions());
  }

  late final _$getAmountSuggestionsAsyncAction = AsyncAction(
      '_AddMedicalShiftStoreBase.getAmountSuggestions',
      context: context);

  @override
  Future<dynamic> getAmountSuggestions() {
    return _$getAmountSuggestionsAsyncAction
        .run(() => super.getAmountSuggestions());
  }

  late final _$_AddMedicalShiftStoreBaseActionController =
      ActionController(name: '_AddMedicalShiftStoreBase', context: context);

  @override
  void setHospitalName(String hospitalName) {
    final _$actionInfo = _$_AddMedicalShiftStoreBaseActionController
        .startAction(name: '_AddMedicalShiftStoreBase.setHospitalName');
    try {
      return super.setHospitalName(hospitalName);
    } finally {
      _$_AddMedicalShiftStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setWorkload(String workload) {
    final _$actionInfo = _$_AddMedicalShiftStoreBaseActionController
        .startAction(name: '_AddMedicalShiftStoreBase.setWorkload');
    try {
      return super.setWorkload(workload);
    } finally {
      _$_AddMedicalShiftStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStartDate(String startDate) {
    final _$actionInfo = _$_AddMedicalShiftStoreBaseActionController
        .startAction(name: '_AddMedicalShiftStoreBase.setStartDate');
    try {
      return super.setStartDate(startDate);
    } finally {
      _$_AddMedicalShiftStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStartHour(String startHour) {
    final _$actionInfo = _$_AddMedicalShiftStoreBaseActionController
        .startAction(name: '_AddMedicalShiftStoreBase.setStartHour');
    try {
      return super.setStartHour(startHour);
    } finally {
      _$_AddMedicalShiftStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAmountCents(String amountCents) {
    final _$actionInfo = _$_AddMedicalShiftStoreBaseActionController
        .startAction(name: '_AddMedicalShiftStoreBase.setAmountCents');
    try {
      return super.setAmountCents(amountCents);
    } finally {
      _$_AddMedicalShiftStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setpaid(bool paid) {
    final _$actionInfo = _$_AddMedicalShiftStoreBaseActionController
        .startAction(name: '_AddMedicalShiftStoreBase.setpaid');
    try {
      return super.setpaid(paid);
    } finally {
      _$_AddMedicalShiftStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsRecurrent(bool isRecurrent) {
    final _$actionInfo = _$_AddMedicalShiftStoreBaseActionController
        .startAction(name: '_AddMedicalShiftStoreBase.setIsRecurrent');
    try {
      return super.setIsRecurrent(isRecurrent);
    } finally {
      _$_AddMedicalShiftStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFrequency(String? frequency) {
    final _$actionInfo = _$_AddMedicalShiftStoreBaseActionController
        .startAction(name: '_AddMedicalShiftStoreBase.setFrequency');
    try {
      return super.setFrequency(frequency);
    } finally {
      _$_AddMedicalShiftStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDayOfWeek(int? dayOfWeek) {
    final _$actionInfo = _$_AddMedicalShiftStoreBaseActionController
        .startAction(name: '_AddMedicalShiftStoreBase.setDayOfWeek');
    try {
      return super.setDayOfWeek(dayOfWeek);
    } finally {
      _$_AddMedicalShiftStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDayOfMonth(int? dayOfMonth) {
    final _$actionInfo = _$_AddMedicalShiftStoreBaseActionController
        .startAction(name: '_AddMedicalShiftStoreBase.setDayOfMonth');
    try {
      return super.setDayOfMonth(dayOfMonth);
    } finally {
      _$_AddMedicalShiftStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEndDate(String? endDate) {
    final _$actionInfo = _$_AddMedicalShiftStoreBaseActionController
        .startAction(name: '_AddMedicalShiftStoreBase.setEndDate');
    try {
      return super.setEndDate(endDate);
    } finally {
      _$_AddMedicalShiftStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
saveState: ${saveState},
medicalShiftState: ${medicalShiftState},
isValidData: ${isValidData}
    ''';
  }
}
