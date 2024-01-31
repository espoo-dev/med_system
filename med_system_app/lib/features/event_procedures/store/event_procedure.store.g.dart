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

  late final _$_showAllAtom =
      Atom(name: '_EventProcedureStoreBase._showAll', context: context);

  @override
  bool get _showAll {
    _$_showAllAtom.reportRead();
    return super._showAll;
  }

  @override
  set _showAll(bool value) {
    _$_showAllAtom.reportWrite(value, super._showAll, () {
      super._showAll = value;
    });
  }

  late final _$_showPaidAtom =
      Atom(name: '_EventProcedureStoreBase._showPaid', context: context);

  @override
  bool get _showPaid {
    _$_showPaidAtom.reportRead();
    return super._showPaid;
  }

  @override
  set _showPaid(bool value) {
    _$_showPaidAtom.reportWrite(value, super._showPaid, () {
      super._showPaid = value;
    });
  }

  late final _$_showUnpaidAtom =
      Atom(name: '_EventProcedureStoreBase._showUnpaid', context: context);

  @override
  bool get _showUnpaid {
    _$_showUnpaidAtom.reportRead();
    return super._showUnpaid;
  }

  @override
  set _showUnpaid(bool value) {
    _$_showUnpaidAtom.reportWrite(value, super._showUnpaid, () {
      super._showUnpaid = value;
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
  void updateFilter(bool all, bool paid, bool unpaid) {
    final _$actionInfo = _$_EventProcedureStoreBaseActionController.startAction(
        name: '_EventProcedureStoreBase.updateFilter');
    try {
      return super.updateFilter(all, paid, unpaid);
    } finally {
      _$_EventProcedureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic getEventProcedures() {
    final _$actionInfo = _$_EventProcedureStoreBaseActionController.startAction(
        name: '_EventProcedureStoreBase.getEventProcedures');
    try {
      return super.getEventProcedures();
    } finally {
      _$_EventProcedureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

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
