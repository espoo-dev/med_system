// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_health_insurance.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EditHealthInsuranceStore on _EditHealthInsuranceStoreBase, Store {
  Computed<bool>? _$isValidDataComputed;

  @override
  bool get isValidData =>
      (_$isValidDataComputed ??= Computed<bool>(() => super.isValidData,
              name: '_EditHealthInsuranceStoreBase.isValidData'))
          .value;

  late final _$saveStateAtom =
      Atom(name: '_EditHealthInsuranceStoreBase.saveState', context: context);

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
      name: '_EditHealthInsuranceStoreBase._errorMessage', context: context);

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
      Atom(name: '_EditHealthInsuranceStoreBase._name', context: context);

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

  late final _$editHealthInsuranceAsyncAction = AsyncAction(
      '_EditHealthInsuranceStoreBase.editHealthInsurance',
      context: context);

  @override
  Future editHealthInsurance(int healthInsuranceId) {
    return _$editHealthInsuranceAsyncAction
        .run(() => super.editHealthInsurance(healthInsuranceId));
  }

  late final _$_EditHealthInsuranceStoreBaseActionController =
      ActionController(name: '_EditHealthInsuranceStoreBase', context: context);

  @override
  void setName(String name) {
    final _$actionInfo = _$_EditHealthInsuranceStoreBaseActionController
        .startAction(name: '_EditHealthInsuranceStoreBase.setName');
    try {
      return super.setName(name);
    } finally {
      _$_EditHealthInsuranceStoreBaseActionController.endAction(_$actionInfo);
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
