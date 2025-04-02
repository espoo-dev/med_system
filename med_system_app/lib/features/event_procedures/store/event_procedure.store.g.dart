// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_procedure.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EventProcedureStore on _EventProcedureStore, Store {
  late final _$filterStateAtom =
      Atom(name: '_EventProcedureStore.filterState', context: context);

  @override
  FilterProcedureState get filterState {
    _$filterStateAtom.reportRead();
    return super.filterState;
  }

  @override
  set filterState(FilterProcedureState value) {
    _$filterStateAtom.reportWrite(value, super.filterState, () {
      super.filterState = value;
    });
  }

  late final _$stateAtom =
      Atom(name: '_EventProcedureStore.state', context: context);

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
      Atom(name: '_EventProcedureStore.editState', context: context);

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
      Atom(name: '_EventProcedureStore.deleteSate', context: context);

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

  late final _$_hospitalAtom =
      Atom(name: '_EventProcedureStore._hospital', context: context);

  @override
  Hospital? get _hospital {
    _$_hospitalAtom.reportRead();
    return super._hospital;
  }

  @override
  set _hospital(Hospital? value) {
    _$_hospitalAtom.reportWrite(value, super._hospital, () {
      super._hospital = value;
    });
  }

  late final _$pdfStateAtom =
      Atom(name: '_EventProcedureStore.pdfState', context: context);

  @override
  PdfReportState get pdfState {
    _$pdfStateAtom.reportRead();
    return super.pdfState;
  }

  @override
  set pdfState(PdfReportState value) {
    _$pdfStateAtom.reportWrite(value, super.pdfState, () {
      super.pdfState = value;
    });
  }

  late final _$pdfErrorMessageAtom =
      Atom(name: '_EventProcedureStore.pdfErrorMessage', context: context);

  @override
  String get pdfErrorMessage {
    _$pdfErrorMessageAtom.reportRead();
    return super.pdfErrorMessage;
  }

  @override
  set pdfErrorMessage(String value) {
    _$pdfErrorMessageAtom.reportWrite(value, super.pdfErrorMessage, () {
      super.pdfErrorMessage = value;
    });
  }

  late final _$_pdfPathAtom =
      Atom(name: '_EventProcedureStore._pdfPath', context: context);

  @override
  String get _pdfPath {
    _$_pdfPathAtom.reportRead();
    return super._pdfPath;
  }

  @override
  set _pdfPath(String value) {
    _$_pdfPathAtom.reportWrite(value, super._pdfPath, () {
      super._pdfPath = value;
    });
  }

  late final _$_errorMessageAtom =
      Atom(name: '_EventProcedureStore._errorMessage', context: context);

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
      Atom(name: '_EventProcedureStore._page', context: context);

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

  late final _$_eventProcedureModelAtom =
      Atom(name: '_EventProcedureStore._eventProcedureModel', context: context);

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
      Atom(name: '_EventProcedureStore.selectedYear', context: context);

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
      Atom(name: '_EventProcedureStore.selectedMonth', context: context);

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
      name: '_EventProcedureStore.selectedPaymentStatus', context: context);

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
      Atom(name: '_EventProcedureStore.hospitalName', context: context);

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

  late final _$healthInsuranceNameAtom =
      Atom(name: '_EventProcedureStore.healthInsuranceName', context: context);

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

  late final _$_healthInsuranceAtom =
      Atom(name: '_EventProcedureStore._healthInsurance', context: context);

  @override
  HealthInsurance? get _healthInsurance {
    _$_healthInsuranceAtom.reportRead();
    return super._healthInsurance;
  }

  @override
  set _healthInsurance(HealthInsurance? value) {
    _$_healthInsuranceAtom.reportWrite(value, super._healthInsurance, () {
      super._healthInsurance = value;
    });
  }

  late final _$fetchAllDataAsyncAction =
      AsyncAction('_EventProcedureStore.fetchAllData', context: context);

  @override
  Future fetchAllData() {
    return _$fetchAllDataAsyncAction.run(() => super.fetchAllData());
  }

  late final _$getAllEventProceduresAsyncAction = AsyncAction(
      '_EventProcedureStore.getAllEventProcedures',
      context: context);

  @override
  Future getAllEventProcedures({bool isRefresh = false, int perPage = 10000}) {
    return _$getAllEventProceduresAsyncAction.run(() =>
        super.getAllEventProcedures(isRefresh: isRefresh, perPage: perPage));
  }

  late final _$getAllEventProceduresByFiltersAsyncAction = AsyncAction(
      '_EventProcedureStore.getAllEventProceduresByFilters',
      context: context);

  @override
  Future getAllEventProceduresByFilters() {
    return _$getAllEventProceduresByFiltersAsyncAction
        .run(() => super.getAllEventProceduresByFilters());
  }

  late final _$deleteEventProcedureAsyncAction = AsyncAction(
      '_EventProcedureStore.deleteEventProcedure',
      context: context);

  @override
  Future deleteEventProcedure(int eventProcedureId, dynamic index) {
    return _$deleteEventProcedureAsyncAction
        .run(() => super.deleteEventProcedure(eventProcedureId, index));
  }

  late final _$editPaymentEventProcedureAsyncAction = AsyncAction(
      '_EventProcedureStore.editPaymentEventProcedure',
      context: context);

  @override
  Future editPaymentEventProcedure(int eventProcedureId, dynamic index) {
    return _$editPaymentEventProcedureAsyncAction
        .run(() => super.editPaymentEventProcedure(eventProcedureId, index));
  }

  late final _$generatePdfReportForEventProcedureAsyncAction = AsyncAction(
      '_EventProcedureStore.generatePdfReportForEventProcedure',
      context: context);

  @override
  Future<void> generatePdfReportForEventProcedure() {
    return _$generatePdfReportForEventProcedureAsyncAction
        .run(() => super.generatePdfReportForEventProcedure());
  }

  late final _$getAllHospitalsAsyncAction =
      AsyncAction('_EventProcedureStore.getAllHospitals', context: context);

  @override
  Future<dynamic> getAllHospitals() {
    return _$getAllHospitalsAsyncAction.run(() => super.getAllHospitals());
  }

  late final _$getAllHealthInsurancesAsyncAction = AsyncAction(
      '_EventProcedureStore.getAllHealthInsurances',
      context: context);

  @override
  Future<dynamic> getAllHealthInsurances() {
    return _$getAllHealthInsurancesAsyncAction
        .run(() => super.getAllHealthInsurances());
  }

  late final _$_EventProcedureStoreActionController =
      ActionController(name: '_EventProcedureStore', context: context);

  @override
  void setSelectedYear(int? year) {
    final _$actionInfo = _$_EventProcedureStoreActionController.startAction(
        name: '_EventProcedureStore.setSelectedYear');
    try {
      return super.setSelectedYear(year);
    } finally {
      _$_EventProcedureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedMonth(int? month) {
    final _$actionInfo = _$_EventProcedureStoreActionController.startAction(
        name: '_EventProcedureStore.setSelectedMonth');
    try {
      return super.setSelectedMonth(month);
    } finally {
      _$_EventProcedureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedPaymentStatus(bool? status) {
    final _$actionInfo = _$_EventProcedureStoreActionController.startAction(
        name: '_EventProcedureStore.setSelectedPaymentStatus');
    try {
      return super.setSelectedPaymentStatus(status);
    } finally {
      _$_EventProcedureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHospitalName(Hospital hospital) {
    final _$actionInfo = _$_EventProcedureStoreActionController.startAction(
        name: '_EventProcedureStore.setHospitalName');
    try {
      return super.setHospitalName(hospital);
    } finally {
      _$_EventProcedureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHealthInsuranceName(HealthInsurance healthInsurance) {
    final _$actionInfo = _$_EventProcedureStoreActionController.startAction(
        name: '_EventProcedureStore.setHealthInsuranceName');
    try {
      return super.setHealthInsuranceName(healthInsurance);
    } finally {
      _$_EventProcedureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearFilters() {
    final _$actionInfo = _$_EventProcedureStoreActionController.startAction(
        name: '_EventProcedureStore.clearFilters');
    try {
      return super.clearFilters();
    } finally {
      _$_EventProcedureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic dispose() {
    final _$actionInfo = _$_EventProcedureStoreActionController.startAction(
        name: '_EventProcedureStore.dispose');
    try {
      return super.dispose();
    } finally {
      _$_EventProcedureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
filterState: ${filterState},
state: ${state},
editState: ${editState},
deleteSate: ${deleteSate},
pdfState: ${pdfState},
pdfErrorMessage: ${pdfErrorMessage},
selectedYear: ${selectedYear},
selectedMonth: ${selectedMonth},
selectedPaymentStatus: ${selectedPaymentStatus},
hospitalName: ${hospitalName},
healthInsuranceName: ${healthInsuranceName}
    ''';
  }
}
