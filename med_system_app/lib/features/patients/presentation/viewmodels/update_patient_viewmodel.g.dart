// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_patient_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UpdatePatientViewModel on _UpdatePatientViewModelBase, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_UpdatePatientViewModelBase.isLoading'))
          .value;
  Computed<bool>? _$canSubmitComputed;

  @override
  bool get canSubmit =>
      (_$canSubmitComputed ??= Computed<bool>(() => super.canSubmit,
              name: '_UpdatePatientViewModelBase.canSubmit'))
          .value;
  Computed<bool>? _$isValidNameComputed;

  @override
  bool get isValidName =>
      (_$isValidNameComputed ??= Computed<bool>(() => super.isValidName,
              name: '_UpdatePatientViewModelBase.isValidName'))
          .value;

  late final _$patientIdAtom =
      Atom(name: '_UpdatePatientViewModelBase.patientId', context: context);

  @override
  int? get patientId {
    _$patientIdAtom.reportRead();
    return super.patientId;
  }

  @override
  set patientId(int? value) {
    _$patientIdAtom.reportWrite(value, super.patientId, () {
      super.patientId = value;
    });
  }

  late final _$nameAtom =
      Atom(name: '_UpdatePatientViewModelBase.name', context: context);

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$stateAtom =
      Atom(name: '_UpdatePatientViewModelBase.state', context: context);

  @override
  UpdatePatientState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(UpdatePatientState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_UpdatePatientViewModelBase.errorMessage', context: context);

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$updatedPatientAtom = Atom(
      name: '_UpdatePatientViewModelBase.updatedPatient', context: context);

  @override
  PatientEntity? get updatedPatient {
    _$updatedPatientAtom.reportRead();
    return super.updatedPatient;
  }

  @override
  set updatedPatient(PatientEntity? value) {
    _$updatedPatientAtom.reportWrite(value, super.updatedPatient, () {
      super.updatedPatient = value;
    });
  }

  late final _$updatePatientAsyncAction = AsyncAction(
      '_UpdatePatientViewModelBase.updatePatient',
      context: context);

  @override
  Future<void> updatePatient() {
    return _$updatePatientAsyncAction.run(() => super.updatePatient());
  }

  late final _$_UpdatePatientViewModelBaseActionController =
      ActionController(name: '_UpdatePatientViewModelBase', context: context);

  @override
  void setPatientId(int id) {
    final _$actionInfo = _$_UpdatePatientViewModelBaseActionController
        .startAction(name: '_UpdatePatientViewModelBase.setPatientId');
    try {
      return super.setPatientId(id);
    } finally {
      _$_UpdatePatientViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setName(String value) {
    final _$actionInfo = _$_UpdatePatientViewModelBaseActionController
        .startAction(name: '_UpdatePatientViewModelBase.setName');
    try {
      return super.setName(value);
    } finally {
      _$_UpdatePatientViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadPatient(PatientEntity patient) {
    final _$actionInfo = _$_UpdatePatientViewModelBaseActionController
        .startAction(name: '_UpdatePatientViewModelBase.loadPatient');
    try {
      return super.loadPatient(patient);
    } finally {
      _$_UpdatePatientViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetState() {
    final _$actionInfo = _$_UpdatePatientViewModelBaseActionController
        .startAction(name: '_UpdatePatientViewModelBase.resetState');
    try {
      return super.resetState();
    } finally {
      _$_UpdatePatientViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo = _$_UpdatePatientViewModelBaseActionController
        .startAction(name: '_UpdatePatientViewModelBase.reset');
    try {
      return super.reset();
    } finally {
      _$_UpdatePatientViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
patientId: ${patientId},
name: ${name},
state: ${state},
errorMessage: ${errorMessage},
updatedPatient: ${updatedPatient},
isLoading: ${isLoading},
canSubmit: ${canSubmit},
isValidName: ${isValidName}
    ''';
  }
}
