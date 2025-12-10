// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_procedures_list_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EventProceduresListViewModel
    on _EventProceduresListViewModelBase, Store {
  late final _$pdfPathAtom =
      Atom(name: '_EventProceduresListViewModelBase.pdfPath', context: context);

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

  late final _$isPdfLoadingAtom = Atom(
      name: '_EventProceduresListViewModelBase.isPdfLoading', context: context);

  @override
  bool get isPdfLoading {
    _$isPdfLoadingAtom.reportRead();
    return super.isPdfLoading;
  }

  @override
  set isPdfLoading(bool value) {
    _$isPdfLoadingAtom.reportWrite(value, super.isPdfLoading, () {
      super.isPdfLoading = value;
    });
  }

  late final _$eventProceduresAtom = Atom(
      name: '_EventProceduresListViewModelBase.eventProcedures',
      context: context);

  @override
  ObservableList<EventProcedureEntity> get eventProcedures {
    _$eventProceduresAtom.reportRead();
    return super.eventProcedures;
  }

  @override
  set eventProcedures(ObservableList<EventProcedureEntity> value) {
    _$eventProceduresAtom.reportWrite(value, super.eventProcedures, () {
      super.eventProcedures = value;
    });
  }

  late final _$isLoadingAtom = Atom(
      name: '_EventProceduresListViewModelBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom = Atom(
      name: '_EventProceduresListViewModelBase.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$pageAtom =
      Atom(name: '_EventProceduresListViewModelBase.page', context: context);

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

  late final _$perPageAtom =
      Atom(name: '_EventProceduresListViewModelBase.perPage', context: context);

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

  late final _$totalAtom =
      Atom(name: '_EventProceduresListViewModelBase.total', context: context);

  @override
  String? get total {
    _$totalAtom.reportRead();
    return super.total;
  }

  @override
  set total(String? value) {
    _$totalAtom.reportWrite(value, super.total, () {
      super.total = value;
    });
  }

  late final _$totalPaidAtom = Atom(
      name: '_EventProceduresListViewModelBase.totalPaid', context: context);

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
      name: '_EventProceduresListViewModelBase.totalUnpaid', context: context);

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

  late final _$loadEventProceduresAsyncAction = AsyncAction(
      '_EventProceduresListViewModelBase.loadEventProcedures',
      context: context);

  @override
  Future<void> loadEventProcedures(
      {int? month,
      int? year,
      bool? paid,
      String? healthInsuranceName,
      String? hospitalName,
      bool refresh = false}) {
    return _$loadEventProceduresAsyncAction.run(() => super.loadEventProcedures(
        month: month,
        year: year,
        paid: paid,
        healthInsuranceName: healthInsuranceName,
        hospitalName: hospitalName,
        refresh: refresh));
  }

  late final _$deleteEventProcedureAsyncAction = AsyncAction(
      '_EventProceduresListViewModelBase.deleteEventProcedure',
      context: context);

  @override
  Future<void> deleteEventProcedure(int id) {
    return _$deleteEventProcedureAsyncAction
        .run(() => super.deleteEventProcedure(id));
  }

  late final _$updatePaymentStatusAsyncAction = AsyncAction(
      '_EventProceduresListViewModelBase.updatePaymentStatus',
      context: context);

  @override
  Future<void> updatePaymentStatus(int id, bool paid) {
    return _$updatePaymentStatusAsyncAction
        .run(() => super.updatePaymentStatus(id, paid));
  }

  late final _$generatePdfAsyncAction = AsyncAction(
      '_EventProceduresListViewModelBase.generatePdf',
      context: context);

  @override
  Future<void> generatePdf() {
    return _$generatePdfAsyncAction.run(() => super.generatePdf());
  }

  @override
  String toString() {
    return '''
pdfPath: ${pdfPath},
isPdfLoading: ${isPdfLoading},
eventProcedures: ${eventProcedures},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
page: ${page},
perPage: ${perPage},
total: ${total},
totalPaid: ${totalPaid},
totalUnpaid: ${totalUnpaid}
    ''';
  }
}
