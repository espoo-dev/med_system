// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_procedure.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EventProcedureStore on _EventProcedureStoreBase, Store {
  late final _$stateAtom =
      Atom(name: '_EventProcedureStoreBase.state', context: context);

  @override
  EventProcedureState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(EventProcedureState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$_errorMessageAtom =
      Atom(name: '_EventProcedureStoreBase._errorMessage', context: context);

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

  late final _$_pageAtom =
      Atom(name: '_EventProcedureStoreBase._page', context: context);

  @override
  int get _page {
    _$_pageAtom.reportRead();
    return super._page;
  }

  @override
  set _page(int value) {
    _$_pageAtom.reportWrite(value, super._page, () {
      super._page = value;
    });
  }

  late final _$getAllEventProceduresAsyncAction = AsyncAction(
      '_EventProcedureStoreBase.getAllEventProcedures',
      context: context);

  @override
  Future getAllEventProcedures({bool isRefresh = false}) {
    return _$getAllEventProceduresAsyncAction
        .run(() => super.getAllEventProcedures(isRefresh: isRefresh));
  }

  late final _$_EventProcedureStoreBaseActionController =
      ActionController(name: '_EventProcedureStoreBase', context: context);

  @override
  dynamic dispose() {
    final _$actionInfo = _$_EventProcedureStoreBaseActionController.startAction(
        name: '_EventProcedureStoreBase.dispose');
    try {
      return super.dispose();
    } finally {
      _$_EventProcedureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
