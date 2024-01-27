// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on _HomeStoreBase, Store {
  late final _$stateAtom = Atom(name: '_HomeStoreBase.state', context: context);

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
      Atom(name: '_HomeStoreBase._errorMessage', context: context);

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

  late final _$_eventProcedureModelAtom =
      Atom(name: '_HomeStoreBase._eventProcedureModel', context: context);

  @override
  EventProcedureModel? get _eventProcedureModel {
    _$_eventProcedureModelAtom.reportRead();
    return super._eventProcedureModel;
  }

  @override
  set _eventProcedureModel(EventProcedureModel? value) {
    _$_eventProcedureModelAtom.reportWrite(value, super._eventProcedureModel,
        () {
      super._eventProcedureModel = value;
    });
  }

  late final _$getLatestEventProceduresAsyncAction =
      AsyncAction('_HomeStoreBase.getLatestEventProcedures', context: context);

  @override
  Future getLatestEventProcedures() {
    return _$getLatestEventProceduresAsyncAction
        .run(() => super.getLatestEventProcedures());
  }

  late final _$_HomeStoreBaseActionController =
      ActionController(name: '_HomeStoreBase', context: context);

  @override
  dynamic dispose() {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction(
        name: '_HomeStoreBase.dispose');
    try {
      return super.dispose();
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
