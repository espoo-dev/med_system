// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hospital_list_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HospitalListViewModel on _HospitalListViewModelBase, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_HospitalListViewModelBase.isLoading'))
          .value;
  Computed<bool>? _$hasHospitalsComputed;

  @override
  bool get hasHospitals =>
      (_$hasHospitalsComputed ??= Computed<bool>(() => super.hasHospitals,
              name: '_HospitalListViewModelBase.hasHospitals'))
          .value;
  Computed<int>? _$hospitalsCountComputed;

  @override
  int get hospitalsCount =>
      (_$hospitalsCountComputed ??= Computed<int>(() => super.hospitalsCount,
              name: '_HospitalListViewModelBase.hospitalsCount'))
          .value;

  late final _$hospitalsAtom =
      Atom(name: '_HospitalListViewModelBase.hospitals', context: context);

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

  late final _$stateAtom =
      Atom(name: '_HospitalListViewModelBase.state', context: context);

  @override
  HospitalListState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(HospitalListState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_HospitalListViewModelBase.errorMessage', context: context);

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
      Atom(name: '_HospitalListViewModelBase.currentPage', context: context);

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
      Atom(name: '_HospitalListViewModelBase.perPage', context: context);

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

  late final _$loadHospitalsAsyncAction =
      AsyncAction('_HospitalListViewModelBase.loadHospitals', context: context);

  @override
  Future<void> loadHospitals({bool refresh = false}) {
    return _$loadHospitalsAsyncAction
        .run(() => super.loadHospitals(refresh: refresh));
  }

  late final _$_HospitalListViewModelBaseActionController =
      ActionController(name: '_HospitalListViewModelBase', context: context);

  @override
  void resetState() {
    final _$actionInfo = _$_HospitalListViewModelBaseActionController
        .startAction(name: '_HospitalListViewModelBase.resetState');
    try {
      return super.resetState();
    } finally {
      _$_HospitalListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void dispose() {
    final _$actionInfo = _$_HospitalListViewModelBaseActionController
        .startAction(name: '_HospitalListViewModelBase.dispose');
    try {
      return super.dispose();
    } finally {
      _$_HospitalListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
hospitals: ${hospitals},
state: ${state},
errorMessage: ${errorMessage},
currentPage: ${currentPage},
perPage: ${perPage},
isLoading: ${isLoading},
hasHospitals: ${hasHospitals},
hospitalsCount: ${hospitalsCount}
    ''';
  }
}
