import 'package:distrito_medico/features/procedures/domain/entities/procedure_entity.dart';
import 'package:distrito_medico/features/procedures/domain/usecases/create_procedure_usecase.dart';
import 'package:mobx/mobx.dart';

part 'create_procedure_viewmodel.g.dart';

enum CreateProcedureState { idle, loading, success, error }

// ignore: library_private_types_in_public_api
class CreateProcedureViewModel = _CreateProcedureViewModelBase
    with _$CreateProcedureViewModel;

abstract class _CreateProcedureViewModelBase with Store {
  final CreateProcedureUseCase createProcedureUseCase;

  _CreateProcedureViewModelBase({required this.createProcedureUseCase});

  @observable
  String name = '';

  @observable
  String code = '';

  @observable
  String description = '';

  @observable
  String amountCents = '';

  @observable
  CreateProcedureState state = CreateProcedureState.idle;

  @observable
  String errorMessage = '';

  @observable
  ProcedureEntity? createdProcedure;

  @computed
  bool get isLoading => state == CreateProcedureState.loading;

  @computed
  bool get canSubmit =>
      name.trim().isNotEmpty &&
      code.trim().isNotEmpty &&
      amountCents.trim().isNotEmpty;

  @action
  void setName(String value) {
    name = value;
  }

  @action
  void setCode(String value) {
    code = value;
  }

  @action
  void setDescription(String value) {
    description = value;
  }

  @action
  void setAmountCents(String value) {
    amountCents = value;
  }

  String _cleanAmount(String value) {
    return value.replaceAll(RegExp(r'[^0-9]'), '');
  }

  @action
  Future<void> createProcedure() async {
    state = CreateProcedureState.loading;
    errorMessage = '';

    final params = CreateProcedureParams(
      name: name,
      code: code,
      description: description,
      amountCents: _cleanAmount(amountCents),
    );
    final result = await createProcedureUseCase(params);

    result.fold(
      (failure) {
        errorMessage = failure.message;
        state = CreateProcedureState.error;
      },
      (procedure) {
        createdProcedure = procedure;
        state = CreateProcedureState.success;
      },
    );
  }

  @action
  void resetState() {
    state = CreateProcedureState.idle;
    errorMessage = '';
  }

  @action
  void reset() {
    name = '';
    code = '';
    description = '';
    amountCents = '';
    state = CreateProcedureState.idle;
    errorMessage = '';
    createdProcedure = null;
  }
}
