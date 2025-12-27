// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_medical_shift_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UpdateMedicalShiftViewModel on _UpdateMedicalShiftViewModelBase, Store {
  Computed<bool>? _$isValidDataComputed;

  @override
  bool get isValidData =>
      (_$isValidDataComputed ??= Computed<bool>(() => super.isValidData,
              name: '_UpdateMedicalShiftViewModelBase.isValidData'))
          .value;

  late final _$hospitalNameAtom = Atom(
      name: '_UpdateMedicalShiftViewModelBase.hospitalName', context: context);

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
      Atom(name: '_UpdateMedicalShiftViewModelBase.workload', context: context);

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
      name: '_UpdateMedicalShiftViewModelBase.startDate', context: context);

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
      name: '_UpdateMedicalShiftViewModelBase.startHour', context: context);

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
      Atom(name: '_UpdateMedicalShiftViewModelBase.amount', context: context);

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
      Atom(name: '_UpdateMedicalShiftViewModelBase.paid', context: context);

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

  late final _$stateAtom =
      Atom(name: '_UpdateMedicalShiftViewModelBase.state', context: context);

  @override
  UpdateMedicalShiftState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(UpdateMedicalShiftState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$errorMessageAtom = Atom(
      name: '_UpdateMedicalShiftViewModelBase.errorMessage', context: context);

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
      name: '_UpdateMedicalShiftViewModelBase.hospitalSuggestions',
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
      name: '_UpdateMedicalShiftViewModelBase.amountSuggestions',
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
      '_UpdateMedicalShiftViewModelBase.loadSuggestions',
      context: context);

  @override
  Future<void> loadSuggestions() {
    return _$loadSuggestionsAsyncAction.run(() => super.loadSuggestions());
  }

  late final _$updateMedicalShiftAsyncAction = AsyncAction(
      '_UpdateMedicalShiftViewModelBase.updateMedicalShift',
      context: context);

  @override
  Future<void> updateMedicalShift() {
    return _$updateMedicalShiftAsyncAction
        .run(() => super.updateMedicalShift());
  }

  late final _$_UpdateMedicalShiftViewModelBaseActionController =
      ActionController(
          name: '_UpdateMedicalShiftViewModelBase', context: context);

  @override
  void init(MedicalShiftEntity entity) {
    final _$actionInfo = _$_UpdateMedicalShiftViewModelBaseActionController
        .startAction(name: '_UpdateMedicalShiftViewModelBase.init');
    try {
      return super.init(entity);
    } finally {
      _$_UpdateMedicalShiftViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setHospitalName(String value) {
    final _$actionInfo = _$_UpdateMedicalShiftViewModelBaseActionController
        .startAction(name: '_UpdateMedicalShiftViewModelBase.setHospitalName');
    try {
      return super.setHospitalName(value);
    } finally {
      _$_UpdateMedicalShiftViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setWorkload(String value) {
    final _$actionInfo = _$_UpdateMedicalShiftViewModelBaseActionController
        .startAction(name: '_UpdateMedicalShiftViewModelBase.setWorkload');
    try {
      return super.setWorkload(value);
    } finally {
      _$_UpdateMedicalShiftViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setStartDate(String value) {
    final _$actionInfo = _$_UpdateMedicalShiftViewModelBaseActionController
        .startAction(name: '_UpdateMedicalShiftViewModelBase.setStartDate');
    try {
      return super.setStartDate(value);
    } finally {
      _$_UpdateMedicalShiftViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setStartHour(String value) {
    final _$actionInfo = _$_UpdateMedicalShiftViewModelBaseActionController
        .startAction(name: '_UpdateMedicalShiftViewModelBase.setStartHour');
    try {
      return super.setStartHour(value);
    } finally {
      _$_UpdateMedicalShiftViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setAmount(double value) {
    final _$actionInfo = _$_UpdateMedicalShiftViewModelBaseActionController
        .startAction(name: '_UpdateMedicalShiftViewModelBase.setAmount');
    try {
      return super.setAmount(value);
    } finally {
      _$_UpdateMedicalShiftViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setAmountCents(String text) {
    final _$actionInfo = _$_UpdateMedicalShiftViewModelBaseActionController
        .startAction(name: '_UpdateMedicalShiftViewModelBase.setAmountCents');
    try {
      return super.setAmountCents(text);
    } finally {
      _$_UpdateMedicalShiftViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setPaid(bool value) {
    final _$actionInfo = _$_UpdateMedicalShiftViewModelBaseActionController
        .startAction(name: '_UpdateMedicalShiftViewModelBase.setPaid');
    try {
      return super.setPaid(value);
    } finally {
      _$_UpdateMedicalShiftViewModelBaseActionController
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
state: ${state},
errorMessage: ${errorMessage},
hospitalSuggestions: ${hospitalSuggestions},
amountSuggestions: ${amountSuggestions},
isValidData: ${isValidData}
    ''';
  }
}
