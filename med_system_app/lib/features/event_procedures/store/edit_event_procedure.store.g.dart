// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_event_procedure.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EditEventProcedureStore on _EditEventProcedureStoreBase, Store {
  Computed<bool>? _$isOtherPaymentComputed;

  @override
  bool get isOtherPayment =>
      (_$isOtherPaymentComputed ??= Computed<bool>(() => super.isOtherPayment,
              name: '_EditEventProcedureStoreBase.isOtherPayment'))
          .value;
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

  late final _$_paymentAtom =
      Atom(name: '_EditEventProcedureStoreBase._payment', context: context);

  @override
  String get _payment {
    _$_paymentAtom.reportRead();
    return super._payment;
  }

  @override
  set _payment(String value) {
    _$_paymentAtom.reportWrite(value, super._payment, () {
      super._payment = value;
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

  late final _$_paydAtom =
      Atom(name: '_EditEventProcedureStoreBase._payd', context: context);

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

  late final _$_procedureAtom =
      Atom(name: '_EditEventProcedureStoreBase._procedure', context: context);

  @override
  Procedure? get _procedure {
    _$_procedureAtom.reportRead();
    return super._procedure;
  }

  @override
  set _procedure(Procedure? value) {
    _$_procedureAtom.reportWrite(value, super._procedure, () {
      super._procedure = value;
    });
  }

  late final _$_procedureOthersAtom = Atom(
      name: '_EditEventProcedureStoreBase._procedureOthers', context: context);

  @override
  Procedure? get _procedureOthers {
    _$_procedureOthersAtom.reportRead();
    return super._procedureOthers;
  }

  @override
  set _procedureOthers(Procedure? value) {
    _$_procedureOthersAtom.reportWrite(value, super._procedureOthers, () {
      super._procedureOthers = value;
    });
  }

  late final _$_healthInsuranceOtherAtom = Atom(
      name: '_EditEventProcedureStoreBase._healthInsuranceOther',
      context: context);

  @override
  HealthInsurance? get _healthInsuranceOther {
    _$_healthInsuranceOtherAtom.reportRead();
    return super._healthInsuranceOther;
  }

  @override
  set _healthInsuranceOther(HealthInsurance? value) {
    _$_healthInsuranceOtherAtom.reportWrite(value, super._healthInsuranceOther,
        () {
      super._healthInsuranceOther = value;
    });
  }

  late final _$_healthInsuranceAtom = Atom(
      name: '_EditEventProcedureStoreBase._healthInsurance', context: context);

  @override
  HealthInsurance? get _healthInsurance {
    _$_healthInsuranceAtom.reportRead();
    return super._healthInsurance;
  }

  @override
  set _healthInsurance(HealthInsurance? value) {
    _$_healthInsuranceAtom.reportWrite(value, super._healthInsurance, () {
      super._healthInsurance = value;
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
  Future fetchAllData(
      String namePatient, String nameProcedure, String nameHealthInsurance) {
    return _$fetchAllDataAsyncAction.run(() =>
        super.fetchAllData(namePatient, nameProcedure, nameHealthInsurance));
  }

  late final _$getAllProceduresByCustomAsyncAction = AsyncAction(
      '_EditEventProcedureStoreBase.getAllProceduresByCustom',
      context: context);

  @override
  Future<dynamic> getAllProceduresByCustom(String nameProcedure) {
    return _$getAllProceduresByCustomAsyncAction
        .run(() => super.getAllProceduresByCustom(nameProcedure));
  }

  late final _$getAllHealthInsurancesByCustomAsyncAction = AsyncAction(
      '_EditEventProcedureStoreBase.getAllHealthInsurancesByCustom',
      context: context);

  @override
  Future<dynamic> getAllHealthInsurancesByCustom(String nameHealthInsurance) {
    return _$getAllHealthInsurancesByCustomAsyncAction
        .run(() => super.getAllHealthInsurancesByCustom(nameHealthInsurance));
  }

  late final _$getAllProceduresAsyncAction = AsyncAction(
      '_EditEventProcedureStoreBase.getAllProcedures',
      context: context);

  @override
  Future<dynamic> getAllProcedures(String nameProcedure) {
    return _$getAllProceduresAsyncAction
        .run(() => super.getAllProcedures(nameProcedure));
  }

  late final _$getAllPatientsAsyncAction = AsyncAction(
      '_EditEventProcedureStoreBase.getAllPatients',
      context: context);

  @override
  Future<dynamic> getAllPatients(String namePatient) {
    return _$getAllPatientsAsyncAction
        .run(() => super.getAllPatients(namePatient));
  }

  late final _$getAllHospitalsAsyncAction = AsyncAction(
      '_EditEventProcedureStoreBase.getAllHospitals',
      context: context);

  @override
  Future<dynamic> getAllHospitals() {
    return _$getAllHospitalsAsyncAction.run(() => super.getAllHospitals());
  }

  late final _$getAllHealthInsurancesAsyncAction = AsyncAction(
      '_EditEventProcedureStoreBase.getAllHealthInsurances',
      context: context);

  @override
  Future<dynamic> getAllHealthInsurances(String nameHealthInsurance) {
    return _$getAllHealthInsurancesAsyncAction
        .run(() => super.getAllHealthInsurances(nameHealthInsurance));
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
  void setPayment(String payment) {
    final _$actionInfo = _$_EditEventProcedureStoreBaseActionController
        .startAction(name: '_EditEventProcedureStoreBase.setPayment');
    try {
      return super.setPayment(payment);
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
  void setPayd(bool payd) {
    final _$actionInfo = _$_EditEventProcedureStoreBaseActionController
        .startAction(name: '_EditEventProcedureStoreBase.setPayd');
    try {
      return super.setPayd(payd);
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
  void setProcedure(Procedure procedure) {
    final _$actionInfo = _$_EditEventProcedureStoreBaseActionController
        .startAction(name: '_EditEventProcedureStoreBase.setProcedure');
    try {
      return super.setProcedure(procedure);
    } finally {
      _$_EditEventProcedureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setProcedureOther(Procedure procedure) {
    final _$actionInfo = _$_EditEventProcedureStoreBaseActionController
        .startAction(name: '_EditEventProcedureStoreBase.setProcedureOther');
    try {
      return super.setProcedureOther(procedure);
    } finally {
      _$_EditEventProcedureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHealthInsuranceOther(HealthInsurance healthInsurance) {
    final _$actionInfo =
        _$_EditEventProcedureStoreBaseActionController.startAction(
            name: '_EditEventProcedureStoreBase.setHealthInsuranceOther');
    try {
      return super.setHealthInsuranceOther(healthInsurance);
    } finally {
      _$_EditEventProcedureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHealthInsurance(HealthInsurance healthInsurance) {
    final _$actionInfo = _$_EditEventProcedureStoreBaseActionController
        .startAction(name: '_EditEventProcedureStoreBase.setHealthInsurance');
    try {
      return super.setHealthInsurance(healthInsurance);
    } finally {
      _$_EditEventProcedureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state},
saveState: ${saveState},
isOtherPayment: ${isOtherPayment},
isValidData: ${isValidData}
    ''';
  }
}
