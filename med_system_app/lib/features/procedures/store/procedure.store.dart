import 'package:med_system_app/core/api/network_exceptions.dart';
import 'package:med_system_app/features/procedures/model/procedure.model.dart';
import 'package:med_system_app/features/procedures/repository/procedure_repository.dart';
import 'package:mobx/mobx.dart';
part 'procedure.store.g.dart';

// ignore: library_private_types_in_public_api
class ProcedureStore = _ProcedureStoreBase with _$ProcedureStore;

enum ProcedureState { idle, success, error, loading }

abstract class _ProcedureStoreBase with Store {
  final ProcedureRepository _procedureRepository;

  ObservableList<Procedure> procedureList = ObservableList<Procedure>();

  @observable
  ProcedureState state = ProcedureState.idle;

  @observable
  String _errorMessage = "";
  get errorMessage => _errorMessage;

  _ProcedureStoreBase(ProcedureRepository procedureRepository)
      : _procedureRepository = procedureRepository;

  @action
  Future getAllProcedures() async {
    procedureList.clear();
    state = ProcedureState.loading;
    var resultProcedures =
        await _procedureRepository.getAllProcedures().asObservable();
    resultProcedures?.when(success: (List<Procedure>? listProcedures) {
      procedureList.addAll(listProcedures!);
      state = ProcedureState.success;
    }, failure: (NetworkExceptions error) {
      handleError(NetworkExceptions.getErrorMessage(error));
      state = ProcedureState.error;
    });
  }

  handleError(String reason) {
    _errorMessage = reason;
  }

  dispose() {
    procedureList.clear();
  }
}
