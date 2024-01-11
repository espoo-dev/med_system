// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_insurances.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HealthInsurancesStore on _HealthInsurancesStoreBase, Store {
  late final _$stateAtom =
      Atom(name: '_HealthInsurancesStoreBase.state', context: context);

  @override
  HealthInsuranceState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(HealthInsuranceState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$_errorMessageAtom =
      Atom(name: '_HealthInsurancesStoreBase._errorMessage', context: context);

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

  late final _$getAllHealthInsurancesAsyncAction = AsyncAction(
      '_HealthInsurancesStoreBase.getAllHealthInsurances',
      context: context);

  @override
  Future getAllHealthInsurances() {
    return _$getAllHealthInsurancesAsyncAction
        .run(() => super.getAllHealthInsurances());
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
