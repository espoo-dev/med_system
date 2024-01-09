// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hospital.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HospitalStore on _HospitalStoreBase, Store {
  late final _$stateAtom =
      Atom(name: '_HospitalStoreBase.state', context: context);

  @override
  HospitalState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(HospitalState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$_errorMessageAtom =
      Atom(name: '_HospitalStoreBase._errorMessage', context: context);

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

  late final _$getAllHospitalsAsyncAction =
      AsyncAction('_HospitalStoreBase.getAllHospitals', context: context);

  @override
  Future getAllHospitals() {
    return _$getAllHospitalsAsyncAction.run(() => super.getAllHospitals());
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
