import 'package:med_system_app/core/api/network_exceptions.dart';
import 'package:med_system_app/features/health_insurances/model/health_insurances.model.dart';
import 'package:med_system_app/features/health_insurances/repository/health_insurances_repository.dart';
import 'package:mobx/mobx.dart';
part 'health_insurances.store.g.dart';

// ignore: library_private_types_in_public_api
class HealthInsurancesStore = _HealthInsurancesStoreBase
    with _$HealthInsurancesStore;

enum HealthInsuranceState { idle, success, error, loading }

abstract class _HealthInsurancesStoreBase with Store {
  final HealthInsurancesRepository _healthInsurancesRepository;

  ObservableList<HealthInsurance> healthInsuranceList =
      ObservableList<HealthInsurance>();

  @observable
  HealthInsuranceState state = HealthInsuranceState.idle;

  @observable
  String _errorMessage = "";
  get errorMessage => _errorMessage;

  _HealthInsurancesStoreBase(
      HealthInsurancesRepository healthInsurancesRepository)
      : _healthInsurancesRepository = healthInsurancesRepository;

  @action
  getAllHealthInsurances() async {
    healthInsuranceList.clear();
    state = HealthInsuranceState.loading;
    var resultHealthInsurances =
        await _healthInsurancesRepository.getAllInsurances().asObservable();
    resultHealthInsurances?.when(
        success: (List<HealthInsurance>? listHealthInsurances) {
      healthInsuranceList.addAll(listHealthInsurances!);
      state = HealthInsuranceState.success;
    }, failure: (NetworkExceptions error) {
      handleError(NetworkExceptions.getErrorMessage(error));
      state = HealthInsuranceState.error;
    });
  }

  handleError(String reason) {
    _errorMessage = reason;
  }

  dispose() {
    healthInsuranceList.clear();
  }
}
