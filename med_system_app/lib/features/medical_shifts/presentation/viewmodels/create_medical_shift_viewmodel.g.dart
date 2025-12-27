// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_medical_shift_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreateMedicalShiftViewModel on _CreateMedicalShiftViewModelBase, Store {
  Computed<bool>? _$isValidDataComputed;

  @override
  bool get isValidData =>
      (_$isValidDataComputed ??= Computed<bool>(() => super.isValidData,
              name: '_CreateMedicalShiftViewModelBase.isValidData'))
          .value;

  late final _$hospitalNameAtom = Atom(
      name: '_CreateMedicalShiftViewModelBase.hospitalName', context: context);

  @override
  String get hospitalName {
    _$hospitalNameAtom.reportRead();
    return super.hospitalName;
  }

  @override
  set hospitalName(String value) {
    _$hospitalNameAtom.reportWrite(value, super.hospitalName, () {
      super.hospitalName = value;
    });
  }

  late final _$workloadAtom =
      Atom(name: '_CreateMedicalShiftViewModelBase.workload', context: context);

  @override
  String get workload {
    _$workloadAtom.reportRead();
    return super.workload;
  }

  @override
  set workload(String value) {
    _$workloadAtom.reportWrite(value, super.workload, () {
      super.workload = value;
    });
  }

  late final _$startDateAtom = Atom(
      name: '_CreateMedicalShiftViewModelBase.startDate', context: context);

  @override
  String get startDate {
    _$startDateAtom.reportRead();
    return super.startDate;
  }

  @override
  set startDate(String value) {
    _$startDateAtom.reportWrite(value, super.startDate, () {
      super.startDate = value;
    });
  }

  late final _$startHourAtom = Atom(
      name: '_CreateMedicalShiftViewModelBase.startHour', context: context);

  @override
  String get startHour {
    _$startHourAtom.reportRead();
    return super.startHour;
  }

  @override
  set startHour(String value) {
    _$startHourAtom.reportWrite(value, super.startHour, () {
      super.startHour = value;
    });
  }

  late final _$amountAtom =
      Atom(name: '_CreateMedicalShiftViewModelBase.amount', context: context);

  @override
  double get amount {
    _$amountAtom.reportRead();
    return super.amount;
  }

  @override
  set amount(double value) {
    _$amountAtom.reportWrite(value, super.amount, () {
      super.amount = value;
    });
  }

  late final _$paidAtom =
      Atom(name: '_CreateMedicalShiftViewModelBase.paid', context: context);

  @override
  bool get paid {
    _$paidAtom.reportRead();
    return super.paid;
  }

  @override
  set paid(bool value) {
    _$paidAtom.reportWrite(value, super.paid, () {
      super.paid = value;
    });
  }

  late final _$isRecurrentAtom = Atom(
      name: '_CreateMedicalShiftViewModelBase.isRecurrent', context: context);

  @override
  bool get isRecurrent {
    _$isRecurrentAtom.reportRead();
    return super.isRecurrent;
  }

  @override
  set isRecurrent(bool value) {
    _$isRecurrentAtom.reportWrite(value, super.isRecurrent, () {
      super.isRecurrent = value;
    });
  }

  late final _$frequencyAtom = Atom(
      name: '_CreateMedicalShiftViewModelBase.frequency', context: context);

  @override
  String? get frequency {
    _$frequencyAtom.reportRead();
    return super.frequency;
  }

  @override
  set frequency(String? value) {
    _$frequencyAtom.reportWrite(value, super.frequency, () {
      super.frequency = value;
    });
  }

  late final _$dayOfWeekAtom = Atom(
      name: '_CreateMedicalShiftViewModelBase.dayOfWeek', context: context);

  @override
  int? get dayOfWeek {
    _$dayOfWeekAtom.reportRead();
    return super.dayOfWeek;
  }

  @override
  set dayOfWeek(int? value) {
    _$dayOfWeekAtom.reportWrite(value, super.dayOfWeek, () {
      super.dayOfWeek = value;
    });
  }

  late final _$dayOfMonthAtom = Atom(
      name: '_CreateMedicalShiftViewModelBase.dayOfMonth', context: context);

  @override
  int? get dayOfMonth {
    _$dayOfMonthAtom.reportRead();
    return super.dayOfMonth;
  }

  @override
  set dayOfMonth(int? value) {
    _$dayOfMonthAtom.reportWrite(value, super.dayOfMonth, () {
      super.dayOfMonth = value;
    });
  }

  late final _$endDateAtom =
      Atom(name: '_CreateMedicalShiftViewModelBase.endDate', context: context);

  @override
  String? get endDate {
    _$endDateAtom.reportRead();
    return super.endDate;
  }

  @override
  set endDate(String? value) {
    _$endDateAtom.reportWrite(value, super.endDate, () {
      super.endDate = value;
    });
  }

  late final _$stateAtom =
      Atom(name: '_CreateMedicalShiftViewModelBase.state', context: context);

  @override
  CreateMedicalShiftState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(CreateMedicalShiftState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$errorMessageAtom = Atom(
      name: '_CreateMedicalShiftViewModelBase.errorMessage', context: context);

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

  late final _$hospitalSuggestionsAtom = Atom(
      name: '_CreateMedicalShiftViewModelBase.hospitalSuggestions',
      context: context);

  @override
  ObservableList<String> get hospitalSuggestions {
    _$hospitalSuggestionsAtom.reportRead();
    return super.hospitalSuggestions;
  }

  @override
  set hospitalSuggestions(ObservableList<String> value) {
    _$hospitalSuggestionsAtom.reportWrite(value, super.hospitalSuggestions, () {
      super.hospitalSuggestions = value;
    });
  }

  late final _$amountSuggestionsAtom = Atom(
      name: '_CreateMedicalShiftViewModelBase.amountSuggestions',
      context: context);

  @override
  ObservableList<String> get amountSuggestions {
    _$amountSuggestionsAtom.reportRead();
    return super.amountSuggestions;
  }

  @override
  set amountSuggestions(ObservableList<String> value) {
    _$amountSuggestionsAtom.reportWrite(value, super.amountSuggestions, () {
      super.amountSuggestions = value;
    });
  }

  late final _$loadSuggestionsAsyncAction = AsyncAction(
      '_CreateMedicalShiftViewModelBase.loadSuggestions',
      context: context);

  @override
  Future<void> loadSuggestions() {
    return _$loadSuggestionsAsyncAction.run(() => super.loadSuggestions());
  }

  late final _$createMedicalShiftAsyncAction = AsyncAction(
      '_CreateMedicalShiftViewModelBase.createMedicalShift',
      context: context);

  @override
  Future<void> createMedicalShift() {
    return _$createMedicalShiftAsyncAction
        .run(() => super.createMedicalShift());
  }

  late final _$_CreateMedicalShiftViewModelBaseActionController =
      ActionController(
          name: '_CreateMedicalShiftViewModelBase', context: context);

  @override
  void setHospitalName(String value) {
    final _$actionInfo = _$_CreateMedicalShiftViewModelBaseActionController
        .startAction(name: '_CreateMedicalShiftViewModelBase.setHospitalName');
    try {
      return super.setHospitalName(value);
    } finally {
      _$_CreateMedicalShiftViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setWorkload(String value) {
    final _$actionInfo = _$_CreateMedicalShiftViewModelBaseActionController
        .startAction(name: '_CreateMedicalShiftViewModelBase.setWorkload');
    try {
      return super.setWorkload(value);
    } finally {
      _$_CreateMedicalShiftViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setStartDate(String value) {
    final _$actionInfo = _$_CreateMedicalShiftViewModelBaseActionController
        .startAction(name: '_CreateMedicalShiftViewModelBase.setStartDate');
    try {
      return super.setStartDate(value);
    } finally {
      _$_CreateMedicalShiftViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setStartHour(String value) {
    final _$actionInfo = _$_CreateMedicalShiftViewModelBaseActionController
        .startAction(name: '_CreateMedicalShiftViewModelBase.setStartHour');
    try {
      return super.setStartHour(value);
    } finally {
      _$_CreateMedicalShiftViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setAmount(double value) {
    final _$actionInfo = _$_CreateMedicalShiftViewModelBaseActionController
        .startAction(name: '_CreateMedicalShiftViewModelBase.setAmount');
    try {
      return super.setAmount(value);
    } finally {
      _$_CreateMedicalShiftViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setAmountCents(String text) {
    final _$actionInfo = _$_CreateMedicalShiftViewModelBaseActionController
        .startAction(name: '_CreateMedicalShiftViewModelBase.setAmountCents');
    try {
      return super.setAmountCents(text);
    } finally {
      _$_CreateMedicalShiftViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setPaid(bool value) {
    final _$actionInfo = _$_CreateMedicalShiftViewModelBaseActionController
        .startAction(name: '_CreateMedicalShiftViewModelBase.setPaid');
    try {
      return super.setPaid(value);
    } finally {
      _$_CreateMedicalShiftViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setIsRecurrent(bool value) {
    final _$actionInfo = _$_CreateMedicalShiftViewModelBaseActionController
        .startAction(name: '_CreateMedicalShiftViewModelBase.setIsRecurrent');
    try {
      return super.setIsRecurrent(value);
    } finally {
      _$_CreateMedicalShiftViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setFrequency(String? value) {
    final _$actionInfo = _$_CreateMedicalShiftViewModelBaseActionController
        .startAction(name: '_CreateMedicalShiftViewModelBase.setFrequency');
    try {
      return super.setFrequency(value);
    } finally {
      _$_CreateMedicalShiftViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setDayOfWeek(int? value) {
    final _$actionInfo = _$_CreateMedicalShiftViewModelBaseActionController
        .startAction(name: '_CreateMedicalShiftViewModelBase.setDayOfWeek');
    try {
      return super.setDayOfWeek(value);
    } finally {
      _$_CreateMedicalShiftViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setDayOfMonth(int? value) {
    final _$actionInfo = _$_CreateMedicalShiftViewModelBaseActionController
        .startAction(name: '_CreateMedicalShiftViewModelBase.setDayOfMonth');
    try {
      return super.setDayOfMonth(value);
    } finally {
      _$_CreateMedicalShiftViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setEndDate(String? value) {
    final _$actionInfo = _$_CreateMedicalShiftViewModelBaseActionController
        .startAction(name: '_CreateMedicalShiftViewModelBase.setEndDate');
    try {
      return super.setEndDate(value);
    } finally {
      _$_CreateMedicalShiftViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo = _$_CreateMedicalShiftViewModelBaseActionController
        .startAction(name: '_CreateMedicalShiftViewModelBase.reset');
    try {
      return super.reset();
    } finally {
      _$_CreateMedicalShiftViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
hospitalName: ${hospitalName},
workload: ${workload},
startDate: ${startDate},
startHour: ${startHour},
amount: ${amount},
paid: ${paid},
isRecurrent: ${isRecurrent},
frequency: ${frequency},
dayOfWeek: ${dayOfWeek},
dayOfMonth: ${dayOfMonth},
endDate: ${endDate},
state: ${state},
errorMessage: ${errorMessage},
hospitalSuggestions: ${hospitalSuggestions},
amountSuggestions: ${amountSuggestions},
isValidData: ${isValidData}
    ''';
  }
}
