// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeViewModel on _HomeViewModelBase, Store {
  Computed<bool>? _$showBottomAppBarComputed;

  @override
  bool get showBottomAppBar => (_$showBottomAppBarComputed ??= Computed<bool>(
          () => super.showBottomAppBar,
          name: '_HomeViewModelBase.showBottomAppBar'))
      .value;
  Computed<bool>? _$showFloatingActionButtonComputed;

  @override
  bool get showFloatingActionButton => (_$showFloatingActionButtonComputed ??=
          Computed<bool>(() => super.showFloatingActionButton,
              name: '_HomeViewModelBase.showFloatingActionButton'))
      .value;
  Computed<bool>? _$hasDataComputed;

  @override
  bool get hasData => (_$hasDataComputed ??= Computed<bool>(() => super.hasData,
          name: '_HomeViewModelBase.hasData'))
      .value;
  Computed<String>? _$totalProceduresComputed;

  @override
  String get totalProcedures => (_$totalProceduresComputed ??= Computed<String>(
          () => super.totalProcedures,
          name: '_HomeViewModelBase.totalProcedures'))
      .value;
  Computed<String>? _$totalPaidProceduresComputed;

  @override
  String get totalPaidProcedures => (_$totalPaidProceduresComputed ??=
          Computed<String>(() => super.totalPaidProcedures,
              name: '_HomeViewModelBase.totalPaidProcedures'))
      .value;
  Computed<String>? _$totalUnpaidProceduresComputed;

  @override
  String get totalUnpaidProcedures => (_$totalUnpaidProceduresComputed ??=
          Computed<String>(() => super.totalUnpaidProcedures,
              name: '_HomeViewModelBase.totalUnpaidProcedures'))
      .value;
  Computed<String>? _$totalMedicalShiftsComputed;

  @override
  String get totalMedicalShifts => (_$totalMedicalShiftsComputed ??=
          Computed<String>(() => super.totalMedicalShifts,
              name: '_HomeViewModelBase.totalMedicalShifts'))
      .value;
  Computed<String>? _$totalPaidMedicalShiftsComputed;

  @override
  String get totalPaidMedicalShifts => (_$totalPaidMedicalShiftsComputed ??=
          Computed<String>(() => super.totalPaidMedicalShifts,
              name: '_HomeViewModelBase.totalPaidMedicalShifts'))
      .value;
  Computed<String>? _$totalUnpaidMedicalShiftsComputed;

  @override
  String get totalUnpaidMedicalShifts => (_$totalUnpaidMedicalShiftsComputed ??=
          Computed<String>(() => super.totalUnpaidMedicalShifts,
              name: '_HomeViewModelBase.totalUnpaidMedicalShifts'))
      .value;

  late final _$eventProceduresAtom =
      Atom(name: '_HomeViewModelBase.eventProcedures', context: context);

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

  late final _$medicalShiftsAtom =
      Atom(name: '_HomeViewModelBase.medicalShifts', context: context);

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

  late final _$isLoadingAtom =
      Atom(name: '_HomeViewModelBase.isLoading', context: context);

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

  late final _$errorMessageAtom =
      Atom(name: '_HomeViewModelBase.errorMessage', context: context);

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

  late final _$selectedFilterAtom =
      Atom(name: '_HomeViewModelBase.selectedFilter', context: context);

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

  late final _$_totalProceduresAtom =
      Atom(name: '_HomeViewModelBase._totalProcedures', context: context);

  @override
  String get _totalProcedures {
    _$_totalProceduresAtom.reportRead();
    return super._totalProcedures;
  }

  @override
  set _totalProcedures(String value) {
    _$_totalProceduresAtom.reportWrite(value, super._totalProcedures, () {
      super._totalProcedures = value;
    });
  }

  late final _$_totalPaidProceduresAtom =
      Atom(name: '_HomeViewModelBase._totalPaidProcedures', context: context);

  @override
  String get _totalPaidProcedures {
    _$_totalPaidProceduresAtom.reportRead();
    return super._totalPaidProcedures;
  }

  @override
  set _totalPaidProcedures(String value) {
    _$_totalPaidProceduresAtom.reportWrite(value, super._totalPaidProcedures,
        () {
      super._totalPaidProcedures = value;
    });
  }

  late final _$_totalUnpaidProceduresAtom =
      Atom(name: '_HomeViewModelBase._totalUnpaidProcedures', context: context);

  @override
  String get _totalUnpaidProcedures {
    _$_totalUnpaidProceduresAtom.reportRead();
    return super._totalUnpaidProcedures;
  }

  @override
  set _totalUnpaidProcedures(String value) {
    _$_totalUnpaidProceduresAtom
        .reportWrite(value, super._totalUnpaidProcedures, () {
      super._totalUnpaidProcedures = value;
    });
  }

  late final _$_totalMedicalShiftsAtom =
      Atom(name: '_HomeViewModelBase._totalMedicalShifts', context: context);

  @override
  String get _totalMedicalShifts {
    _$_totalMedicalShiftsAtom.reportRead();
    return super._totalMedicalShifts;
  }

  @override
  set _totalMedicalShifts(String value) {
    _$_totalMedicalShiftsAtom.reportWrite(value, super._totalMedicalShifts, () {
      super._totalMedicalShifts = value;
    });
  }

  late final _$_totalPaidMedicalShiftsAtom = Atom(
      name: '_HomeViewModelBase._totalPaidMedicalShifts', context: context);

  @override
  String get _totalPaidMedicalShifts {
    _$_totalPaidMedicalShiftsAtom.reportRead();
    return super._totalPaidMedicalShifts;
  }

  @override
  set _totalPaidMedicalShifts(String value) {
    _$_totalPaidMedicalShiftsAtom
        .reportWrite(value, super._totalPaidMedicalShifts, () {
      super._totalPaidMedicalShifts = value;
    });
  }

  late final _$_totalUnpaidMedicalShiftsAtom = Atom(
      name: '_HomeViewModelBase._totalUnpaidMedicalShifts', context: context);

  @override
  String get _totalUnpaidMedicalShifts {
    _$_totalUnpaidMedicalShiftsAtom.reportRead();
    return super._totalUnpaidMedicalShifts;
  }

  @override
  set _totalUnpaidMedicalShifts(String value) {
    _$_totalUnpaidMedicalShiftsAtom
        .reportWrite(value, super._totalUnpaidMedicalShifts, () {
      super._totalUnpaidMedicalShifts = value;
    });
  }

  late final _$fetchAllDataAsyncAction =
      AsyncAction('_HomeViewModelBase.fetchAllData', context: context);

  @override
  Future<void> fetchAllData() {
    return _$fetchAllDataAsyncAction.run(() => super.fetchAllData());
  }

  late final _$loadLatestEventProceduresAsyncAction = AsyncAction(
      '_HomeViewModelBase.loadLatestEventProcedures',
      context: context);

  @override
  Future<void> loadLatestEventProcedures() {
    return _$loadLatestEventProceduresAsyncAction
        .run(() => super.loadLatestEventProcedures());
  }

  late final _$loadLatestMedicalShiftsAsyncAction = AsyncAction(
      '_HomeViewModelBase.loadLatestMedicalShifts',
      context: context);

  @override
  Future<void> loadLatestMedicalShifts() {
    return _$loadLatestMedicalShiftsAsyncAction
        .run(() => super.loadLatestMedicalShifts());
  }

  late final _$_HomeViewModelBaseActionController =
      ActionController(name: '_HomeViewModelBase', context: context);

  @override
  void setSelectedFilter(HomeFilterType filter) {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
        name: '_HomeViewModelBase.setSelectedFilter');
    try {
      return super.setSelectedFilter(filter);
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
eventProcedures: ${eventProcedures},
medicalShifts: ${medicalShifts},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
selectedFilter: ${selectedFilter},
showBottomAppBar: ${showBottomAppBar},
showFloatingActionButton: ${showFloatingActionButton},
hasData: ${hasData},
totalProcedures: ${totalProcedures},
totalPaidProcedures: ${totalPaidProcedures},
totalUnpaidProcedures: ${totalUnpaidProcedures},
totalMedicalShifts: ${totalMedicalShifts},
totalPaidMedicalShifts: ${totalPaidMedicalShifts},
totalUnpaidMedicalShifts: ${totalUnpaidMedicalShifts}
    ''';
  }
}
