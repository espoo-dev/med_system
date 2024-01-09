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

  late final _$getAllPatientsAsyncAction =
      AsyncAction('_PatientStoreBase.getAllPatients', context: context);

  @override
  Future getAllPatients() {
    return _$getAllPatientsAsyncAction.run(() => super.getAllPatients());
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
