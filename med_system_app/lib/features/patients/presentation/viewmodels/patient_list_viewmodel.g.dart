// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_list_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PatientListViewModel on _PatientListViewModelBase, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_PatientListViewModelBase.isLoading'))
          .value;
  Computed<bool>? _$isDeletingComputed;

  @override
  bool get isDeleting =>
      (_$isDeletingComputed ??= Computed<bool>(() => super.isDeleting,
              name: '_PatientListViewModelBase.isDeleting'))
          .value;
  Computed<bool>? _$hasPatientsComputed;

  @override
  bool get hasPatients =>
      (_$hasPatientsComputed ??= Computed<bool>(() => super.hasPatients,
              name: '_PatientListViewModelBase.hasPatients'))
          .value;
  Computed<int>? _$patientsCountComputed;

  @override
  int get patientsCount =>
      (_$patientsCountComputed ??= Computed<int>(() => super.patientsCount,
              name: '_PatientListViewModelBase.patientsCount'))
          .value;

  late final _$patientsAtom =
      Atom(name: '_PatientListViewModelBase.patients', context: context);

  @override
  ObservableList<PatientEntity> get patients {
    _$patientsAtom.reportRead();
    return super.patients;
  }

  @override
  set patients(ObservableList<PatientEntity> value) {
    _$patientsAtom.reportWrite(value, super.patients, () {
      super.patients = value;
    });
  }

  late final _$stateAtom =
      Atom(name: '_PatientListViewModelBase.state', context: context);

  @override
  PatientListState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(PatientListState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$deleteStateAtom =
      Atom(name: '_PatientListViewModelBase.deleteState', context: context);

  @override
  DeletePatientState get deleteState {
    _$deleteStateAtom.reportRead();
    return super.deleteState;
  }

  @override
  set deleteState(DeletePatientState value) {
    _$deleteStateAtom.reportWrite(value, super.deleteState, () {
      super.deleteState = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_PatientListViewModelBase.errorMessage', context: context);

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

  late final _$currentPageAtom =
      Atom(name: '_PatientListViewModelBase.currentPage', context: context);

  @override
  int get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(int value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  late final _$perPageAtom =
      Atom(name: '_PatientListViewModelBase.perPage', context: context);

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

  late final _$loadPatientsAsyncAction =
      AsyncAction('_PatientListViewModelBase.loadPatients', context: context);

  @override
  Future<void> loadPatients({bool refresh = false}) {
    return _$loadPatientsAsyncAction
        .run(() => super.loadPatients(refresh: refresh));
  }

  late final _$deletePatientAsyncAction =
      AsyncAction('_PatientListViewModelBase.deletePatient', context: context);

  @override
  Future<void> deletePatient(int patientId) {
    return _$deletePatientAsyncAction.run(() => super.deletePatient(patientId));
  }

  late final _$_PatientListViewModelBaseActionController =
      ActionController(name: '_PatientListViewModelBase', context: context);

  @override
  void resetDeleteState() {
    final _$actionInfo = _$_PatientListViewModelBaseActionController
        .startAction(name: '_PatientListViewModelBase.resetDeleteState');
    try {
      return super.resetDeleteState();
    } finally {
      _$_PatientListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetState() {
    final _$actionInfo = _$_PatientListViewModelBaseActionController
        .startAction(name: '_PatientListViewModelBase.resetState');
    try {
      return super.resetState();
    } finally {
      _$_PatientListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void dispose() {
    final _$actionInfo = _$_PatientListViewModelBaseActionController
        .startAction(name: '_PatientListViewModelBase.dispose');
    try {
      return super.dispose();
    } finally {
      _$_PatientListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
patients: ${patients},
state: ${state},
deleteState: ${deleteState},
errorMessage: ${errorMessage},
currentPage: ${currentPage},
perPage: ${perPage},
isLoading: ${isLoading},
isDeleting: ${isDeleting},
hasPatients: ${hasPatients},
patientsCount: ${patientsCount}
    ''';
  }
}
