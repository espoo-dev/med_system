import 'package:distrito_medico/features/health_insurances/domain/entities/health_insurance_entity.dart';
import 'package:distrito_medico/features/health_insurances/domain/usecases/create_health_insurance_usecase.dart';
import 'package:mobx/mobx.dart';

part 'create_health_insurance_viewmodel.g.dart';

enum CreateHealthInsuranceState { idle, loading, success, error }

// ignore: library_private_types_in_public_api
class CreateHealthInsuranceViewModel = _CreateHealthInsuranceViewModelBase
    with _$CreateHealthInsuranceViewModel;

abstract class _CreateHealthInsuranceViewModelBase with Store {
  final CreateHealthInsuranceUseCase createHealthInsuranceUseCase;

  _CreateHealthInsuranceViewModelBase({
    required this.createHealthInsuranceUseCase,
  });

  @observable
  String name = '';

  @observable
  CreateHealthInsuranceState state = CreateHealthInsuranceState.idle;

  @observable
  String errorMessage = '';

  @observable
  HealthInsuranceEntity? createdHealthInsurance;

  @computed
  bool get isLoading => state == CreateHealthInsuranceState.loading;

  @computed
  bool get canSubmit => name.trim().isNotEmpty;

  @action
  void setName(String value) {
    name = value;
  }

  @action
  Future<void> createHealthInsurance() async {
    if (!canSubmit) return;

    state = CreateHealthInsuranceState.loading;
    errorMessage = '';

    final params = CreateHealthInsuranceParams(name: name);
    final result = await createHealthInsuranceUseCase(params);

    result.fold(
      (failure) {
        errorMessage = failure.message;
        state = CreateHealthInsuranceState.error;
      },
      (entity) {
        createdHealthInsurance = entity;
        state = CreateHealthInsuranceState.success;
      },
    );
  }

  @action
  void reset() {
    name = '';
    state = CreateHealthInsuranceState.idle;
    errorMessage = '';
    createdHealthInsurance = null;
  }
}
