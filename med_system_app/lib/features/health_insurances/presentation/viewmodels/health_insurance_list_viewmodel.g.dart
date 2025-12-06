// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_insurance_list_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HealthInsuranceListViewModel
    on _HealthInsuranceListViewModelBase, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_HealthInsuranceListViewModelBase.isLoading'))
          .value;

  late final _$stateAtom =
      Atom(name: '_HealthInsuranceListViewModelBase.state', context: context);

  @override
  HealthInsuranceListState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(HealthInsuranceListState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$healthInsurancesAtom = Atom(
      name: '_HealthInsuranceListViewModelBase.healthInsurances',
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

  late final _$errorMessageAtom = Atom(
      name: '_HealthInsuranceListViewModelBase.errorMessage', context: context);

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

  late final _$hasMoreAtom =
      Atom(name: '_HealthInsuranceListViewModelBase.hasMore', context: context);

  @override
  bool get hasMore {
    _$hasMoreAtom.reportRead();
    return super.hasMore;
  }

  @override
  set hasMore(bool value) {
    _$hasMoreAtom.reportWrite(value, super.hasMore, () {
      super.hasMore = value;
    });
  }

  late final _$loadHealthInsurancesAsyncAction = AsyncAction(
      '_HealthInsuranceListViewModelBase.loadHealthInsurances',
      context: context);

  @override
  Future<void> loadHealthInsurances({bool refresh = false}) {
    return _$loadHealthInsurancesAsyncAction
        .run(() => super.loadHealthInsurances(refresh: refresh));
  }

  @override
  String toString() {
    return '''
state: ${state},
healthInsurances: ${healthInsurances},
errorMessage: ${errorMessage},
hasMore: ${hasMore},
isLoading: ${isLoading}
    ''';
  }
}
