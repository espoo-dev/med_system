import 'package:distrito_medico/features/health_insurances/domain/entities/health_insurance_entity.dart';
import 'package:distrito_medico/features/health_insurances/domain/usecases/get_all_health_insurances_usecase.dart';
import 'package:mobx/mobx.dart';

part 'health_insurance_list_viewmodel.g.dart';

enum HealthInsuranceListState { idle, loading, success, error }

// ignore: library_private_types_in_public_api
class HealthInsuranceListViewModel = _HealthInsuranceListViewModelBase
    with _$HealthInsuranceListViewModel;

abstract class _HealthInsuranceListViewModelBase with Store {
  final GetAllHealthInsurancesUseCase getAllHealthInsurancesUseCase;

  _HealthInsuranceListViewModelBase({
    required this.getAllHealthInsurancesUseCase,
  });

  @observable
  HealthInsuranceListState state = HealthInsuranceListState.idle;

  @observable
  ObservableList<HealthInsuranceEntity> healthInsurances =
      ObservableList<HealthInsuranceEntity>();

  @observable
  String errorMessage = '';

  @observable
  bool hasMore = true;

  int _currentPage = 1;
  final int _perPage = 20;

  @computed
  bool get isLoading => state == HealthInsuranceListState.loading;

  @action
  Future<void> loadHealthInsurances({bool refresh = false}) async {
    if (refresh) {
      _currentPage = 1;
      healthInsurances.clear();
      hasMore = true;
    }

    if (!hasMore && !refresh) return;

    state = HealthInsuranceListState.loading;

    final params = GetAllHealthInsurancesParams(
      page: _currentPage,
      perPage: _perPage,
    );

    final result = await getAllHealthInsurancesUseCase(params);

    result.fold(
      (failure) {
        errorMessage = failure.message;
        state = HealthInsuranceListState.error;
      },
      (list) {
        if (list.length < _perPage) {
          hasMore = false;
        }
        healthInsurances.addAll(list);
        _currentPage++;
        state = HealthInsuranceListState.success;
      },
    );
  }
}
