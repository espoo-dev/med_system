// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_procedure.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EditProcedureStore on _EditProcedureStoreBase, Store {
  Computed<bool>? _$isValidDataComputed;

  @override
  bool get isValidData =>
      (_$isValidDataComputed ??= Computed<bool>(() => super.isValidData,
              name: '_EditProcedureStoreBase.isValidData'))
          .value;

  late final _$saveStateAtom =
      Atom(name: '_EditProcedureStoreBase.saveState', context: context);

  @override
  SaveProcedureState get saveState {
    _$saveStateAtom.reportRead();
    return super.saveState;
  }

  @override
  set saveState(SaveProcedureState value) {
    _$saveStateAtom.reportWrite(value, super.saveState, () {
      super.saveState = value;
    });
  }

  late final _$_errorMessageAtom =
      Atom(name: '_EditProcedureStoreBase._errorMessage', context: context);

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
      Atom(name: '_EditProcedureStoreBase._name', context: context);

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

  late final _$_codeAtom =
      Atom(name: '_EditProcedureStoreBase._code', context: context);

  @override
  String get _code {
    _$_codeAtom.reportRead();
    return super._code;
  }

  @override
  set _code(String value) {
    _$_codeAtom.reportWrite(value, super._code, () {
      super._code = value;
    });
  }

  late final _$_descriptionAtom =
      Atom(name: '_EditProcedureStoreBase._description', context: context);

  @override
  String get _description {
    _$_descriptionAtom.reportRead();
    return super._description;
  }

  @override
  set _description(String value) {
    _$_descriptionAtom.reportWrite(value, super._description, () {
      super._description = value;
    });
  }

  late final _$_amountCentsAtom =
      Atom(name: '_EditProcedureStoreBase._amountCents', context: context);

  @override
  String get _amountCents {
    _$_amountCentsAtom.reportRead();
    return super._amountCents;
  }

  @override
  set _amountCents(String value) {
    _$_amountCentsAtom.reportWrite(value, super._amountCents, () {
      super._amountCents = value;
    });
  }

  late final _$editProcedureAsyncAction =
      AsyncAction('_EditProcedureStoreBase.editProcedure', context: context);

  @override
  Future editProcedure(int idProcedure) {
    return _$editProcedureAsyncAction
        .run(() => super.editProcedure(idProcedure));
  }

  late final _$_EditProcedureStoreBaseActionController =
      ActionController(name: '_EditProcedureStoreBase', context: context);

  @override
  void setName(String name) {
    final _$actionInfo = _$_EditProcedureStoreBaseActionController.startAction(
        name: '_EditProcedureStoreBase.setName');
    try {
      return super.setName(name);
    } finally {
      _$_EditProcedureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCode(String code) {
    final _$actionInfo = _$_EditProcedureStoreBaseActionController.startAction(
        name: '_EditProcedureStoreBase.setCode');
    try {
      return super.setCode(code);
    } finally {
      _$_EditProcedureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDescription(String description) {
    final _$actionInfo = _$_EditProcedureStoreBaseActionController.startAction(
        name: '_EditProcedureStoreBase.setDescription');
    try {
      return super.setDescription(description);
    } finally {
      _$_EditProcedureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAmountCents(String amountCents) {
    final _$actionInfo = _$_EditProcedureStoreBaseActionController.startAction(
        name: '_EditProcedureStoreBase.setAmountCents');
    try {
      return super.setAmountCents(amountCents);
    } finally {
      _$_EditProcedureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic getAllData(Procedure procedure) {
    final _$actionInfo = _$_EditProcedureStoreBaseActionController.startAction(
        name: '_EditProcedureStoreBase.getAllData');
    try {
      return super.getAllData(procedure);
    } finally {
      _$_EditProcedureStoreBaseActionController.endAction(_$actionInfo);
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
