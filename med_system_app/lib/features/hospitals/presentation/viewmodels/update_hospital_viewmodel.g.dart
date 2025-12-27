// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_hospital_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UpdateHospitalViewModel on _UpdateHospitalViewModelBase, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_UpdateHospitalViewModelBase.isLoading'))
          .value;
  Computed<bool>? _$canSubmitComputed;

  @override
  bool get canSubmit =>
      (_$canSubmitComputed ??= Computed<bool>(() => super.canSubmit,
              name: '_UpdateHospitalViewModelBase.canSubmit'))
          .value;
  Computed<bool>? _$isValidNameComputed;

  @override
  bool get isValidName =>
      (_$isValidNameComputed ??= Computed<bool>(() => super.isValidName,
              name: '_UpdateHospitalViewModelBase.isValidName'))
          .value;
  Computed<bool>? _$isValidAddressComputed;

  @override
  bool get isValidAddress =>
      (_$isValidAddressComputed ??= Computed<bool>(() => super.isValidAddress,
              name: '_UpdateHospitalViewModelBase.isValidAddress'))
          .value;

  late final _$hospitalIdAtom =
      Atom(name: '_UpdateHospitalViewModelBase.hospitalId', context: context);

  @override
  int? get hospitalId {
    _$hospitalIdAtom.reportRead();
    return super.hospitalId;
  }

  @override
  set hospitalId(int? value) {
    _$hospitalIdAtom.reportWrite(value, super.hospitalId, () {
      super.hospitalId = value;
    });
  }

  late final _$nameAtom =
      Atom(name: '_UpdateHospitalViewModelBase.name', context: context);

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

  late final _$addressAtom =
      Atom(name: '_UpdateHospitalViewModelBase.address', context: context);

  @override
  String get address {
    _$addressAtom.reportRead();
    return super.address;
  }

  @override
  set address(String value) {
    _$addressAtom.reportWrite(value, super.address, () {
      super.address = value;
    });
  }

  late final _$stateAtom =
      Atom(name: '_UpdateHospitalViewModelBase.state', context: context);

  @override
  UpdateHospitalState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(UpdateHospitalState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_UpdateHospitalViewModelBase.errorMessage', context: context);

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

  late final _$updatedHospitalAtom = Atom(
      name: '_UpdateHospitalViewModelBase.updatedHospital', context: context);

  @override
  HospitalEntity? get updatedHospital {
    _$updatedHospitalAtom.reportRead();
    return super.updatedHospital;
  }

  @override
  set updatedHospital(HospitalEntity? value) {
    _$updatedHospitalAtom.reportWrite(value, super.updatedHospital, () {
      super.updatedHospital = value;
    });
  }

  late final _$updateHospitalAsyncAction = AsyncAction(
      '_UpdateHospitalViewModelBase.updateHospital',
      context: context);

  @override
  Future<void> updateHospital() {
    return _$updateHospitalAsyncAction.run(() => super.updateHospital());
  }

  late final _$_UpdateHospitalViewModelBaseActionController =
      ActionController(name: '_UpdateHospitalViewModelBase', context: context);

  @override
  void setHospitalId(int id) {
    final _$actionInfo = _$_UpdateHospitalViewModelBaseActionController
        .startAction(name: '_UpdateHospitalViewModelBase.setHospitalId');
    try {
      return super.setHospitalId(id);
    } finally {
      _$_UpdateHospitalViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setName(String value) {
    final _$actionInfo = _$_UpdateHospitalViewModelBaseActionController
        .startAction(name: '_UpdateHospitalViewModelBase.setName');
    try {
      return super.setName(value);
    } finally {
      _$_UpdateHospitalViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAddress(String value) {
    final _$actionInfo = _$_UpdateHospitalViewModelBaseActionController
        .startAction(name: '_UpdateHospitalViewModelBase.setAddress');
    try {
      return super.setAddress(value);
    } finally {
      _$_UpdateHospitalViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadHospital(HospitalEntity hospital) {
    final _$actionInfo = _$_UpdateHospitalViewModelBaseActionController
        .startAction(name: '_UpdateHospitalViewModelBase.loadHospital');
    try {
      return super.loadHospital(hospital);
    } finally {
      _$_UpdateHospitalViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetState() {
    final _$actionInfo = _$_UpdateHospitalViewModelBaseActionController
        .startAction(name: '_UpdateHospitalViewModelBase.resetState');
    try {
      return super.resetState();
    } finally {
      _$_UpdateHospitalViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo = _$_UpdateHospitalViewModelBaseActionController
        .startAction(name: '_UpdateHospitalViewModelBase.reset');
    try {
      return super.reset();
    } finally {
      _$_UpdateHospitalViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
hospitalId: ${hospitalId},
name: ${name},
address: ${address},
state: ${state},
errorMessage: ${errorMessage},
updatedHospital: ${updatedHospital},
isLoading: ${isLoading},
canSubmit: ${canSubmit},
isValidName: ${isValidName},
isValidAddress: ${isValidAddress}
    ''';
  }
}
