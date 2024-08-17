// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medical_shift.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MedicalShiftStore on _MedicalShiftStoreBase, Store {
  late final _$stateAtom =
      Atom(name: '_MedicalShiftStoreBase.state', context: context);

  @override
  MedicalShiftState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(MedicalShiftState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$editStateAtom =
      Atom(name: '_MedicalShiftStoreBase.editState', context: context);

  @override
  EditMedicalShiftState get editState {
    _$editStateAtom.reportRead();
    return super.editState;
  }

  @override
  set editState(EditMedicalShiftState value) {
    _$editStateAtom.reportWrite(value, super.editState, () {
      super.editState = value;
    });
  }

  late final _$deleteStateAtom =
      Atom(name: '_MedicalShiftStoreBase.deleteState', context: context);

  @override
  DeleteMedicalShiftState get deleteState {
    _$deleteStateAtom.reportRead();
    return super.deleteState;
  }

  @override
  set deleteState(DeleteMedicalShiftState value) {
    _$deleteStateAtom.reportWrite(value, super.deleteState, () {
      super.deleteState = value;
    });
  }

  late final _$_showAllAtom =
      Atom(name: '_MedicalShiftStoreBase._showAll', context: context);

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
      Atom(name: '_MedicalShiftStoreBase._showPaid', context: context);

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

  late final _$_showMonthAtom =
      Atom(name: '_MedicalShiftStoreBase._showMonth', context: context);

  @override
  bool get _showMonth {
    _$_showMonthAtom.reportRead();
    return super._showMonth;
  }

  @override
  set _showMonth(bool value) {
    _$_showMonthAtom.reportWrite(value, super._showMonth, () {
      super._showMonth = value;
    });
  }

  late final _$_showUnpaidAtom =
      Atom(name: '_MedicalShiftStoreBase._showUnpaid', context: context);

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

  late final _$_monthAtom =
      Atom(name: '_MedicalShiftStoreBase._month', context: context);

  @override
  int get _month {
    _$_monthAtom.reportRead();
    return super._month;
  }

  @override
  set _month(int value) {
    _$_monthAtom.reportWrite(value, super._month, () {
      super._month = value;
    });
  }

  late final _$_errorMessageAtom =
      Atom(name: '_MedicalShiftStoreBase._errorMessage', context: context);

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
      Atom(name: '_MedicalShiftStoreBase._page', context: context);

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

  late final _$_medicalShiftAtom =
      Atom(name: '_MedicalShiftStoreBase._medicalShift', context: context);

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

  late final _$getAllMedicalShiftsAsyncAction = AsyncAction(
      '_MedicalShiftStoreBase.getAllMedicalShifts',
      context: context);

  @override
  Future getAllMedicalShifts({bool isRefresh = false}) {
    return _$getAllMedicalShiftsAsyncAction
        .run(() => super.getAllMedicalShifts(isRefresh: isRefresh));
  }

  late final _$_MedicalShiftStoreBaseActionController =
      ActionController(name: '_MedicalShiftStoreBase', context: context);

  @override
  dynamic updateMonth(int month) {
    final _$actionInfo = _$_MedicalShiftStoreBaseActionController.startAction(
        name: '_MedicalShiftStoreBase.updateMonth');
    try {
      return super.updateMonth(month);
    } finally {
      _$_MedicalShiftStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateFilter(bool all, bool paid, bool unpaid, bool month) {
    final _$actionInfo = _$_MedicalShiftStoreBaseActionController.startAction(
        name: '_MedicalShiftStoreBase.updateFilter');
    try {
      return super.updateFilter(all, paid, unpaid, month);
    } finally {
      _$_MedicalShiftStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic getMedicalShifts() {
    final _$actionInfo = _$_MedicalShiftStoreBaseActionController.startAction(
        name: '_MedicalShiftStoreBase.getMedicalShifts');
    try {
      return super.getMedicalShifts();
    } finally {
      _$_MedicalShiftStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic dispose() {
    final _$actionInfo = _$_MedicalShiftStoreBaseActionController.startAction(
        name: '_MedicalShiftStoreBase.dispose');
    try {
      return super.dispose();
    } finally {
      _$_MedicalShiftStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state},
editState: ${editState},
deleteState: ${deleteState}
    ''';
  }
}
