import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import '../../../../core/errors/failures.dart';
import '../../../event_procedures/domain/entities/event_procedure_entity.dart';
import '../../../medical_shifts/domain/entities/medical_shift_entity.dart';
import '../../domain/usecases/get_latest_event_procedures_usecase.dart';
import '../../domain/usecases/get_latest_medical_shifts_usecase.dart';

part 'home_viewmodel.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

enum HomeFilterType { procedures, medicalShifts }

abstract class _HomeViewModelBase with Store {
  final GetLatestEventProceduresUseCase _getLatestEventProceduresUseCase;
  final GetLatestMedicalShiftsUseCase _getLatestMedicalShiftsUseCase;

  _HomeViewModelBase(
    this._getLatestEventProceduresUseCase,
    this._getLatestMedicalShiftsUseCase,
  );

  /* State */
  @observable
  ObservableList<EventProcedureEntity> eventProcedures =
      ObservableList<EventProcedureEntity>();

  @observable
  ObservableList<MedicalShiftEntity> medicalShifts =
      ObservableList<MedicalShiftEntity>();

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  HomeFilterType selectedFilter = HomeFilterType.procedures;

  @observable
  String _totalProcedures = "0,00";

  @observable
  String _totalPaidProcedures = "0,00";

  @observable
  String _totalUnpaidProcedures = "0,00";

  @observable
  String _totalMedicalShifts = "0,00";

  @observable
  String _totalPaidMedicalShifts = "0,00";

  @observable
  String _totalUnpaidMedicalShifts = "0,00";

  /* Computed */
  @computed
  bool get showBottomAppBar => !isLoading && eventProcedures.isNotEmpty;

  @computed
  bool get showFloatingActionButton =>
      !isLoading && eventProcedures.isNotEmpty;

  @computed
  bool get hasData =>
      eventProcedures.isNotEmpty || medicalShifts.isNotEmpty;

  @computed
  String get totalProcedures => _totalProcedures;

  @computed
  String get totalPaidProcedures => _totalPaidProcedures;

  @computed
  String get totalUnpaidProcedures => _totalUnpaidProcedures;

  @computed
  String get totalMedicalShifts => _totalMedicalShifts;

  @computed
  String get totalPaidMedicalShifts => _totalPaidMedicalShifts;

  @computed
  String get totalUnpaidMedicalShifts => _totalUnpaidMedicalShifts;

  String _formatCurrency(double value) {
    return NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(value);
  }

  /* Actions */
  @action
  void setSelectedFilter(HomeFilterType filter) {
    selectedFilter = filter;
  }

  @action
  Future<void> fetchAllData() async {
    isLoading = true;
    errorMessage = null;

    try {
      await Future.wait([
        loadLatestEventProcedures(),
        loadLatestMedicalShifts(),
      ]);
    } catch (e) {
      errorMessage = 'Erro ao carregar dados: ${e.toString()}';
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> loadLatestEventProcedures() async {
    final result = await _getLatestEventProceduresUseCase(
      const GetLatestEventProceduresParams(),
    );

    result.fold(
      (failure) {
        errorMessage = _mapFailureToMessage(failure);
      },
      (listEntity) {
        eventProcedures.clear();
        eventProcedures.addAll(listEntity.items);
        _totalProcedures = listEntity.total;
        _totalPaidProcedures = listEntity.totalPaid;
        _totalUnpaidProcedures = listEntity.totalUnpaid;
      },
    );
  }

  @action
  Future<void> loadLatestMedicalShifts() async {
    final result = await _getLatestMedicalShiftsUseCase(
      const GetLatestMedicalShiftsParams(),
    );

    result.fold(
      (failure) {
        errorMessage = _mapFailureToMessage(failure);
      },
      (listEntity) {
        medicalShifts.clear();
        medicalShifts.addAll(listEntity.items);
        _totalMedicalShifts = listEntity.total;
        _totalPaidMedicalShifts = listEntity.totalPaid;
        _totalUnpaidMedicalShifts = listEntity.totalUnpaid;
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    }
    return 'Erro ao conectar com o servidor.';
  }
}
