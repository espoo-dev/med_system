// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_hospital.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddHospitalStore on _AddHospitalStoreBase, Store {
  Computed<bool>? _$isValidDataComputed;

  @override
  bool get isValidData =>
      (_$isValidDataComputed ??= Computed<bool>(() => super.isValidData,
              name: '_AddHospitalStoreBase.isValidData'))
          .value;

  late final _$saveStateAtom =
      Atom(name: '_AddHospitalStoreBase.saveState', context: context);

  @override
  SaveHospitalState get saveState {
    _$saveStateAtom.reportRead();
    return super.saveState;
  }

  @override
  set saveState(SaveHospitalState value) {
    _$saveStateAtom.reportWrite(value, super.saveState, () {
      super.saveState = value;
    });
  }

  late final _$_errorMessageAtom =
      Atom(name: '_AddHospitalStoreBase._errorMessage', context: context);

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

  late final _$_hospitalNameAtom =
      Atom(name: '_AddHospitalStoreBase._hospitalName', context: context);

  @override
  String get _hospitalName {
    _$_hospitalNameAtom.reportRead();
    return super._hospitalName;
  }

  @override
  set _hospitalName(String value) {
    _$_hospitalNameAtom.reportWrite(value, super._hospitalName, () {
      super._hospitalName = value;
    });
  }

  late final _$_addressAtom =
      Atom(name: '_AddHospitalStoreBase._address', context: context);

  @override
  String get _address {
    _$_addressAtom.reportRead();
    return super._address;
  }

  @override
  set _address(String value) {
    _$_addressAtom.reportWrite(value, super._address, () {
      super._address = value;
    });
  }

  late final _$createHospitalAsyncAction =
      AsyncAction('_AddHospitalStoreBase.createHospital', context: context);

  @override
  Future createHospital() {
    return _$createHospitalAsyncAction.run(() => super.createHospital());
  }

  late final _$_AddHospitalStoreBaseActionController =
      ActionController(name: '_AddHospitalStoreBase', context: context);

  @override
  void setNameHospital(String nameHospital) {
    final _$actionInfo = _$_AddHospitalStoreBaseActionController.startAction(
        name: '_AddHospitalStoreBase.setNameHospital');
    try {
      return super.setNameHospital(nameHospital);
    } finally {
      _$_AddHospitalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAddress(String address) {
    final _$actionInfo = _$_AddHospitalStoreBaseActionController.startAction(
        name: '_AddHospitalStoreBase.setAddress');
    try {
      return super.setAddress(address);
    } finally {
      _$_AddHospitalStoreBaseActionController.endAction(_$actionInfo);
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
