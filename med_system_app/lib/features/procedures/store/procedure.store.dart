import 'package:distrito_medico/core/api/network_exceptions.dart';
import 'package:distrito_medico/features/procedures/model/procedure.model.dart';
import 'package:distrito_medico/features/procedures/repository/procedure_repository.dart';
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

  @observable
  int _page = 1;
  get page => _page;

  _ProcedureStoreBase(ProcedureRepository procedureRepository)
      : _procedureRepository = procedureRepository;

  @action
  getAllProcedures({bool isRefresh = false}) async {
    if (isRefresh) {
      _page = 1;
      procedureList.clear();
    }
    state = ProcedureState.loading;
    if (!isRefresh) {
      _page++;
    }
    var resultProcedures =
        await _procedureRepository.getAllProcedures(_page).asObservable();
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
    _page = 1;
  }
}
