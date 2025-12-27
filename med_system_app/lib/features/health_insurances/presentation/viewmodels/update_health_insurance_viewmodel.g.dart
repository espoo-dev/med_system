// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_health_insurance_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UpdateHealthInsuranceViewModel
    on _UpdateHealthInsuranceViewModelBase, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_UpdateHealthInsuranceViewModelBase.isLoading'))
          .value;
  Computed<bool>? _$canSubmitComputed;

  @override
  bool get canSubmit =>
      (_$canSubmitComputed ??= Computed<bool>(() => super.canSubmit,
              name: '_UpdateHealthInsuranceViewModelBase.canSubmit'))
          .value;

  late final _$idAtom =
      Atom(name: '_UpdateHealthInsuranceViewModelBase.id', context: context);

  @override
  int? get id {
    _$idAtom.reportRead();
    return super.id;
  }

  @override
  set id(int? value) {
    _$idAtom.reportWrite(value, super.id, () {
      super.id = value;
    });
  }

  late final _$nameAtom =
      Atom(name: '_UpdateHealthInsuranceViewModelBase.name', context: context);

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
      Atom(name: '_UpdateHealthInsuranceViewModelBase.state', context: context);

  @override
  UpdateHealthInsuranceState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(UpdateHealthInsuranceState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$errorMessageAtom = Atom(
      name: '_UpdateHealthInsuranceViewModelBase.errorMessage',
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

  late final _$updatedHealthInsuranceAtom = Atom(
      name: '_UpdateHealthInsuranceViewModelBase.updatedHealthInsurance',
      context: context);

  @override
  HealthInsuranceEntity? get updatedHealthInsurance {
    _$updatedHealthInsuranceAtom.reportRead();
    return super.updatedHealthInsurance;
  }

  @override
  set updatedHealthInsurance(HealthInsuranceEntity? value) {
    _$updatedHealthInsuranceAtom
        .reportWrite(value, super.updatedHealthInsurance, () {
      super.updatedHealthInsurance = value;
    });
  }

  late final _$updateHealthInsuranceAsyncAction = AsyncAction(
      '_UpdateHealthInsuranceViewModelBase.updateHealthInsurance',
      context: context);

  @override
  Future<void> updateHealthInsurance() {
    return _$updateHealthInsuranceAsyncAction
        .run(() => super.updateHealthInsurance());
  }

  late final _$_UpdateHealthInsuranceViewModelBaseActionController =
      ActionController(
          name: '_UpdateHealthInsuranceViewModelBase', context: context);

  @override
  void setHealthInsurance(HealthInsuranceEntity entity) {
    final _$actionInfo =
        _$_UpdateHealthInsuranceViewModelBaseActionController.startAction(
            name: '_UpdateHealthInsuranceViewModelBase.setHealthInsurance');
    try {
      return super.setHealthInsurance(entity);
    } finally {
      _$_UpdateHealthInsuranceViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setName(String value) {
    final _$actionInfo = _$_UpdateHealthInsuranceViewModelBaseActionController
        .startAction(name: '_UpdateHealthInsuranceViewModelBase.setName');
    try {
      return super.setName(value);
    } finally {
      _$_UpdateHealthInsuranceViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo = _$_UpdateHealthInsuranceViewModelBaseActionController
        .startAction(name: '_UpdateHealthInsuranceViewModelBase.reset');
    try {
      return super.reset();
    } finally {
      _$_UpdateHealthInsuranceViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
id: ${id},
name: ${name},
state: ${state},
errorMessage: ${errorMessage},
updatedHealthInsurance: ${updatedHealthInsurance},
isLoading: ${isLoading},
canSubmit: ${canSubmit}
    ''';
  }
}
