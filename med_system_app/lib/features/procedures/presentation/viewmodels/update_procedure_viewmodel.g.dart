// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_procedure_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UpdateProcedureViewModel on _UpdateProcedureViewModelBase, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_UpdateProcedureViewModelBase.isLoading'))
          .value;
  Computed<bool>? _$canSubmitComputed;

  @override
  bool get canSubmit =>
      (_$canSubmitComputed ??= Computed<bool>(() => super.canSubmit,
              name: '_UpdateProcedureViewModelBase.canSubmit'))
          .value;

  late final _$procedureIdAtom =
      Atom(name: '_UpdateProcedureViewModelBase.procedureId', context: context);

  @override
  int? get procedureId {
    _$procedureIdAtom.reportRead();
    return super.procedureId;
  }

  @override
  set procedureId(int? value) {
    _$procedureIdAtom.reportWrite(value, super.procedureId, () {
      super.procedureId = value;
    });
  }

  late final _$nameAtom =
      Atom(name: '_UpdateProcedureViewModelBase.name', context: context);

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
      Atom(name: '_UpdateProcedureViewModelBase.code', context: context);

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
      Atom(name: '_UpdateProcedureViewModelBase.description', context: context);

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
      Atom(name: '_UpdateProcedureViewModelBase.amountCents', context: context);

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
      Atom(name: '_UpdateProcedureViewModelBase.state', context: context);

  @override
  UpdateProcedureState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(UpdateProcedureState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$errorMessageAtom = Atom(
      name: '_UpdateProcedureViewModelBase.errorMessage', context: context);

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

  late final _$updatedProcedureAtom = Atom(
      name: '_UpdateProcedureViewModelBase.updatedProcedure', context: context);

  @override
  ProcedureEntity? get updatedProcedure {
    _$updatedProcedureAtom.reportRead();
    return super.updatedProcedure;
  }

  @override
  set updatedProcedure(ProcedureEntity? value) {
    _$updatedProcedureAtom.reportWrite(value, super.updatedProcedure, () {
      super.updatedProcedure = value;
    });
  }

  late final _$updateProcedureAsyncAction = AsyncAction(
      '_UpdateProcedureViewModelBase.updateProcedure',
      context: context);

  @override
  Future<void> updateProcedure() {
    return _$updateProcedureAsyncAction.run(() => super.updateProcedure());
  }

  late final _$_UpdateProcedureViewModelBaseActionController =
      ActionController(name: '_UpdateProcedureViewModelBase', context: context);

  @override
  void setProcedureId(int id) {
    final _$actionInfo = _$_UpdateProcedureViewModelBaseActionController
        .startAction(name: '_UpdateProcedureViewModelBase.setProcedureId');
    try {
      return super.setProcedureId(id);
    } finally {
      _$_UpdateProcedureViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setName(String value) {
    final _$actionInfo = _$_UpdateProcedureViewModelBaseActionController
        .startAction(name: '_UpdateProcedureViewModelBase.setName');
    try {
      return super.setName(value);
    } finally {
      _$_UpdateProcedureViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCode(String value) {
    final _$actionInfo = _$_UpdateProcedureViewModelBaseActionController
        .startAction(name: '_UpdateProcedureViewModelBase.setCode');
    try {
      return super.setCode(value);
    } finally {
      _$_UpdateProcedureViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDescription(String value) {
    final _$actionInfo = _$_UpdateProcedureViewModelBaseActionController
        .startAction(name: '_UpdateProcedureViewModelBase.setDescription');
    try {
      return super.setDescription(value);
    } finally {
      _$_UpdateProcedureViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAmountCents(String value) {
    final _$actionInfo = _$_UpdateProcedureViewModelBaseActionController
        .startAction(name: '_UpdateProcedureViewModelBase.setAmountCents');
    try {
      return super.setAmountCents(value);
    } finally {
      _$_UpdateProcedureViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadProcedure(ProcedureEntity procedure) {
    final _$actionInfo = _$_UpdateProcedureViewModelBaseActionController
        .startAction(name: '_UpdateProcedureViewModelBase.loadProcedure');
    try {
      return super.loadProcedure(procedure);
    } finally {
      _$_UpdateProcedureViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetState() {
    final _$actionInfo = _$_UpdateProcedureViewModelBaseActionController
        .startAction(name: '_UpdateProcedureViewModelBase.resetState');
    try {
      return super.resetState();
    } finally {
      _$_UpdateProcedureViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo = _$_UpdateProcedureViewModelBaseActionController
        .startAction(name: '_UpdateProcedureViewModelBase.reset');
    try {
      return super.reset();
    } finally {
      _$_UpdateProcedureViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
procedureId: ${procedureId},
name: ${name},
code: ${code},
description: ${description},
amountCents: ${amountCents},
state: ${state},
errorMessage: ${errorMessage},
updatedProcedure: ${updatedProcedure},
isLoading: ${isLoading},
canSubmit: ${canSubmit}
    ''';
  }
}
