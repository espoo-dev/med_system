// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_event_procedure.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EditEventProcedureStore on _EditEventProcedureStoreBase, Store {
  Computed<bool>? _$isValidDataComputed;

  @override
  bool get isValidData =>
      (_$isValidDataComputed ??= Computed<bool>(() => super.isValidData,
              name: '_EditEventProcedureStoreBase.isValidData'))
          .value;

  late final _$stateAtom =
      Atom(name: '_EditEventProcedureStoreBase.state', context: context);

  @override
  EditEventProcedureState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(EditEventProcedureState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$saveStateAtom =
      Atom(name: '_EditEventProcedureStoreBase.saveState', context: context);

  @override
  SaveEventProcedureState get saveState {
    _$saveStateAtom.reportRead();
    return super.saveState;
  }

  @override
  set saveState(SaveEventProcedureState value) {
    _$saveStateAtom.reportWrite(value, super.saveState, () {
      super.saveState = value;
    });
  }

  late final _$_errorMessageAtom = Atom(
      name: '_EditEventProcedureStoreBase._errorMessage', context: context);

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

  late final _$_patientIdAtom =
      Atom(name: '_EditEventProcedureStoreBase._patientId', context: context);

  @override
  int get _patientId {
    _$_patientIdAtom.reportRead();
    return super._patientId;
  }

  @override
  set _patientId(int value) {
    _$_patientIdAtom.reportWrite(value, super._patientId, () {
      super._patientId = value;
    });
  }

  late final _$_procedureIdAtom =
      Atom(name: '_EditEventProcedureStoreBase._procedureId', context: context);

  @override
  int get _procedureId {
    _$_procedureIdAtom.reportRead();
    return super._procedureId;
  }

  @override
  set _procedureId(int value) {
    _$_procedureIdAtom.reportWrite(value, super._procedureId, () {
      super._procedureId = value;
    });
  }

  late final _$_hospitalIdAtom =
      Atom(name: '_EditEventProcedureStoreBase._hospitalId', context: context);

  @override
  int get _hospitalId {
    _$_hospitalIdAtom.reportRead();
    return super._hospitalId;
  }

  @override
  set _hospitalId(int value) {
    _$_hospitalIdAtom.reportWrite(value, super._hospitalId, () {
      super._hospitalId = value;
    });
  }

  late final _$_healthInsuranceIdAtom = Atom(
      name: '_EditEventProcedureStoreBase._healthInsuranceId',
      context: context);

  @override
  int get _healthInsuranceId {
    _$_healthInsuranceIdAtom.reportRead();
    return super._healthInsuranceId;
  }

  @override
  set _healthInsuranceId(int value) {
    _$_healthInsuranceIdAtom.reportWrite(value, super._healthInsuranceId, () {
      super._healthInsuranceId = value;
    });
  }

  late final _$_patientServiceNumberAtom = Atom(
      name: '_EditEventProcedureStoreBase._patientServiceNumber',
      context: context);

  @override
  String get _patientServiceNumber {
    _$_patientServiceNumberAtom.reportRead();
    return super._patientServiceNumber;
  }

  @override
  set _patientServiceNumber(String value) {
    _$_patientServiceNumberAtom.reportWrite(value, super._patientServiceNumber,
        () {
      super._patientServiceNumber = value;
    });
  }

  late final _$_accommodationAtom = Atom(
      name: '_EditEventProcedureStoreBase._accommodation', context: context);

  @override
  String get _accommodation {
    _$_accommodationAtom.reportRead();
    return super._accommodation;
  }

  @override
  set _accommodation(String value) {
    _$_accommodationAtom.reportWrite(value, super._accommodation, () {
      super._accommodation = value;
    });
  }

  late final _$_urgencyAtom =
      Atom(name: '_EditEventProcedureStoreBase._urgency', context: context);

  @override
  bool get _urgency {
    _$_urgencyAtom.reportRead();
    return super._urgency;
  }

  @override
  set _urgency(bool value) {
    _$_urgencyAtom.reportWrite(value, super._urgency, () {
      super._urgency = value;
    });
  }

  late final _$_createdDateAtom =
      Atom(name: '_EditEventProcedureStoreBase._createdDate', context: context);

  @override
  String get _createdDate {
    _$_createdDateAtom.reportRead();
    return super._createdDate;
  }

  @override
  set _createdDate(String value) {
    _$_createdDateAtom.reportWrite(value, super._createdDate, () {
      super._createdDate = value;
    });
  }

  late final _$_paydAtAtom =
      Atom(name: '_EditEventProcedureStoreBase._paydAt', context: context);

  @override
  String get _paydAt {
    _$_paydAtAtom.reportRead();
    return super._paydAt;
  }

  @override
  set _paydAt(String value) {
    _$_paydAtAtom.reportWrite(value, super._paydAt, () {
      super._paydAt = value;
    });
  }

  late final _$_patientAtom =
      Atom(name: '_EditEventProcedureStoreBase._patient', context: context);

  @override
  Patient? get _patient {
    _$_patientAtom.reportRead();
    return super._patient;
  }

  @override
  set _patient(Patient? value) {
    _$_patientAtom.reportWrite(value, super._patient, () {
      super._patient = value;
    });
  }

  late final _$editEventProcedureAsyncAction = AsyncAction(
      '_EditEventProcedureStoreBase.editEventProcedure',
      context: context);

  @override
  Future editEventProcedure(int eventProcedureId) {
    return _$editEventProcedureAsyncAction
        .run(() => super.editEventProcedure(eventProcedureId));
  }

  late final _$fetchAllDataAsyncAction = AsyncAction(
      '_EditEventProcedureStoreBase.fetchAllData',
      context: context);

  @override
  Future fetchAllData() {
    return _$fetchAllDataAsyncAction.run(() => super.fetchAllData());
  }

  late final _$getAllProceduresAsyncAction = AsyncAction(
      '_EditEventProcedureStoreBase.getAllProcedures',
      context: context);

  @override
  Future getAllProcedures() {
    return _$getAllProceduresAsyncAction.run(() => super.getAllProcedures());
  }

  late final _$getAllPatientsAsyncAction = AsyncAction(
      '_EditEventProcedureStoreBase.getAllPatients',
      context: context);

  @override
  Future getAllPatients() {
    return _$getAllPatientsAsyncAction.run(() => super.getAllPatients());
  }

  late final _$getAllHospitalsAsyncAction = AsyncAction(
      '_EditEventProcedureStoreBase.getAllHospitals',
      context: context);

  @override
  Future getAllHospitals() {
    return _$getAllHospitalsAsyncAction.run(() => super.getAllHospitals());
  }

  late final _$getAllHealthInsurancesAsyncAction = AsyncAction(
      '_EditEventProcedureStoreBase.getAllHealthInsurances',
      context: context);

  @override
  Future getAllHealthInsurances() {
    return _$getAllHealthInsurancesAsyncAction
        .run(() => super.getAllHealthInsurances());
  }

  late final _$_EditEventProcedureStoreBaseActionController =
      ActionController(name: '_EditEventProcedureStoreBase', context: context);

  @override
  void setPatientId(int patientId) {
    final _$actionInfo = _$_EditEventProcedureStoreBaseActionController
        .startAction(name: '_EditEventProcedureStoreBase.setPatientId');
    try {
      return super.setPatientId(patientId);
    } finally {
      _$_EditEventProcedureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setProcedureId(int procedureId) {
    final _$actionInfo = _$_EditEventProcedureStoreBaseActionController
        .startAction(name: '_EditEventProcedureStoreBase.setProcedureId');
    try {
      return super.setProcedureId(procedureId);
    } finally {
      _$_EditEventProcedureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHospitalId(int hospitalId) {
    final _$actionInfo = _$_EditEventProcedureStoreBaseActionController
        .startAction(name: '_EditEventProcedureStoreBase.setHospitalId');
    try {
      return super.setHospitalId(hospitalId);
    } finally {
      _$_EditEventProcedureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHealthInsuranceId(int healthInsuranceId) {
    final _$actionInfo = _$_EditEventProcedureStoreBaseActionController
        .startAction(name: '_EditEventProcedureStoreBase.setHealthInsuranceId');
    try {
      return super.setHealthInsuranceId(healthInsuranceId);
    } finally {
      _$_EditEventProcedureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPatientServiceNumber(String patientServiceNumber) {
    final _$actionInfo =
        _$_EditEventProcedureStoreBaseActionController.startAction(
            name: '_EditEventProcedureStoreBase.setPatientServiceNumber');
    try {
      return super.setPatientServiceNumber(patientServiceNumber);
    } finally {
      _$_EditEventProcedureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAccommodation(String accommodation) {
    final _$actionInfo = _$_EditEventProcedureStoreBaseActionController
        .startAction(name: '_EditEventProcedureStoreBase.setAccommodation');
    try {
      return super.setAccommodation(accommodation);
    } finally {
      _$_EditEventProcedureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUrgency(bool urgency) {
    final _$actionInfo = _$_EditEventProcedureStoreBaseActionController
        .startAction(name: '_EditEventProcedureStoreBase.setUrgency');
    try {
      return super.setUrgency(urgency);
    } finally {
      _$_EditEventProcedureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCreatedDate(String createdDate) {
    final _$actionInfo = _$_EditEventProcedureStoreBaseActionController
        .startAction(name: '_EditEventProcedureStoreBase.setCreatedDate');
    try {
      return super.setCreatedDate(createdDate);
    } finally {
      _$_EditEventProcedureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPaydAt(String paydAt) {
    final _$actionInfo = _$_EditEventProcedureStoreBaseActionController
        .startAction(name: '_EditEventProcedureStoreBase.setPaydAt');
    try {
      return super.setPaydAt(paydAt);
    } finally {
      _$_EditEventProcedureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPatient(Patient patient) {
    final _$actionInfo = _$_EditEventProcedureStoreBaseActionController
        .startAction(name: '_EditEventProcedureStoreBase.setPatient');
    try {
      return super.setPatient(patient);
    } finally {
      _$_EditEventProcedureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state},
saveState: ${saveState},
isValidData: ${isValidData}
    ''';
  }
}
