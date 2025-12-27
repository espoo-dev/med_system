import 'package:distrito_medico/features/health_insurances/domain/entities/health_insurance_entity.dart';
import 'package:distrito_medico/features/health_insurances/domain/usecases/update_health_insurance_usecase.dart';
import 'package:mobx/mobx.dart';

part 'update_health_insurance_viewmodel.g.dart';

enum UpdateHealthInsuranceState { idle, loading, success, error }

// ignore: library_private_types_in_public_api
class UpdateHealthInsuranceViewModel = _UpdateHealthInsuranceViewModelBase
    with _$UpdateHealthInsuranceViewModel;

abstract class _UpdateHealthInsuranceViewModelBase with Store {
  final UpdateHealthInsuranceUseCase updateHealthInsuranceUseCase;

  _UpdateHealthInsuranceViewModelBase({
    required this.updateHealthInsuranceUseCase,
  });

  @observable
  int? id;

  @observable
  String name = '';

  @observable
  UpdateHealthInsuranceState state = UpdateHealthInsuranceState.idle;

  @observable
  String errorMessage = '';

  @observable
  HealthInsuranceEntity? updatedHealthInsurance;

  @computed
  bool get isLoading => state == UpdateHealthInsuranceState.loading;

  @computed
  bool get canSubmit => id != null && name.trim().isNotEmpty;

  @action
  void setHealthInsurance(HealthInsuranceEntity entity) {
    id = entity.id;
    name = entity.name;
  }

  @action
  void setName(String value) {
    name = value;
  }

  @action
  Future<void> updateHealthInsurance() async {
    if (!canSubmit) return;

    state = UpdateHealthInsuranceState.loading;
    errorMessage = '';

    final params = UpdateHealthInsuranceParams(id: id!, name: name);
    final result = await updateHealthInsuranceUseCase(params);

    result.fold(
      (failure) {
        errorMessage = failure.message;
        state = UpdateHealthInsuranceState.error;
      },
      (entity) {
        updatedHealthInsurance = entity;
        state = UpdateHealthInsuranceState.success;
      },
    );
  }

  @action
  void reset() {
    id = null;
    name = '';
    state = UpdateHealthInsuranceState.idle;
    errorMessage = '';
    updatedHealthInsurance = null;
  }
}
