// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PatientStore on _PatientStoreBase, Store {
  late final _$stateAtom =
      Atom(name: '_PatientStoreBase.state', context: context);

  @override
  PatientState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(PatientState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$_errorMessageAtom =
      Atom(name: '_PatientStoreBase._errorMessage', context: context);

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

  late final _$_pageAtom =
      Atom(name: '_PatientStoreBase._page', context: context);

  @override
  int get _page {
    _$_pageAtom.reportRead();
    return super._page;
  }

  @override
  set _page(int value) {
    _$_pageAtom.reportWrite(value, super._page, () {
      super._page = value;
    });
  }

  late final _$getAllPatientsAsyncAction =
      AsyncAction('_PatientStoreBase.getAllPatients', context: context);

  @override
  Future getAllPatients({bool isRefresh = false}) {
    return _$getAllPatientsAsyncAction
        .run(() => super.getAllPatients(isRefresh: isRefresh));
  }

  late final _$deletePatientAsyncAction =
      AsyncAction('_PatientStoreBase.deletePatient', context: context);

  @override
  Future deletePatient(int patientId) {
    return _$deletePatientAsyncAction.run(() => super.deletePatient(patientId));
  }

  late final _$_PatientStoreBaseActionController =
      ActionController(name: '_PatientStoreBase', context: context);

  @override
  dynamic dispose() {
    final _$actionInfo = _$_PatientStoreBaseActionController.startAction(
        name: '_PatientStoreBase.dispose');
    try {
      return super.dispose();
    } finally {
      _$_PatientStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
