// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'procedure_list_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProcedureListViewModel on _ProcedureListViewModelBase, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_ProcedureListViewModelBase.isLoading'))
          .value;
  Computed<bool>? _$hasProceduresComputed;

  @override
  bool get hasProcedures =>
      (_$hasProceduresComputed ??= Computed<bool>(() => super.hasProcedures,
              name: '_ProcedureListViewModelBase.hasProcedures'))
          .value;
  Computed<int>? _$proceduresCountComputed;

  @override
  int get proceduresCount =>
      (_$proceduresCountComputed ??= Computed<int>(() => super.proceduresCount,
              name: '_ProcedureListViewModelBase.proceduresCount'))
          .value;

  late final _$proceduresAtom =
      Atom(name: '_ProcedureListViewModelBase.procedures', context: context);

  @override
  ObservableList<ProcedureEntity> get procedures {
    _$proceduresAtom.reportRead();
    return super.procedures;
  }

  @override
  set procedures(ObservableList<ProcedureEntity> value) {
    _$proceduresAtom.reportWrite(value, super.procedures, () {
      super.procedures = value;
    });
  }

  late final _$stateAtom =
      Atom(name: '_ProcedureListViewModelBase.state', context: context);

  @override
  ProcedureListState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(ProcedureListState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_ProcedureListViewModelBase.errorMessage', context: context);

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

  late final _$currentPageAtom =
      Atom(name: '_ProcedureListViewModelBase.currentPage', context: context);

  @override
  int get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(int value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  late final _$perPageAtom =
      Atom(name: '_ProcedureListViewModelBase.perPage', context: context);

  @override
  int get perPage {
    _$perPageAtom.reportRead();
    return super.perPage;
  }

  @override
  set perPage(int value) {
    _$perPageAtom.reportWrite(value, super.perPage, () {
      super.perPage = value;
    });
  }

  late final _$loadProceduresAsyncAction = AsyncAction(
      '_ProcedureListViewModelBase.loadProcedures',
      context: context);

  @override
  Future<void> loadProcedures({bool refresh = false}) {
    return _$loadProceduresAsyncAction
        .run(() => super.loadProcedures(refresh: refresh));
  }

  late final _$_ProcedureListViewModelBaseActionController =
      ActionController(name: '_ProcedureListViewModelBase', context: context);

  @override
  void resetState() {
    final _$actionInfo = _$_ProcedureListViewModelBaseActionController
        .startAction(name: '_ProcedureListViewModelBase.resetState');
    try {
      return super.resetState();
    } finally {
      _$_ProcedureListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void dispose() {
    final _$actionInfo = _$_ProcedureListViewModelBaseActionController
        .startAction(name: '_ProcedureListViewModelBase.dispose');
    try {
      return super.dispose();
    } finally {
      _$_ProcedureListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
procedures: ${procedures},
state: ${state},
errorMessage: ${errorMessage},
currentPage: ${currentPage},
perPage: ${perPage},
isLoading: ${isLoading},
hasProcedures: ${hasProcedures},
proceduresCount: ${proceduresCount}
    ''';
  }
}
