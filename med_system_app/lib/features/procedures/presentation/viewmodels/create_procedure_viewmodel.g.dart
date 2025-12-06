// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_procedure_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreateProcedureViewModel on _CreateProcedureViewModelBase, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_CreateProcedureViewModelBase.isLoading'))
          .value;
  Computed<bool>? _$canSubmitComputed;

  @override
  bool get canSubmit =>
      (_$canSubmitComputed ??= Computed<bool>(() => super.canSubmit,
              name: '_CreateProcedureViewModelBase.canSubmit'))
          .value;

  late final _$nameAtom =
      Atom(name: '_CreateProcedureViewModelBase.name', context: context);

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

  late final _$codeAtom =
      Atom(name: '_CreateProcedureViewModelBase.code', context: context);

  @override
  String get code {
    _$codeAtom.reportRead();
    return super.code;
  }

  @override
  set code(String value) {
    _$codeAtom.reportWrite(value, super.code, () {
      super.code = value;
    });
  }

  late final _$descriptionAtom =
      Atom(name: '_CreateProcedureViewModelBase.description', context: context);

  @override
  String get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  late final _$amountCentsAtom =
      Atom(name: '_CreateProcedureViewModelBase.amountCents', context: context);

  @override
  String get amountCents {
    _$amountCentsAtom.reportRead();
    return super.amountCents;
  }

  @override
  set amountCents(String value) {
    _$amountCentsAtom.reportWrite(value, super.amountCents, () {
      super.amountCents = value;
    });
  }

  late final _$stateAtom =
      Atom(name: '_CreateProcedureViewModelBase.state', context: context);

  @override
  CreateProcedureState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(CreateProcedureState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$errorMessageAtom = Atom(
      name: '_CreateProcedureViewModelBase.errorMessage', context: context);

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

  late final _$createdProcedureAtom = Atom(
      name: '_CreateProcedureViewModelBase.createdProcedure', context: context);

  @override
  ProcedureEntity? get createdProcedure {
    _$createdProcedureAtom.reportRead();
    return super.createdProcedure;
  }

  @override
  set createdProcedure(ProcedureEntity? value) {
    _$createdProcedureAtom.reportWrite(value, super.createdProcedure, () {
      super.createdProcedure = value;
    });
  }

  late final _$createProcedureAsyncAction = AsyncAction(
      '_CreateProcedureViewModelBase.createProcedure',
      context: context);

  @override
  Future<void> createProcedure() {
    return _$createProcedureAsyncAction.run(() => super.createProcedure());
  }

  late final _$_CreateProcedureViewModelBaseActionController =
      ActionController(name: '_CreateProcedureViewModelBase', context: context);

  @override
  void setName(String value) {
    final _$actionInfo = _$_CreateProcedureViewModelBaseActionController
        .startAction(name: '_CreateProcedureViewModelBase.setName');
    try {
      return super.setName(value);
    } finally {
      _$_CreateProcedureViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCode(String value) {
    final _$actionInfo = _$_CreateProcedureViewModelBaseActionController
        .startAction(name: '_CreateProcedureViewModelBase.setCode');
    try {
      return super.setCode(value);
    } finally {
      _$_CreateProcedureViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDescription(String value) {
    final _$actionInfo = _$_CreateProcedureViewModelBaseActionController
        .startAction(name: '_CreateProcedureViewModelBase.setDescription');
    try {
      return super.setDescription(value);
    } finally {
      _$_CreateProcedureViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAmountCents(String value) {
    final _$actionInfo = _$_CreateProcedureViewModelBaseActionController
        .startAction(name: '_CreateProcedureViewModelBase.setAmountCents');
    try {
      return super.setAmountCents(value);
    } finally {
      _$_CreateProcedureViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetState() {
    final _$actionInfo = _$_CreateProcedureViewModelBaseActionController
        .startAction(name: '_CreateProcedureViewModelBase.resetState');
    try {
      return super.resetState();
    } finally {
      _$_CreateProcedureViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo = _$_CreateProcedureViewModelBaseActionController
        .startAction(name: '_CreateProcedureViewModelBase.reset');
    try {
      return super.reset();
    } finally {
      _$_CreateProcedureViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
code: ${code},
description: ${description},
amountCents: ${amountCents},
state: ${state},
errorMessage: ${errorMessage},
createdProcedure: ${createdProcedure},
isLoading: ${isLoading},
canSubmit: ${canSubmit}
    ''';
  }
}
