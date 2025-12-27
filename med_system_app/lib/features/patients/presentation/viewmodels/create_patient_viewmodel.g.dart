// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_patient_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreatePatientViewModel on _CreatePatientViewModelBase, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_CreatePatientViewModelBase.isLoading'))
          .value;
  Computed<bool>? _$canSubmitComputed;

  @override
  bool get canSubmit =>
      (_$canSubmitComputed ??= Computed<bool>(() => super.canSubmit,
              name: '_CreatePatientViewModelBase.canSubmit'))
          .value;
  Computed<bool>? _$isValidNameComputed;

  @override
  bool get isValidName =>
      (_$isValidNameComputed ??= Computed<bool>(() => super.isValidName,
              name: '_CreatePatientViewModelBase.isValidName'))
          .value;

  late final _$nameAtom =
      Atom(name: '_CreatePatientViewModelBase.name', context: context);

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
      Atom(name: '_CreatePatientViewModelBase.state', context: context);

  @override
  CreatePatientState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(CreatePatientState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_CreatePatientViewModelBase.errorMessage', context: context);

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

  late final _$createdPatientAtom = Atom(
      name: '_CreatePatientViewModelBase.createdPatient', context: context);

  @override
  PatientEntity? get createdPatient {
    _$createdPatientAtom.reportRead();
    return super.createdPatient;
  }

  @override
  set createdPatient(PatientEntity? value) {
    _$createdPatientAtom.reportWrite(value, super.createdPatient, () {
      super.createdPatient = value;
    });
  }

  late final _$createPatientAsyncAction = AsyncAction(
      '_CreatePatientViewModelBase.createPatient',
      context: context);

  @override
  Future<void> createPatient() {
    return _$createPatientAsyncAction.run(() => super.createPatient());
  }

  late final _$_CreatePatientViewModelBaseActionController =
      ActionController(name: '_CreatePatientViewModelBase', context: context);

  @override
  void setName(String value) {
    final _$actionInfo = _$_CreatePatientViewModelBaseActionController
        .startAction(name: '_CreatePatientViewModelBase.setName');
    try {
      return super.setName(value);
    } finally {
      _$_CreatePatientViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetState() {
    final _$actionInfo = _$_CreatePatientViewModelBaseActionController
        .startAction(name: '_CreatePatientViewModelBase.resetState');
    try {
      return super.resetState();
    } finally {
      _$_CreatePatientViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo = _$_CreatePatientViewModelBaseActionController
        .startAction(name: '_CreatePatientViewModelBase.reset');
    try {
      return super.reset();
    } finally {
      _$_CreatePatientViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
state: ${state},
errorMessage: ${errorMessage},
createdPatient: ${createdPatient},
isLoading: ${isLoading},
canSubmit: ${canSubmit},
isValidName: ${isValidName}
    ''';
  }
}
