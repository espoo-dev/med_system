// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medical_shifts_list_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MedicalShiftsListViewModel on _MedicalShiftsListViewModelBase, Store {
  late final _$medicalShiftsAtom = Atom(
      name: '_MedicalShiftsListViewModelBase.medicalShifts', context: context);

  @override
  ObservableList<MedicalShiftEntity> get medicalShifts {
    _$medicalShiftsAtom.reportRead();
    return super.medicalShifts;
  }

  @override
  set medicalShifts(ObservableList<MedicalShiftEntity> value) {
    _$medicalShiftsAtom.reportWrite(value, super.medicalShifts, () {
      super.medicalShifts = value;
    });
  }

  late final _$allShiftsForCalendarAtom = Atom(
      name: '_MedicalShiftsListViewModelBase.allShiftsForCalendar',
      context: context);

  @override
  ObservableList<MedicalShiftEntity> get allShiftsForCalendar {
    _$allShiftsForCalendarAtom.reportRead();
    return super.allShiftsForCalendar;
  }

  @override
  set allShiftsForCalendar(ObservableList<MedicalShiftEntity> value) {
    _$allShiftsForCalendarAtom.reportWrite(value, super.allShiftsForCalendar,
        () {
      super.allShiftsForCalendar = value;
    });
  }

  late final _$stateAtom =
      Atom(name: '_MedicalShiftsListViewModelBase.state', context: context);

  @override
  MedicalShiftListState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(MedicalShiftListState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$errorMessageAtom = Atom(
      name: '_MedicalShiftsListViewModelBase.errorMessage', context: context);

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

  late final _$pageAtom =
      Atom(name: '_MedicalShiftsListViewModelBase.page', context: context);

  @override
  int get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(int value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  late final _$selectedMonthAtom = Atom(
      name: '_MedicalShiftsListViewModelBase.selectedMonth', context: context);

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

  late final _$selectedYearAtom = Atom(
      name: '_MedicalShiftsListViewModelBase.selectedYear', context: context);

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

  late final _$selectedPaymentStatusAtom = Atom(
      name: '_MedicalShiftsListViewModelBase.selectedPaymentStatus',
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

  late final _$hospitalNameFilterAtom = Atom(
      name: '_MedicalShiftsListViewModelBase.hospitalNameFilter',
      context: context);

  @override
  String? get hospitalNameFilter {
    _$hospitalNameFilterAtom.reportRead();
    return super.hospitalNameFilter;
  }

  @override
  set hospitalNameFilter(String? value) {
    _$hospitalNameFilterAtom.reportWrite(value, super.hospitalNameFilter, () {
      super.hospitalNameFilter = value;
    });
  }

  late final _$selectedDateDisplayAtom = Atom(
      name: '_MedicalShiftsListViewModelBase.selectedDateDisplay',
      context: context);

  @override
  DateTime? get selectedDateDisplay {
    _$selectedDateDisplayAtom.reportRead();
    return super.selectedDateDisplay;
  }

  @override
  set selectedDateDisplay(DateTime? value) {
    _$selectedDateDisplayAtom.reportWrite(value, super.selectedDateDisplay, () {
      super.selectedDateDisplay = value;
    });
  }

  late final _$totalAmountAtom = Atom(
      name: '_MedicalShiftsListViewModelBase.totalAmount', context: context);

  @override
  String? get totalAmount {
    _$totalAmountAtom.reportRead();
    return super.totalAmount;
  }

  @override
  set totalAmount(String? value) {
    _$totalAmountAtom.reportWrite(value, super.totalAmount, () {
      super.totalAmount = value;
    });
  }

  late final _$totalPaidAtom =
      Atom(name: '_MedicalShiftsListViewModelBase.totalPaid', context: context);

  @override
  String? get totalPaid {
    _$totalPaidAtom.reportRead();
    return super.totalPaid;
  }

  @override
  set totalPaid(String? value) {
    _$totalPaidAtom.reportWrite(value, super.totalPaid, () {
      super.totalPaid = value;
    });
  }

  late final _$totalUnpaidAtom = Atom(
      name: '_MedicalShiftsListViewModelBase.totalUnpaid', context: context);

  @override
  String? get totalUnpaid {
    _$totalUnpaidAtom.reportRead();
    return super.totalUnpaid;
  }

  @override
  set totalUnpaid(String? value) {
    _$totalUnpaidAtom.reportWrite(value, super.totalUnpaid, () {
      super.totalUnpaid = value;
    });
  }

  late final _$isGeneratingPdfAtom = Atom(
      name: '_MedicalShiftsListViewModelBase.isGeneratingPdf',
      context: context);

  @override
  bool get isGeneratingPdf {
    _$isGeneratingPdfAtom.reportRead();
    return super.isGeneratingPdf;
  }

  @override
  set isGeneratingPdf(bool value) {
    _$isGeneratingPdfAtom.reportWrite(value, super.isGeneratingPdf, () {
      super.isGeneratingPdf = value;
    });
  }

  late final _$deleteStateAtom = Atom(
      name: '_MedicalShiftsListViewModelBase.deleteState', context: context);

  @override
  MedicalShiftDeleteState get deleteState {
    _$deleteStateAtom.reportRead();
    return super.deleteState;
  }

  @override
  set deleteState(MedicalShiftDeleteState value) {
    _$deleteStateAtom.reportWrite(value, super.deleteState, () {
      super.deleteState = value;
    });
  }

  late final _$pdfPathAtom =
      Atom(name: '_MedicalShiftsListViewModelBase.pdfPath', context: context);

  @override
  String? get pdfPath {
    _$pdfPathAtom.reportRead();
    return super.pdfPath;
  }

  @override
  set pdfPath(String? value) {
    _$pdfPathAtom.reportWrite(value, super.pdfPath, () {
      super.pdfPath = value;
    });
  }

  late final _$loadMedicalShiftsAsyncAction = AsyncAction(
      '_MedicalShiftsListViewModelBase.loadMedicalShifts',
      context: context);

  @override
  Future<void> loadMedicalShifts({bool isRefresh = false}) {
    return _$loadMedicalShiftsAsyncAction
        .run(() => super.loadMedicalShifts(isRefresh: isRefresh));
  }

  late final _$deleteMedicalShiftAsyncAction = AsyncAction(
      '_MedicalShiftsListViewModelBase.deleteMedicalShift',
      context: context);

  @override
  Future<void> deleteMedicalShift(int id, int index, {int? recurrenceId}) {
    return _$deleteMedicalShiftAsyncAction.run(
        () => super.deleteMedicalShift(id, index, recurrenceId: recurrenceId));
  }

  late final _$markAsPaidAsyncAction = AsyncAction(
      '_MedicalShiftsListViewModelBase.markAsPaid',
      context: context);

  @override
  Future<void> markAsPaid(int id, int index) {
    return _$markAsPaidAsyncAction.run(() => super.markAsPaid(id, index));
  }

  late final _$generatePdfAsyncAction = AsyncAction(
      '_MedicalShiftsListViewModelBase.generatePdf',
      context: context);

  @override
  Future<void> generatePdf() {
    return _$generatePdfAsyncAction.run(() => super.generatePdf());
  }

  late final _$_MedicalShiftsListViewModelBaseActionController =
      ActionController(
          name: '_MedicalShiftsListViewModelBase', context: context);

  @override
  void init() {
    final _$actionInfo = _$_MedicalShiftsListViewModelBaseActionController
        .startAction(name: '_MedicalShiftsListViewModelBase.init');
    try {
      return super.init();
    } finally {
      _$_MedicalShiftsListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMonthAndYear(int month, int year) {
    final _$actionInfo = _$_MedicalShiftsListViewModelBaseActionController
        .startAction(name: '_MedicalShiftsListViewModelBase.setMonthAndYear');
    try {
      return super.setMonthAndYear(month, year);
    } finally {
      _$_MedicalShiftsListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void filterByDate(DateTime date) {
    final _$actionInfo = _$_MedicalShiftsListViewModelBaseActionController
        .startAction(name: '_MedicalShiftsListViewModelBase.filterByDate');
    try {
      return super.filterByDate(date);
    } finally {
      _$_MedicalShiftsListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedYear(int? year) {
    final _$actionInfo = _$_MedicalShiftsListViewModelBaseActionController
        .startAction(name: '_MedicalShiftsListViewModelBase.setSelectedYear');
    try {
      return super.setSelectedYear(year);
    } finally {
      _$_MedicalShiftsListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedMonth(int? month) {
    final _$actionInfo = _$_MedicalShiftsListViewModelBaseActionController
        .startAction(name: '_MedicalShiftsListViewModelBase.setSelectedMonth');
    try {
      return super.setSelectedMonth(month);
    } finally {
      _$_MedicalShiftsListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedPaymentStatus(bool? status) {
    final _$actionInfo =
        _$_MedicalShiftsListViewModelBaseActionController.startAction(
            name: '_MedicalShiftsListViewModelBase.setSelectedPaymentStatus');
    try {
      return super.setSelectedPaymentStatus(status);
    } finally {
      _$_MedicalShiftsListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHospitalNameFilter(String? name) {
    final _$actionInfo =
        _$_MedicalShiftsListViewModelBaseActionController.startAction(
            name: '_MedicalShiftsListViewModelBase.setHospitalNameFilter');
    try {
      return super.setHospitalNameFilter(name);
    } finally {
      _$_MedicalShiftsListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearFilters() {
    final _$actionInfo = _$_MedicalShiftsListViewModelBaseActionController
        .startAction(name: '_MedicalShiftsListViewModelBase.clearFilters');
    try {
      return super.clearFilters();
    } finally {
      _$_MedicalShiftsListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
medicalShifts: ${medicalShifts},
allShiftsForCalendar: ${allShiftsForCalendar},
state: ${state},
errorMessage: ${errorMessage},
page: ${page},
selectedMonth: ${selectedMonth},
selectedYear: ${selectedYear},
selectedPaymentStatus: ${selectedPaymentStatus},
hospitalNameFilter: ${hospitalNameFilter},
selectedDateDisplay: ${selectedDateDisplay},
totalAmount: ${totalAmount},
totalPaid: ${totalPaid},
totalUnpaid: ${totalUnpaid},
isGeneratingPdf: ${isGeneratingPdf},
deleteState: ${deleteState},
pdfPath: ${pdfPath}
    ''';
  }
}
