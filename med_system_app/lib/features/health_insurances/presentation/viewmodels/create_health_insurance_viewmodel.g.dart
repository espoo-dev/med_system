// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_health_insurance_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreateHealthInsuranceViewModel
    on _CreateHealthInsuranceViewModelBase, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_CreateHealthInsuranceViewModelBase.isLoading'))
          .value;
  Computed<bool>? _$canSubmitComputed;

  @override
  bool get canSubmit =>
      (_$canSubmitComputed ??= Computed<bool>(() => super.canSubmit,
              name: '_CreateHealthInsuranceViewModelBase.canSubmit'))
          .value;

  late final _$nameAtom =
      Atom(name: '_CreateHealthInsuranceViewModelBase.name', context: context);

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

  late final _$stateAtom =
      Atom(name: '_CreateHealthInsuranceViewModelBase.state', context: context);

  @override
  CreateHealthInsuranceState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(CreateHealthInsuranceState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$errorMessageAtom = Atom(
      name: '_CreateHealthInsuranceViewModelBase.errorMessage',
      context: context);

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

  late final _$createdHealthInsuranceAtom = Atom(
      name: '_CreateHealthInsuranceViewModelBase.createdHealthInsurance',
      context: context);

  @override
  HealthInsuranceEntity? get createdHealthInsurance {
    _$createdHealthInsuranceAtom.reportRead();
    return super.createdHealthInsurance;
  }

  @override
  set createdHealthInsurance(HealthInsuranceEntity? value) {
    _$createdHealthInsuranceAtom
        .reportWrite(value, super.createdHealthInsurance, () {
      super.createdHealthInsurance = value;
    });
  }

  late final _$createHealthInsuranceAsyncAction = AsyncAction(
      '_CreateHealthInsuranceViewModelBase.createHealthInsurance',
      context: context);

  @override
  Future<void> createHealthInsurance() {
    return _$createHealthInsuranceAsyncAction
        .run(() => super.createHealthInsurance());
  }

  late final _$_CreateHealthInsuranceViewModelBaseActionController =
      ActionController(
          name: '_CreateHealthInsuranceViewModelBase', context: context);

  @override
  void setName(String value) {
    final _$actionInfo = _$_CreateHealthInsuranceViewModelBaseActionController
        .startAction(name: '_CreateHealthInsuranceViewModelBase.setName');
    try {
      return super.setName(value);
    } finally {
      _$_CreateHealthInsuranceViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo = _$_CreateHealthInsuranceViewModelBaseActionController
        .startAction(name: '_CreateHealthInsuranceViewModelBase.reset');
    try {
      return super.reset();
    } finally {
      _$_CreateHealthInsuranceViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
state: ${state},
errorMessage: ${errorMessage},
createdHealthInsurance: ${createdHealthInsurance},
isLoading: ${isLoading},
canSubmit: ${canSubmit}
    ''';
  }
}
