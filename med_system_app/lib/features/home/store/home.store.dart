import 'package:distrito_medico/core/api/network_exceptions.dart';
import 'package:distrito_medico/features/event_procedures/model/event_procedure.model.dart';
import 'package:distrito_medico/features/home/repository/home_repository.dart';
import 'package:distrito_medico/features/medical_shifts/model/medical_shift.model.dart';
import 'package:distrito_medico/features/medical_shifts/model/medical_shift_list.model.dart';
import 'package:mobx/mobx.dart';

part 'home.store.g.dart';

// ignore: library_private_types_in_public_api
class HomeStore = _HomeStoreBase with _$HomeStore;

enum HomeState { idle, success, error, loading }

enum HomeFilterType { procedures, medicalShifts }

abstract class _HomeStoreBase with Store {
  final HomeRepository _homeRepository;

  ObservableList<EventProcedures> eventProcedureList =
      ObservableList<EventProcedures>();

  ObservableList<MedicalShiftModel> medicalShiftList =
      ObservableList<MedicalShiftModel>();

  @observable
  MedicalShiftList? _medicalShift = MedicalShiftList();
  get medicalShift => _medicalShift;

  @observable
  HomeState state = HomeState.idle;

  @observable
  String _errorMessage = "";
  get errorMessage => _errorMessage;

  @observable
  EventProcedureModel? _eventProcedureModel;
  get eventProcedureModel => _eventProcedureModel;

  @computed
  bool get showBottomAppBar =>
      state == HomeState.success && eventProcedureList.isNotEmpty;
  @computed
  bool get showFloatingActionButton =>
      state == HomeState.success && eventProcedureList.isNotEmpty;

  @observable
  HomeFilterType selectedFilter = HomeFilterType.procedures;

  @action
  void setSelectedFilter(HomeFilterType filter) {
    selectedFilter = filter;
  }

  _HomeStoreBase(HomeRepository homeRepository)
      : _homeRepository = homeRepository;

  @action
  fetchAllData() async {
    try {
      state = HomeState.loading;

      await Future.wait([
        getLatestEventProcedures(),
        getLatestMedicalShifts(),
      ]);

      state = HomeState.success;
    } catch (error) {
      state = HomeState.error;
      handleError(error.toString());
    }
  }

  @action
  Future getLatestEventProcedures() async {
    eventProcedureList.clear();

    var resultEventProcedures =
        await _homeRepository.getLatestEventProcedures().asObservable();
    resultEventProcedures?.when(
        success: (EventProcedureModel? eventProcedureModel) {
      handleSuccess(eventProcedureModel?.eventProceduresList);
      _eventProcedureModel = eventProcedureModel;
    }, failure: (NetworkExceptions error) {
      handleError(NetworkExceptions.getErrorMessage(error));
    });
  }

  @action
  Future getLatestMedicalShifts() async {
    medicalShiftList.clear();

    var resultMedicalShifts =
        await _homeRepository.getLatestMedicalShifts().asObservable();
    resultMedicalShifts?.when(success: (MedicalShiftList? medicalShiftModel) {
      _medicalShift = medicalShiftModel;
      handleMedicalShiftSuccess(medicalShiftModel?.medicalShiftModelList);
    }, failure: (NetworkExceptions error) {
      handleError(NetworkExceptions.getErrorMessage(error));
    });
  }

  handleMedicalShiftSuccess(List<MedicalShiftModel>? listMedicalShifts) {
    medicalShiftList.addAll(listMedicalShifts!);
  }

  handleSuccess(List<EventProcedures>? listEventProcedures) {
    eventProcedureList.addAll(listEventProcedures!);
  }

  handleError(String reason) {
    _errorMessage = reason;
  }

  @action
  dispose() {
    eventProcedureList.clear();
  }
}
