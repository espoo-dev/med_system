// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_event_procedures_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FilterEventProceduresViewModel
    on _FilterEventProceduresViewModelBase, Store {
  Computed<List<int>>? _$yearsComputed;

  @override
  List<int> get years =>
      (_$yearsComputed ??= Computed<List<int>>(() => super.years,
              name: '_FilterEventProceduresViewModelBase.years'))
          .value;
  Computed<List<int>>? _$monthsComputed;

  @override
  List<int> get months =>
      (_$monthsComputed ??= Computed<List<int>>(() => super.months,
              name: '_FilterEventProceduresViewModelBase.months'))
          .value;

  late final _$hospitalsAtom = Atom(
      name: '_FilterEventProceduresViewModelBase.hospitals', context: context);

  @override
  ObservableList<HospitalEntity> get hospitals {
    _$hospitalsAtom.reportRead();
    return super.hospitals;
  }

  @override
  set hospitals(ObservableList<HospitalEntity> value) {
    _$hospitalsAtom.reportWrite(value, super.hospitals, () {
      super.hospitals = value;
    });
  }

  late final _$healthInsurancesAtom = Atom(
      name: '_FilterEventProceduresViewModelBase.healthInsurances',
      context: context);

  @override
  ObservableList<HealthInsuranceEntity> get healthInsurances {
    _$healthInsurancesAtom.reportRead();
    return super.healthInsurances;
  }

  @override
  set healthInsurances(ObservableList<HealthInsuranceEntity> value) {
    _$healthInsurancesAtom.reportWrite(value, super.healthInsurances, () {
      super.healthInsurances = value;
    });
  }

  late final _$selectedYearAtom = Atom(
      name: '_FilterEventProceduresViewModelBase.selectedYear',
      context: context);

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

  late final _$selectedMonthAtom = Atom(
      name: '_FilterEventProceduresViewModelBase.selectedMonth',
      context: context);

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
      name: '_FilterEventProceduresViewModelBase.selectedPaymentStatus',
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

  late final _$selectedHospitalAtom = Atom(
      name: '_FilterEventProceduresViewModelBase.selectedHospital',
      context: context);

  @override
  HospitalEntity? get selectedHospital {
    _$selectedHospitalAtom.reportRead();
    return super.selectedHospital;
  }

  @override
  set selectedHospital(HospitalEntity? value) {
    _$selectedHospitalAtom.reportWrite(value, super.selectedHospital, () {
      super.selectedHospital = value;
    });
  }

  late final _$selectedHealthInsuranceAtom = Atom(
      name: '_FilterEventProceduresViewModelBase.selectedHealthInsurance',
      context: context);

  @override
  HealthInsuranceEntity? get selectedHealthInsurance {
    _$selectedHealthInsuranceAtom.reportRead();
    return super.selectedHealthInsurance;
  }

  @override
  set selectedHealthInsurance(HealthInsuranceEntity? value) {
    _$selectedHealthInsuranceAtom
        .reportWrite(value, super.selectedHealthInsurance, () {
      super.selectedHealthInsurance = value;
    });
  }

  late final _$isLoadingAtom = Atom(
      name: '_FilterEventProceduresViewModelBase.isLoading', context: context);

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
      name: '_FilterEventProceduresViewModelBase.errorMessage',
      context: context);

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

  late final _$loadFiltersDataAsyncAction = AsyncAction(
      '_FilterEventProceduresViewModelBase.loadFiltersData',
      context: context);

  @override
  Future<void> loadFiltersData() {
    return _$loadFiltersDataAsyncAction.run(() => super.loadFiltersData());
  }

  late final _$_FilterEventProceduresViewModelBaseActionController =
      ActionController(
          name: '_FilterEventProceduresViewModelBase', context: context);

  @override
  void setSelectedYear(int? year) {
    final _$actionInfo =
        _$_FilterEventProceduresViewModelBaseActionController.startAction(
            name: '_FilterEventProceduresViewModelBase.setSelectedYear');
    try {
      return super.setSelectedYear(year);
    } finally {
      _$_FilterEventProceduresViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedMonth(int? month) {
    final _$actionInfo =
        _$_FilterEventProceduresViewModelBaseActionController.startAction(
            name: '_FilterEventProceduresViewModelBase.setSelectedMonth');
    try {
      return super.setSelectedMonth(month);
    } finally {
      _$_FilterEventProceduresViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedPaymentStatus(bool? status) {
    final _$actionInfo =
        _$_FilterEventProceduresViewModelBaseActionController.startAction(
            name:
                '_FilterEventProceduresViewModelBase.setSelectedPaymentStatus');
    try {
      return super.setSelectedPaymentStatus(status);
    } finally {
      _$_FilterEventProceduresViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedHospital(HospitalEntity? hospital) {
    final _$actionInfo =
        _$_FilterEventProceduresViewModelBaseActionController.startAction(
            name: '_FilterEventProceduresViewModelBase.setSelectedHospital');
    try {
      return super.setSelectedHospital(hospital);
    } finally {
      _$_FilterEventProceduresViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedHealthInsurance(HealthInsuranceEntity? insurance) {
    final _$actionInfo =
        _$_FilterEventProceduresViewModelBaseActionController.startAction(
            name:
                '_FilterEventProceduresViewModelBase.setSelectedHealthInsurance');
    try {
      return super.setSelectedHealthInsurance(insurance);
    } finally {
      _$_FilterEventProceduresViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void clearFilters() {
    final _$actionInfo = _$_FilterEventProceduresViewModelBaseActionController
        .startAction(name: '_FilterEventProceduresViewModelBase.clearFilters');
    try {
      return super.clearFilters();
    } finally {
      _$_FilterEventProceduresViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
hospitals: ${hospitals},
healthInsurances: ${healthInsurances},
selectedYear: ${selectedYear},
selectedMonth: ${selectedMonth},
selectedPaymentStatus: ${selectedPaymentStatus},
selectedHospital: ${selectedHospital},
selectedHealthInsurance: ${selectedHealthInsurance},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
years: ${years},
months: ${months}
    ''';
  }
}
