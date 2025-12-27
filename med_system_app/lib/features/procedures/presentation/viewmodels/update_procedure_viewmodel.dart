import 'package:distrito_medico/features/procedures/domain/entities/procedure_entity.dart';
import 'package:distrito_medico/features/procedures/domain/usecases/update_procedure_usecase.dart';
import 'package:mobx/mobx.dart';

part 'update_procedure_viewmodel.g.dart';

enum UpdateProcedureState { idle, loading, success, error }

// ignore: library_private_types_in_public_api
class UpdateProcedureViewModel = _UpdateProcedureViewModelBase
    with _$UpdateProcedureViewModel;

abstract class _UpdateProcedureViewModelBase with Store {
  final UpdateProcedureUseCase updateProcedureUseCase;

  _UpdateProcedureViewModelBase({required this.updateProcedureUseCase});

  @observable
  int? procedureId;

  @observable
  String name = '';

  @observable
  String code = '';

  @observable
  String description = '';

  @observable
  String amountCents = '';

  @observable
  UpdateProcedureState state = UpdateProcedureState.idle;

  @observable
  String errorMessage = '';

  @observable
  ProcedureEntity? updatedProcedure;

  @computed
  bool get isLoading => state == UpdateProcedureState.loading;

  @computed
  bool get canSubmit =>
      name.trim().isNotEmpty &&
      code.trim().isNotEmpty &&
      amountCents.trim().isNotEmpty &&
      procedureId != null;

  @action
  void setProcedureId(int id) {
    procedureId = id;
  }

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

  @action
  void loadProcedure(ProcedureEntity procedure) {
    procedureId = procedure.id;
    name = procedure.name;
    code = procedure.code;
    description = procedure.description;
    amountCents = procedure.amountCents;
  }

  String _cleanAmount(String value) {
    return value.replaceAll(RegExp(r'[^0-9]'), '');
  }

  @action
  Future<void> updateProcedure() async {
    if (procedureId == null) {
      errorMessage = 'ID do procedimento não definido';
      state = UpdateProcedureState.error;
      return;
    }

    state = UpdateProcedureState.loading;
    errorMessage = '';

    final params = UpdateProcedureParams(
      id: procedureId!,
      name: name,
      code: code,
      description: description,
      amountCents: _cleanAmount(amountCents),
    );

    final result = await updateProcedureUseCase(params);

    result.fold(
      (failure) {
        errorMessage = failure.message;
        state = UpdateProcedureState.error;
      },
      (procedure) {
        updatedProcedure = procedure;
        state = UpdateProcedureState.success;
      },
    );
  }

  @action
  void resetState() {
    state = UpdateProcedureState.idle;
    errorMessage = '';
  }

  @action
  void reset() {
    procedureId = null;
    name = '';
    code = '';
    description = '';
    amountCents = '';
    state = UpdateProcedureState.idle;
    errorMessage = '';
    updatedProcedure = null;
  }
}
