// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_health_insurances.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddHealthInsuranceStore on _AddHealthInsuranceStoreBase, Store {
  Computed<bool>? _$isValidDataComputed;

  @override
  bool get isValidData =>
      (_$isValidDataComputed ??= Computed<bool>(() => super.isValidData,
              name: '_AddHealthInsuranceStoreBase.isValidData'))
          .value;

  late final _$saveStateAtom =
      Atom(name: '_AddHealthInsuranceStoreBase.saveState', context: context);

  @override
  SaveHealthInsurancetState get saveState {
    _$saveStateAtom.reportRead();
    return super.saveState;
  }

  @override
  set saveState(SaveHealthInsurancetState value) {
    _$saveStateAtom.reportWrite(value, super.saveState, () {
      super.saveState = value;
    });
  }

  late final _$_errorMessageAtom = Atom(
      name: '_AddHealthInsuranceStoreBase._errorMessage', context: context);

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

  late final _$_nameAtom =
      Atom(name: '_AddHealthInsuranceStoreBase._name', context: context);

  @override
  String get _name {
    _$_nameAtom.reportRead();
    return super._name;
  }

  @override
  set _name(String value) {
    _$_nameAtom.reportWrite(value, super._name, () {
      super._name = value;
    });
  }

  late final _$createHealthInsuranceAsyncAction = AsyncAction(
      '_AddHealthInsuranceStoreBase.createHealthInsurance',
      context: context);

  @override
  Future createHealthInsurance() {
    return _$createHealthInsuranceAsyncAction
        .run(() => super.createHealthInsurance());
  }

  late final _$_AddHealthInsuranceStoreBaseActionController =
      ActionController(name: '_AddHealthInsuranceStoreBase', context: context);

  @override
  void setName(String name) {
    final _$actionInfo = _$_AddHealthInsuranceStoreBaseActionController
        .startAction(name: '_AddHealthInsuranceStoreBase.setName');
    try {
      return super.setName(name);
    } finally {
      _$_AddHealthInsuranceStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
saveState: ${saveState},
isValidData: ${isValidData}
    ''';
  }
}
