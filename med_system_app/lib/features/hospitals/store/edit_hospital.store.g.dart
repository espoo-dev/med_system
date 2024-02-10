// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_hospital.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EditHospitalStore on _EditHospitalStoreBase, Store {
  Computed<bool>? _$isValidDataComputed;

  @override
  bool get isValidData =>
      (_$isValidDataComputed ??= Computed<bool>(() => super.isValidData,
              name: '_EditHospitalStoreBase.isValidData'))
          .value;

  late final _$saveStateAtom =
      Atom(name: '_EditHospitalStoreBase.saveState', context: context);

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
      Atom(name: '_EditHospitalStoreBase._errorMessage', context: context);

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
      Atom(name: '_EditHospitalStoreBase._hospitalName', context: context);

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
      Atom(name: '_EditHospitalStoreBase._address', context: context);

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

  late final _$editHospitalAsyncAction =
      AsyncAction('_EditHospitalStoreBase.editHospital', context: context);

  @override
  Future editHospital(int hospitalId) {
    return _$editHospitalAsyncAction.run(() => super.editHospital(hospitalId));
  }

  late final _$_EditHospitalStoreBaseActionController =
      ActionController(name: '_EditHospitalStoreBase', context: context);

  @override
  void setNameHospital(String nameHospital) {
    final _$actionInfo = _$_EditHospitalStoreBaseActionController.startAction(
        name: '_EditHospitalStoreBase.setNameHospital');
    try {
      return super.setNameHospital(nameHospital);
    } finally {
      _$_EditHospitalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAddress(String address) {
    final _$actionInfo = _$_EditHospitalStoreBaseActionController.startAction(
        name: '_EditHospitalStoreBase.setAddress');
    try {
      return super.setAddress(address);
    } finally {
      _$_EditHospitalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getData(Hospital hospital) {
    final _$actionInfo = _$_EditHospitalStoreBaseActionController.startAction(
        name: '_EditHospitalStoreBase.getData');
    try {
      return super.getData(hospital);
    } finally {
      _$_EditHospitalStoreBaseActionController.endAction(_$actionInfo);
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
