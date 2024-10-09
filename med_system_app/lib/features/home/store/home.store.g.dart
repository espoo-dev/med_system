// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on _HomeStoreBase, Store {
  Computed<bool>? _$showBottomAppBarComputed;

  @override
  bool get showBottomAppBar => (_$showBottomAppBarComputed ??= Computed<bool>(
          () => super.showBottomAppBar,
          name: '_HomeStoreBase.showBottomAppBar'))
      .value;
  Computed<bool>? _$showFloatingActionButtonComputed;

  @override
  bool get showFloatingActionButton => (_$showFloatingActionButtonComputed ??=
          Computed<bool>(() => super.showFloatingActionButton,
              name: '_HomeStoreBase.showFloatingActionButton'))
      .value;

  late final _$_medicalShiftAtom =
      Atom(name: '_HomeStoreBase._medicalShift', context: context);

  @override
  MedicalShiftList? get _medicalShift {
    _$_medicalShiftAtom.reportRead();
    return super._medicalShift;
  }

  @override
  set _medicalShift(MedicalShiftList? value) {
    _$_medicalShiftAtom.reportWrite(value, super._medicalShift, () {
      super._medicalShift = value;
    });
  }

  late final _$stateAtom = Atom(name: '_HomeStoreBase.state', context: context);

  @override
  HomeState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(HomeState value) {
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

  late final _$selectedFilterAtom =
      Atom(name: '_HomeStoreBase.selectedFilter', context: context);

  @override
  HomeFilterType get selectedFilter {
    _$selectedFilterAtom.reportRead();
    return super.selectedFilter;
  }

  @override
  set selectedFilter(HomeFilterType value) {
    _$selectedFilterAtom.reportWrite(value, super.selectedFilter, () {
      super.selectedFilter = value;
    });
  }

  late final _$fetchAllDataAsyncAction =
      AsyncAction('_HomeStoreBase.fetchAllData', context: context);

  @override
  Future fetchAllData() {
    return _$fetchAllDataAsyncAction.run(() => super.fetchAllData());
  }

  late final _$getLatestEventProceduresAsyncAction =
      AsyncAction('_HomeStoreBase.getLatestEventProcedures', context: context);

  @override
  Future<dynamic> getLatestEventProcedures() {
    return _$getLatestEventProceduresAsyncAction
        .run(() => super.getLatestEventProcedures());
  }

  late final _$getLatestMedicalShiftsAsyncAction =
      AsyncAction('_HomeStoreBase.getLatestMedicalShifts', context: context);

  @override
  Future<dynamic> getLatestMedicalShifts() {
    return _$getLatestMedicalShiftsAsyncAction
        .run(() => super.getLatestMedicalShifts());
  }

  late final _$_HomeStoreBaseActionController =
      ActionController(name: '_HomeStoreBase', context: context);

  @override
  void setSelectedFilter(HomeFilterType filter) {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction(
        name: '_HomeStoreBase.setSelectedFilter');
    try {
      return super.setSelectedFilter(filter);
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

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
state: ${state},
selectedFilter: ${selectedFilter},
showBottomAppBar: ${showBottomAppBar},
showFloatingActionButton: ${showFloatingActionButton}
    ''';
  }
}
