// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'procedure.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProcedureStore on _ProcedureStoreBase, Store {
  late final _$stateAtom =
      Atom(name: '_ProcedureStoreBase.state', context: context);

  @override
  ProcedureState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(ProcedureState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$_errorMessageAtom =
      Atom(name: '_ProcedureStoreBase._errorMessage', context: context);

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

  late final _$getAllProceduresAsyncAction =
      AsyncAction('_ProcedureStoreBase.getAllProcedures', context: context);

  @override
  Future<dynamic> getAllProcedures() {
    return _$getAllProceduresAsyncAction.run(() => super.getAllProcedures());
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
