import 'package:distrito_medico/features/procedures/domain/entities/procedure_entity.dart';
import 'package:distrito_medico/features/procedures/domain/usecases/get_all_procedures_usecase.dart';
import 'package:mobx/mobx.dart';

part 'procedure_list_viewmodel.g.dart';

enum ProcedureListState { idle, loading, success, error }

// ignore: library_private_types_in_public_api
class ProcedureListViewModel = _ProcedureListViewModelBase
    with _$ProcedureListViewModel;

abstract class _ProcedureListViewModelBase with Store {
  final GetAllProceduresUseCase getAllProceduresUseCase;

  _ProcedureListViewModelBase({
    required this.getAllProceduresUseCase,
  });

  @observable
  ObservableList<ProcedureEntity> procedures = ObservableList<ProcedureEntity>();

  @observable
  ProcedureListState state = ProcedureListState.idle;

  @observable
  String errorMessage = '';

  @observable
  int currentPage = 1;

  @observable
  int perPage = 10;

  @computed
  bool get isLoading => state == ProcedureListState.loading;

  @computed
  bool get hasProcedures => procedures.isNotEmpty;

  @computed
  int get proceduresCount => procedures.length;

  @action
  Future<void> loadProcedures({bool refresh = false}) async {
    if (refresh) {
      currentPage = 1;
      procedures.clear();
    }

    state = ProcedureListState.loading;
    errorMessage = '';

    final params = GetAllProceduresParams(
      page: currentPage,
      perPage: perPage,
    );

    final result = await getAllProceduresUseCase(params);

    result.fold(
      (failure) {
        errorMessage = failure.message;
        state = ProcedureListState.error;
      },
      (procedureList) {
        if (refresh) {
          procedures.clear();
        }
        procedures.addAll(procedureList);
        state = ProcedureListState.success;
        
        if (!refresh) {
          currentPage++;
        }
      },
    );
  }

  @action
  void resetState() {
    state = ProcedureListState.idle;
    errorMessage = '';
  }

  @action
  void dispose() {
    procedures.clear();
    currentPage = 1;
    state = ProcedureListState.idle;
  }
}
