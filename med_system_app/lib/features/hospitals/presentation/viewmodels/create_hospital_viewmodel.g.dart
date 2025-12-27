// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_hospital_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreateHospitalViewModel on _CreateHospitalViewModelBase, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_CreateHospitalViewModelBase.isLoading'))
          .value;
  Computed<bool>? _$canSubmitComputed;

  @override
  bool get canSubmit =>
      (_$canSubmitComputed ??= Computed<bool>(() => super.canSubmit,
              name: '_CreateHospitalViewModelBase.canSubmit'))
          .value;
  Computed<bool>? _$isValidNameComputed;

  @override
  bool get isValidName =>
      (_$isValidNameComputed ??= Computed<bool>(() => super.isValidName,
              name: '_CreateHospitalViewModelBase.isValidName'))
          .value;
  Computed<bool>? _$isValidAddressComputed;

  @override
  bool get isValidAddress =>
      (_$isValidAddressComputed ??= Computed<bool>(() => super.isValidAddress,
              name: '_CreateHospitalViewModelBase.isValidAddress'))
          .value;

  late final _$nameAtom =
      Atom(name: '_CreateHospitalViewModelBase.name', context: context);

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
      Atom(name: '_CreateHospitalViewModelBase.address', context: context);

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
      Atom(name: '_CreateHospitalViewModelBase.state', context: context);

  @override
  CreateHospitalState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(CreateHospitalState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_CreateHospitalViewModelBase.errorMessage', context: context);

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

  late final _$createdHospitalAtom = Atom(
      name: '_CreateHospitalViewModelBase.createdHospital', context: context);

  @override
  HospitalEntity? get createdHospital {
    _$createdHospitalAtom.reportRead();
    return super.createdHospital;
  }

  @override
  set createdHospital(HospitalEntity? value) {
    _$createdHospitalAtom.reportWrite(value, super.createdHospital, () {
      super.createdHospital = value;
    });
  }

  late final _$createHospitalAsyncAction = AsyncAction(
      '_CreateHospitalViewModelBase.createHospital',
      context: context);

  @override
  Future<void> createHospital() {
    return _$createHospitalAsyncAction.run(() => super.createHospital());
  }

  late final _$_CreateHospitalViewModelBaseActionController =
      ActionController(name: '_CreateHospitalViewModelBase', context: context);

  @override
  void setName(String value) {
    final _$actionInfo = _$_CreateHospitalViewModelBaseActionController
        .startAction(name: '_CreateHospitalViewModelBase.setName');
    try {
      return super.setName(value);
    } finally {
      _$_CreateHospitalViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAddress(String value) {
    final _$actionInfo = _$_CreateHospitalViewModelBaseActionController
        .startAction(name: '_CreateHospitalViewModelBase.setAddress');
    try {
      return super.setAddress(value);
    } finally {
      _$_CreateHospitalViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetState() {
    final _$actionInfo = _$_CreateHospitalViewModelBaseActionController
        .startAction(name: '_CreateHospitalViewModelBase.resetState');
    try {
      return super.resetState();
    } finally {
      _$_CreateHospitalViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo = _$_CreateHospitalViewModelBaseActionController
        .startAction(name: '_CreateHospitalViewModelBase.reset');
    try {
      return super.reset();
    } finally {
      _$_CreateHospitalViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
address: ${address},
state: ${state},
errorMessage: ${errorMessage},
createdHospital: ${createdHospital},
isLoading: ${isLoading},
canSubmit: ${canSubmit},
isValidName: ${isValidName},
isValidAddress: ${isValidAddress}
    ''';
  }
}
