// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_event_procedure_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UpdateEventProcedureViewModel
    on _UpdateEventProcedureViewModelBase, Store {
  Computed<bool>? _$isValidFullDataComputed;

  @override
  bool get isValidFullData =>
      (_$isValidFullDataComputed ??= Computed<bool>(() => super.isValidFullData,
              name: '_UpdateEventProcedureViewModelBase.isValidFullData'))
          .value;

  late final _$hospitalsAtom = Atom(
      name: '_UpdateEventProcedureViewModelBase.hospitals', context: context);

  @override
  ObservableList<HospitalEntity> get hospitals {
    _$hospitalsAtom.reportRead();
    return super.hospitals;
  }

  @override
  set hospitals(ObservableList<HospitalEntity> value) {
    _$hospitalsAtom.reportWrite(value, super.hospitals, () {
      super.hospitals = value;
    });
  }

  late final _$patientsAtom = Atom(
      name: '_UpdateEventProcedureViewModelBase.patients', context: context);

  @override
  ObservableList<PatientEntity> get patients {
    _$patientsAtom.reportRead();
    return super.patients;
  }

  @override
  set patients(ObservableList<PatientEntity> value) {
    _$patientsAtom.reportWrite(value, super.patients, () {
      super.patients = value;
    });
  }

  late final _$proceduresAtom = Atom(
      name: '_UpdateEventProcedureViewModelBase.procedures', context: context);

  @override
  ObservableList<ProcedureEntity> get procedures {
    _$proceduresAtom.reportRead();
    return super.procedures;
  }

  @override
  set procedures(ObservableList<ProcedureEntity> value) {
    _$proceduresAtom.reportWrite(value, super.procedures, () {
      super.procedures = value;
    });
  }

  late final _$healthInsurancesAtom = Atom(
      name: '_UpdateEventProcedureViewModelBase.healthInsurances',
      context: context);

  @override
  ObservableList<HealthInsuranceEntity> get healthInsurances {
    _$healthInsurancesAtom.reportRead();
    return super.healthInsurances;
  }

  @override
  set healthInsurances(ObservableList<HealthInsuranceEntity> value) {
    _$healthInsurancesAtom.reportWrite(value, super.healthInsurances, () {
      super.healthInsurances = value;
    });
  }

  late final _$selectedHospitalAtom = Atom(
      name: '_UpdateEventProcedureViewModelBase.selectedHospital',
      context: context);

  @override
  HospitalEntity? get selectedHospital {
    _$selectedHospitalAtom.reportRead();
    return super.selectedHospital;
  }

  @override
  set selectedHospital(HospitalEntity? value) {
    _$selectedHospitalAtom.reportWrite(value, super.selectedHospital, () {
      super.selectedHospital = value;
    });
  }

  late final _$selectedPatientAtom = Atom(
      name: '_UpdateEventProcedureViewModelBase.selectedPatient',
      context: context);

  @override
  PatientEntity? get selectedPatient {
    _$selectedPatientAtom.reportRead();
    return super.selectedPatient;
  }

  @override
  set selectedPatient(PatientEntity? value) {
    _$selectedPatientAtom.reportWrite(value, super.selectedPatient, () {
      super.selectedPatient = value;
    });
  }

  late final _$selectedProcedureAtom = Atom(
      name: '_UpdateEventProcedureViewModelBase.selectedProcedure',
      context: context);

  @override
  ProcedureEntity? get selectedProcedure {
    _$selectedProcedureAtom.reportRead();
    return super.selectedProcedure;
  }

  @override
  set selectedProcedure(ProcedureEntity? value) {
    _$selectedProcedureAtom.reportWrite(value, super.selectedProcedure, () {
      super.selectedProcedure = value;
    });
  }

  late final _$selectedHealthInsuranceAtom = Atom(
      name: '_UpdateEventProcedureViewModelBase.selectedHealthInsurance',
      context: context);

  @override
  HealthInsuranceEntity? get selectedHealthInsurance {
    _$selectedHealthInsuranceAtom.reportRead();
    return super.selectedHealthInsurance;
  }

  @override
  set selectedHealthInsurance(HealthInsuranceEntity? value) {
    _$selectedHealthInsuranceAtom
        .reportWrite(value, super.selectedHealthInsurance, () {
      super.selectedHealthInsurance = value;
    });
  }

  late final _$patientServiceNumberAtom = Atom(
      name: '_UpdateEventProcedureViewModelBase.patientServiceNumber',
      context: context);

  @override
  String get patientServiceNumber {
    _$patientServiceNumberAtom.reportRead();
    return super.patientServiceNumber;
  }

  @override
  set patientServiceNumber(String value) {
    _$patientServiceNumberAtom.reportWrite(value, super.patientServiceNumber,
        () {
      super.patientServiceNumber = value;
    });
  }

  late final _$isPaidAtom =
      Atom(name: '_UpdateEventProcedureViewModelBase.isPaid', context: context);

  @override
  bool get isPaid {
    _$isPaidAtom.reportRead();
    return super.isPaid;
  }

  @override
  set isPaid(bool value) {
    _$isPaidAtom.reportWrite(value, super.isPaid, () {
      super.isPaid = value;
    });
  }

  late final _$urgencyAtom = Atom(
      name: '_UpdateEventProcedureViewModelBase.urgency', context: context);

  @override
  bool get urgency {
    _$urgencyAtom.reportRead();
    return super.urgency;
  }

  @override
  set urgency(bool value) {
    _$urgencyAtom.reportWrite(value, super.urgency, () {
      super.urgency = value;
    });
  }

  late final _$roomTypeAtom = Atom(
      name: '_UpdateEventProcedureViewModelBase.roomType', context: context);

  @override
  String get roomType {
    _$roomTypeAtom.reportRead();
    return super.roomType;
  }

  @override
  set roomType(String value) {
    _$roomTypeAtom.reportWrite(value, super.roomType, () {
      super.roomType = value;
    });
  }

  late final _$createdDateAtom = Atom(
      name: '_UpdateEventProcedureViewModelBase.createdDate', context: context);

  @override
  String get createdDate {
    _$createdDateAtom.reportRead();
    return super.createdDate;
  }

  @override
  set createdDate(String value) {
    _$createdDateAtom.reportWrite(value, super.createdDate, () {
      super.createdDate = value;
    });
  }

  late final _$paymentTypeAtom = Atom(
      name: '_UpdateEventProcedureViewModelBase.paymentType', context: context);

  @override
  String get paymentType {
    _$paymentTypeAtom.reportRead();
    return super.paymentType;
  }

  @override
  set paymentType(String value) {
    _$paymentTypeAtom.reportWrite(value, super.paymentType, () {
      super.paymentType = value;
    });
  }

  late final _$otherProcedureNameAtom = Atom(
      name: '_UpdateEventProcedureViewModelBase.otherProcedureName',
      context: context);

  @override
  String get otherProcedureName {
    _$otherProcedureNameAtom.reportRead();
    return super.otherProcedureName;
  }

  @override
  set otherProcedureName(String value) {
    _$otherProcedureNameAtom.reportWrite(value, super.otherProcedureName, () {
      super.otherProcedureName = value;
    });
  }

  late final _$otherProcedureAmountAtom = Atom(
      name: '_UpdateEventProcedureViewModelBase.otherProcedureAmount',
      context: context);

  @override
  String get otherProcedureAmount {
    _$otherProcedureAmountAtom.reportRead();
    return super.otherProcedureAmount;
  }

  @override
  set otherProcedureAmount(String value) {
    _$otherProcedureAmountAtom.reportWrite(value, super.otherProcedureAmount,
        () {
      super.otherProcedureAmount = value;
    });
  }

  late final _$otherProcedureDescriptionAtom = Atom(
      name: '_UpdateEventProcedureViewModelBase.otherProcedureDescription',
      context: context);

  @override
  String get otherProcedureDescription {
    _$otherProcedureDescriptionAtom.reportRead();
    return super.otherProcedureDescription;
  }

  @override
  set otherProcedureDescription(String value) {
    _$otherProcedureDescriptionAtom
        .reportWrite(value, super.otherProcedureDescription, () {
      super.otherProcedureDescription = value;
    });
  }

  late final _$otherHealthInsuranceNameAtom = Atom(
      name: '_UpdateEventProcedureViewModelBase.otherHealthInsuranceName',
      context: context);

  @override
  String get otherHealthInsuranceName {
    _$otherHealthInsuranceNameAtom.reportRead();
    return super.otherHealthInsuranceName;
  }

  @override
  set otherHealthInsuranceName(String value) {
    _$otherHealthInsuranceNameAtom
        .reportWrite(value, super.otherHealthInsuranceName, () {
      super.otherHealthInsuranceName = value;
    });
  }

  late final _$isLoadingAtom = Atom(
      name: '_UpdateEventProcedureViewModelBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom = Atom(
      name: '_UpdateEventProcedureViewModelBase.errorMessage',
      context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$isSuccessAtom = Atom(
      name: '_UpdateEventProcedureViewModelBase.isSuccess', context: context);

  @override
  bool get isSuccess {
    _$isSuccessAtom.reportRead();
    return super.isSuccess;
  }

  @override
  set isSuccess(bool value) {
    _$isSuccessAtom.reportWrite(value, super.isSuccess, () {
      super.isSuccess = value;
    });
  }

  late final _$loadInitialDataAsyncAction = AsyncAction(
      '_UpdateEventProcedureViewModelBase.loadInitialData',
      context: context);

  @override
  Future<void> loadInitialData(EventProcedureEntity eventProcedure) {
    return _$loadInitialDataAsyncAction
        .run(() => super.loadInitialData(eventProcedure));
  }

  late final _$updateEventProcedureAsyncAction = AsyncAction(
      '_UpdateEventProcedureViewModelBase.updateEventProcedure',
      context: context);

  @override
  Future<void> updateEventProcedure() {
    return _$updateEventProcedureAsyncAction
        .run(() => super.updateEventProcedure());
  }

  late final _$_UpdateEventProcedureViewModelBaseActionController =
      ActionController(
          name: '_UpdateEventProcedureViewModelBase', context: context);

  @override
  void setHospital(HospitalEntity? value) {
    final _$actionInfo = _$_UpdateEventProcedureViewModelBaseActionController
        .startAction(name: '_UpdateEventProcedureViewModelBase.setHospital');
    try {
      return super.setHospital(value);
    } finally {
      _$_UpdateEventProcedureViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setPatient(PatientEntity? value) {
    final _$actionInfo = _$_UpdateEventProcedureViewModelBaseActionController
        .startAction(name: '_UpdateEventProcedureViewModelBase.setPatient');
    try {
      return super.setPatient(value);
    } finally {
      _$_UpdateEventProcedureViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setProcedure(ProcedureEntity? value) {
    final _$actionInfo = _$_UpdateEventProcedureViewModelBaseActionController
        .startAction(name: '_UpdateEventProcedureViewModelBase.setProcedure');
    try {
      return super.setProcedure(value);
    } finally {
      _$_UpdateEventProcedureViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setHealthInsurance(HealthInsuranceEntity? value) {
    final _$actionInfo =
        _$_UpdateEventProcedureViewModelBaseActionController.startAction(
            name: '_UpdateEventProcedureViewModelBase.setHealthInsurance');
    try {
      return super.setHealthInsurance(value);
    } finally {
      _$_UpdateEventProcedureViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setPatientServiceNumber(String value) {
    final _$actionInfo =
        _$_UpdateEventProcedureViewModelBaseActionController.startAction(
            name: '_UpdateEventProcedureViewModelBase.setPatientServiceNumber');
    try {
      return super.setPatientServiceNumber(value);
    } finally {
      _$_UpdateEventProcedureViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setIsPaid(bool value) {
    final _$actionInfo = _$_UpdateEventProcedureViewModelBaseActionController
        .startAction(name: '_UpdateEventProcedureViewModelBase.setIsPaid');
    try {
      return super.setIsPaid(value);
    } finally {
      _$_UpdateEventProcedureViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setUrgency(bool value) {
    final _$actionInfo = _$_UpdateEventProcedureViewModelBaseActionController
        .startAction(name: '_UpdateEventProcedureViewModelBase.setUrgency');
    try {
      return super.setUrgency(value);
    } finally {
      _$_UpdateEventProcedureViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setRoomType(String value) {
    final _$actionInfo = _$_UpdateEventProcedureViewModelBaseActionController
        .startAction(name: '_UpdateEventProcedureViewModelBase.setRoomType');
    try {
      return super.setRoomType(value);
    } finally {
      _$_UpdateEventProcedureViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setCreatedDate(String value) {
    final _$actionInfo = _$_UpdateEventProcedureViewModelBaseActionController
        .startAction(name: '_UpdateEventProcedureViewModelBase.setCreatedDate');
    try {
      return super.setCreatedDate(value);
    } finally {
      _$_UpdateEventProcedureViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setPaymentType(String value) {
    final _$actionInfo = _$_UpdateEventProcedureViewModelBaseActionController
        .startAction(name: '_UpdateEventProcedureViewModelBase.setPaymentType');
    try {
      return super.setPaymentType(value);
    } finally {
      _$_UpdateEventProcedureViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setOtherProcedureName(String value) {
    final _$actionInfo =
        _$_UpdateEventProcedureViewModelBaseActionController.startAction(
            name: '_UpdateEventProcedureViewModelBase.setOtherProcedureName');
    try {
      return super.setOtherProcedureName(value);
    } finally {
      _$_UpdateEventProcedureViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setOtherProcedureAmount(String value) {
    final _$actionInfo =
        _$_UpdateEventProcedureViewModelBaseActionController.startAction(
            name: '_UpdateEventProcedureViewModelBase.setOtherProcedureAmount');
    try {
      return super.setOtherProcedureAmount(value);
    } finally {
      _$_UpdateEventProcedureViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setOtherProcedureDescription(String value) {
    final _$actionInfo =
        _$_UpdateEventProcedureViewModelBaseActionController.startAction(
            name:
                '_UpdateEventProcedureViewModelBase.setOtherProcedureDescription');
    try {
      return super.setOtherProcedureDescription(value);
    } finally {
      _$_UpdateEventProcedureViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setOtherHealthInsuranceName(String value) {
    final _$actionInfo =
        _$_UpdateEventProcedureViewModelBaseActionController.startAction(
            name:
                '_UpdateEventProcedureViewModelBase.setOtherHealthInsuranceName');
    try {
      return super.setOtherHealthInsuranceName(value);
    } finally {
      _$_UpdateEventProcedureViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
hospitals: ${hospitals},
patients: ${patients},
procedures: ${procedures},
healthInsurances: ${healthInsurances},
selectedHospital: ${selectedHospital},
selectedPatient: ${selectedPatient},
selectedProcedure: ${selectedProcedure},
selectedHealthInsurance: ${selectedHealthInsurance},
patientServiceNumber: ${patientServiceNumber},
isPaid: ${isPaid},
urgency: ${urgency},
roomType: ${roomType},
createdDate: ${createdDate},
paymentType: ${paymentType},
otherProcedureName: ${otherProcedureName},
otherProcedureAmount: ${otherProcedureAmount},
otherProcedureDescription: ${otherProcedureDescription},
otherHealthInsuranceName: ${otherHealthInsuranceName},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
isSuccess: ${isSuccess},
isValidFullData: ${isValidFullData}
    ''';
  }
}
