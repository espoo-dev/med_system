// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_medical_shift.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EditMedicalShiftStore on _EditMedicalShiftStoreBase, Store {
  Computed<bool>? _$isValidDataComputed;

  @override
  bool get isValidData =>
      (_$isValidDataComputed ??= Computed<bool>(() => super.isValidData,
              name: '_EditMedicalShiftStoreBase.isValidData'))
          .value;

  late final _$saveStateAtom =
      Atom(name: '_EditMedicalShiftStoreBase.saveState', context: context);

  @override
  EditMedicalShiftState get saveState {
    _$saveStateAtom.reportRead();
    return super.saveState;
  }

  @override
  set saveState(EditMedicalShiftState value) {
    _$saveStateAtom.reportWrite(value, super.saveState, () {
      super.saveState = value;
    });
  }

  late final _$medicalShiftStateAtom = Atom(
      name: '_EditMedicalShiftStoreBase.medicalShiftState', context: context);

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
      Atom(name: '_EditMedicalShiftStoreBase._errorMessage', context: context);

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
      Atom(name: '_EditMedicalShiftStoreBase._hospitalName', context: context);

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
      Atom(name: '_EditMedicalShiftStoreBase._workload', context: context);

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
      Atom(name: '_EditMedicalShiftStoreBase._startDate', context: context);

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
      Atom(name: '_EditMedicalShiftStoreBase._startHour', context: context);

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
      Atom(name: '_EditMedicalShiftStoreBase._amountCents', context: context);

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

  late final _$_paydAtom =
      Atom(name: '_EditMedicalShiftStoreBase._payd', context: context);

  @override
  bool get _payd {
    _$_paydAtom.reportRead();
    return super._payd;
  }

  @override
  set _payd(bool value) {
    _$_paydAtom.reportWrite(value, super._payd, () {
      super._payd = value;
    });
  }

  late final _$updateMedicalShiftAsyncAction = AsyncAction(
      '_EditMedicalShiftStoreBase.updateMedicalShift',
      context: context);

  @override
  Future updateMedicalShift(int medicalShiftId) {
    return _$updateMedicalShiftAsyncAction
        .run(() => super.updateMedicalShift(medicalShiftId));
  }

  late final _$fetchAllDataAsyncAction =
      AsyncAction('_EditMedicalShiftStoreBase.fetchAllData', context: context);

  @override
  Future fetchAllData() {
    return _$fetchAllDataAsyncAction.run(() => super.fetchAllData());
  }

  late final _$getHospitalNameSuggestionsAsyncAction = AsyncAction(
      '_EditMedicalShiftStoreBase.getHospitalNameSuggestions',
      context: context);

  @override
  Future<dynamic> getHospitalNameSuggestions() {
    return _$getHospitalNameSuggestionsAsyncAction
        .run(() => super.getHospitalNameSuggestions());
  }

  late final _$getAmountSuggestionsAsyncAction = AsyncAction(
      '_EditMedicalShiftStoreBase.getAmountSuggestions',
      context: context);

  @override
  Future<dynamic> getAmountSuggestions() {
    return _$getAmountSuggestionsAsyncAction
        .run(() => super.getAmountSuggestions());
  }

  late final _$_EditMedicalShiftStoreBaseActionController =
      ActionController(name: '_EditMedicalShiftStoreBase', context: context);

  @override
  void setHospitalName(String hospitalName) {
    final _$actionInfo = _$_EditMedicalShiftStoreBaseActionController
        .startAction(name: '_EditMedicalShiftStoreBase.setHospitalName');
    try {
      return super.setHospitalName(hospitalName);
    } finally {
      _$_EditMedicalShiftStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setWorkload(String workload) {
    final _$actionInfo = _$_EditMedicalShiftStoreBaseActionController
        .startAction(name: '_EditMedicalShiftStoreBase.setWorkload');
    try {
      return super.setWorkload(workload);
    } finally {
      _$_EditMedicalShiftStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStartDate(String startDate) {
    final _$actionInfo = _$_EditMedicalShiftStoreBaseActionController
        .startAction(name: '_EditMedicalShiftStoreBase.setStartDate');
    try {
      return super.setStartDate(startDate);
    } finally {
      _$_EditMedicalShiftStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStartHour(String startHour) {
    final _$actionInfo = _$_EditMedicalShiftStoreBaseActionController
        .startAction(name: '_EditMedicalShiftStoreBase.setStartHour');
    try {
      return super.setStartHour(startHour);
    } finally {
      _$_EditMedicalShiftStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAmountCents(String amountCents) {
    final _$actionInfo = _$_EditMedicalShiftStoreBaseActionController
        .startAction(name: '_EditMedicalShiftStoreBase.setAmountCents');
    try {
      return super.setAmountCents(amountCents);
    } finally {
      _$_EditMedicalShiftStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPayd(bool payd) {
    final _$actionInfo = _$_EditMedicalShiftStoreBaseActionController
        .startAction(name: '_EditMedicalShiftStoreBase.setPayd');
    try {
      return super.setPayd(payd);
    } finally {
      _$_EditMedicalShiftStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void initializeWithShift(MedicalShiftModel shift) {
    final _$actionInfo = _$_EditMedicalShiftStoreBaseActionController
        .startAction(name: '_EditMedicalShiftStoreBase.initializeWithShift');
    try {
      return super.initializeWithShift(shift);
    } finally {
      _$_EditMedicalShiftStoreBaseActionController.endAction(_$actionInfo);
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
