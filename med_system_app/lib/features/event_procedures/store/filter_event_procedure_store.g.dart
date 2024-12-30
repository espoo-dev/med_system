// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_event_procedure_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FilterEventProcedureStore on _FilterEventProcedureStore, Store {
  late final _$stateAtom =
      Atom(name: '_FilterEventProcedureStore.state', context: context);

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

  late final _$editStateAtom =
      Atom(name: '_FilterEventProcedureStore.editState', context: context);

  @override
  EditEventProcedureState get editState {
    _$editStateAtom.reportRead();
    return super.editState;
  }

  @override
  set editState(EditEventProcedureState value) {
    _$editStateAtom.reportWrite(value, super.editState, () {
      super.editState = value;
    });
  }

  late final _$deleteSateAtom =
      Atom(name: '_FilterEventProcedureStore.deleteSate', context: context);

  @override
  DeleteEventProcedureState get deleteSate {
    _$deleteSateAtom.reportRead();
    return super.deleteSate;
  }

  @override
  set deleteSate(DeleteEventProcedureState value) {
    _$deleteSateAtom.reportWrite(value, super.deleteSate, () {
      super.deleteSate = value;
    });
  }

  late final _$_errorMessageAtom =
      Atom(name: '_FilterEventProcedureStore._errorMessage', context: context);

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
      Atom(name: '_FilterEventProcedureStore._page', context: context);

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

  late final _$_eventProcedureModelAtom = Atom(
      name: '_FilterEventProcedureStore._eventProcedureModel',
      context: context);

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

  late final _$selectedYearAtom =
      Atom(name: '_FilterEventProcedureStore.selectedYear', context: context);

  @override
  int? get selectedYear {
    _$selectedYearAtom.reportRead();
    return super.selectedYear;
  }

  @override
  set selectedYear(int? value) {
    _$selectedYearAtom.reportWrite(value, super.selectedYear, () {
      super.selectedYear = value;
    });
  }

  late final _$selectedMonthAtom =
      Atom(name: '_FilterEventProcedureStore.selectedMonth', context: context);

  @override
  int? get selectedMonth {
    _$selectedMonthAtom.reportRead();
    return super.selectedMonth;
  }

  @override
  set selectedMonth(int? value) {
    _$selectedMonthAtom.reportWrite(value, super.selectedMonth, () {
      super.selectedMonth = value;
    });
  }

  late final _$selectedPaymentStatusAtom = Atom(
      name: '_FilterEventProcedureStore.selectedPaymentStatus',
      context: context);

  @override
  bool? get selectedPaymentStatus {
    _$selectedPaymentStatusAtom.reportRead();
    return super.selectedPaymentStatus;
  }

  @override
  set selectedPaymentStatus(bool? value) {
    _$selectedPaymentStatusAtom.reportWrite(value, super.selectedPaymentStatus,
        () {
      super.selectedPaymentStatus = value;
    });
  }

  late final _$hospitalNameAtom =
      Atom(name: '_FilterEventProcedureStore.hospitalName', context: context);

  @override
  String? get hospitalName {
    _$hospitalNameAtom.reportRead();
    return super.hospitalName;
  }

  @override
  set hospitalName(String? value) {
    _$hospitalNameAtom.reportWrite(value, super.hospitalName, () {
      super.hospitalName = value;
    });
  }

  late final _$healthInsuranceNameAtom = Atom(
      name: '_FilterEventProcedureStore.healthInsuranceName', context: context);

  @override
  String? get healthInsuranceName {
    _$healthInsuranceNameAtom.reportRead();
    return super.healthInsuranceName;
  }

  @override
  set healthInsuranceName(String? value) {
    _$healthInsuranceNameAtom.reportWrite(value, super.healthInsuranceName, () {
      super.healthInsuranceName = value;
    });
  }

  late final _$getAllEventProceduresAsyncAction = AsyncAction(
      '_FilterEventProcedureStore.getAllEventProcedures',
      context: context);

  @override
  Future getAllEventProcedures({bool isRefresh = false}) {
    return _$getAllEventProceduresAsyncAction
        .run(() => super.getAllEventProcedures(isRefresh: isRefresh));
  }

  late final _$getAllEventProceduresByFiltersAsyncAction = AsyncAction(
      '_FilterEventProcedureStore.getAllEventProceduresByFilters',
      context: context);

  @override
  Future getAllEventProceduresByFilters() {
    return _$getAllEventProceduresByFiltersAsyncAction
        .run(() => super.getAllEventProceduresByFilters());
  }

  late final _$deleteEventProcedureAsyncAction = AsyncAction(
      '_FilterEventProcedureStore.deleteEventProcedure',
      context: context);

  @override
  Future deleteEventProcedure(int eventProcedureId, dynamic index) {
    return _$deleteEventProcedureAsyncAction
        .run(() => super.deleteEventProcedure(eventProcedureId, index));
  }

  late final _$editPaymentEventProcedureAsyncAction = AsyncAction(
      '_FilterEventProcedureStore.editPaymentEventProcedure',
      context: context);

  @override
  Future editPaymentEventProcedure(int eventProcedureId, dynamic index) {
    return _$editPaymentEventProcedureAsyncAction
        .run(() => super.editPaymentEventProcedure(eventProcedureId, index));
  }

  late final _$_FilterEventProcedureStoreActionController =
      ActionController(name: '_FilterEventProcedureStore', context: context);

  @override
  void setSelectedYear(int? year) {
    final _$actionInfo = _$_FilterEventProcedureStoreActionController
        .startAction(name: '_FilterEventProcedureStore.setSelectedYear');
    try {
      return super.setSelectedYear(year);
    } finally {
      _$_FilterEventProcedureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedMonth(int? month) {
    final _$actionInfo = _$_FilterEventProcedureStoreActionController
        .startAction(name: '_FilterEventProcedureStore.setSelectedMonth');
    try {
      return super.setSelectedMonth(month);
    } finally {
      _$_FilterEventProcedureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedPaymentStatus(bool? status) {
    final _$actionInfo =
        _$_FilterEventProcedureStoreActionController.startAction(
            name: '_FilterEventProcedureStore.setSelectedPaymentStatus');
    try {
      return super.setSelectedPaymentStatus(status);
    } finally {
      _$_FilterEventProcedureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHospitalName(String? name) {
    final _$actionInfo = _$_FilterEventProcedureStoreActionController
        .startAction(name: '_FilterEventProcedureStore.setHospitalName');
    try {
      return super.setHospitalName(name);
    } finally {
      _$_FilterEventProcedureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHealthInsuranceName(String? name) {
    final _$actionInfo = _$_FilterEventProcedureStoreActionController
        .startAction(name: '_FilterEventProcedureStore.setHealthInsuranceName');
    try {
      return super.setHealthInsuranceName(name);
    } finally {
      _$_FilterEventProcedureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearFilters() {
    final _$actionInfo = _$_FilterEventProcedureStoreActionController
        .startAction(name: '_FilterEventProcedureStore.clearFilters');
    try {
      return super.clearFilters();
    } finally {
      _$_FilterEventProcedureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic dispose() {
    final _$actionInfo = _$_FilterEventProcedureStoreActionController
        .startAction(name: '_FilterEventProcedureStore.dispose');
    try {
      return super.dispose();
    } finally {
      _$_FilterEventProcedureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state},
editState: ${editState},
deleteSate: ${deleteSate},
selectedYear: ${selectedYear},
selectedMonth: ${selectedMonth},
selectedPaymentStatus: ${selectedPaymentStatus},
hospitalName: ${hospitalName},
healthInsuranceName: ${healthInsuranceName}
    ''';
  }
}
