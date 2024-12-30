import 'package:distrito_medico/core/api/api_result.dart';
import 'package:distrito_medico/core/api/network_exceptions.dart';
import 'package:distrito_medico/features/event_procedures/model/edit_payment_procedure_request.model.dart';
import 'package:distrito_medico/features/event_procedures/model/event_procedure.model.dart';
import 'package:distrito_medico/features/event_procedures/repository/event_procedure_repository.dart';
import 'package:mobx/mobx.dart';

part 'filter_event_procedure_store.g.dart';

class FilterEventProcedureStore = _FilterEventProcedureStore
    with _$FilterEventProcedureStore;

enum EventProcedureState { idle, success, error, loading }

enum EditEventProcedureState { idle, success, error, loading }

enum DeleteEventProcedureState { idle, success, error, loading }

abstract class _FilterEventProcedureStore with Store {
  final EventProcedureRepository _eventProcedureRepository;

  ObservableList<EventProcedures> eventProcedureList =
      ObservableList<EventProcedures>();

  @observable
  EventProcedureState state = EventProcedureState.idle;
  @observable
  EditEventProcedureState editState = EditEventProcedureState.idle;

  @observable
  DeleteEventProcedureState deleteSate = DeleteEventProcedureState.idle;

  @observable
  String _errorMessage = "";
  get errorMessage => _errorMessage;

  @observable
  int _page = 1;
  get page => _page;

  @observable
  EventProcedureModel? _eventProcedureModel = EventProcedureModel();
  get eventProcedureModel => _eventProcedureModel;

  @observable
  int? selectedYear;

  @observable
  int? selectedMonth;

  @observable
  bool? selectedPaymentStatus;

  @observable
  String? hospitalName;

  @observable
  String? healthInsuranceName;

  _FilterEventProcedureStore(EventProcedureRepository eventProcedureRepository)
      : _eventProcedureRepository = eventProcedureRepository;

  List<int> get years {
    int currentYear = DateTime.now().year;
    return List.generate(20, (index) => currentYear - index);
  }

  List<int> get months => List.generate(12, (index) => index + 1);

  @action
  void setSelectedYear(int? year) {
    selectedYear = year;
  }

  @action
  void setSelectedMonth(int? month) {
    selectedMonth = month;
  }

  @action
  void setSelectedPaymentStatus(bool? status) {
    selectedPaymentStatus = status;
  }

  @action
  void setHospitalName(String? name) {
    hospitalName = name;
  }

  @action
  void setHealthInsuranceName(String? name) {
    healthInsuranceName = name;
  }

  @action
  void clearFilters() {
    selectedYear = null;
    selectedMonth = null;
    selectedPaymentStatus = null;
    hospitalName = null;
    healthInsuranceName = null;
  }

  String getMonthName(int month) {
    List<String> months = [
      'Jan',
      'Fev',
      'Mar',
      'Abr',
      'Mai',
      'Jun',
      'Jul',
      'Ago',
      'Set',
      'Out',
      'Nov',
      'Dez'
    ];
    return months[month - 1];
  }

  @action
  getAllEventProcedures({bool isRefresh = false}) async {
    Result<EventProcedureModel?>? resultEventProcedures;
    if (isRefresh) {
      _page = 1;
      eventProcedureList.clear();
    }
    state = EventProcedureState.loading;
    if (!isRefresh) {
      _page++;
    }
    await Future.delayed(const Duration(seconds: 3));

    resultEventProcedures = await _eventProcedureRepository
        .getEventProceduresByFilters(
            page: _page,
            perPage: 10000,
            month: selectedMonth,
            year: selectedYear,
            payd: selectedPaymentStatus,
            healthInsuranceName: healthInsuranceName,
            hospitalName: hospitalName)
        .asObservable();

    resultEventProcedures?.when(
      success: (EventProcedureModel? eventProcedureModel) {
        _eventProcedureModel = eventProcedureModel;
        handleSuccess(eventProcedureModel?.eventProceduresList);
      },
      failure: (NetworkExceptions error) {
        handleError(NetworkExceptions.getErrorMessage(error));
      },
    );
  }

  @action
  getAllEventProceduresByFilters() async {
    Result<EventProcedureModel?>? resultEventProcedures;
    eventProcedureList.clear();
    state = EventProcedureState.loading;

    resultEventProcedures = await _eventProcedureRepository
        .getEventProceduresByFilters(
            page: 1,
            perPage: 10000,
            month: selectedMonth,
            year: selectedYear,
            payd: selectedPaymentStatus,
            healthInsuranceName: healthInsuranceName,
            hospitalName: hospitalName)
        .asObservable();

    resultEventProcedures?.when(
      success: (EventProcedureModel? eventProcedureModel) {
        _eventProcedureModel = eventProcedureModel;
        handleSuccess(eventProcedureModel?.eventProceduresList);
      },
      failure: (NetworkExceptions error) {
        handleError(NetworkExceptions.getErrorMessage(error));
      },
    );
  }

  handleSuccess(List<EventProcedures>? listEventProcedures) {
    eventProcedureList.addAll(listEventProcedures!);
    state = EventProcedureState.success;
  }

  handleError(String reason) {
    _errorMessage = reason;
    state = EventProcedureState.error;
  }

  @action
  deleteEventProcedure(int eventProcedureId, index) async {
    deleteSate = DeleteEventProcedureState.loading;
    var deleteResult =
        await _eventProcedureRepository.deleteEventProcedure(eventProcedureId);
    deleteResult?.when(success: (patient) {
      eventProcedureList.removeAt(index);
      deleteSate = DeleteEventProcedureState.success;
    }, failure: (NetworkExceptions error) {
      handleError(NetworkExceptions.getErrorMessage(error));
      deleteSate = DeleteEventProcedureState.error;
    });
  }

  @action
  editPaymentEventProcedure(int eventProcedureId, index) async {
    editState = EditEventProcedureState.loading;
    var editResult = await _eventProcedureRepository.editPaymentEventProcedure(
        eventProcedureId, EditPaymentEventProcedureModel(payd: true));
    editResult?.when(success: (eventProcedure) {
      eventProcedureList[index] =
          eventProcedureList[index].copyWith(payd: true);
      editState = EditEventProcedureState.success;
    }, failure: (NetworkExceptions error) {
      editState = EditEventProcedureState.error;
      handleError(NetworkExceptions.getErrorMessage(error));
    });
  }

  String getCurrentDate() {
    DateTime currentDate = DateTime.now();
    String day = currentDate.day.toString().padLeft(2, '0');
    String month = currentDate.month.toString().padLeft(2, '0');
    String year = currentDate.year.toString();
    return '$day/$month/$year';
  }

  @action
  dispose() {
    eventProcedureList.clear();
    _page = 1;
    _eventProcedureModel = null;
    selectedMonth = null;
    selectedPaymentStatus = null;
    selectedYear = null;
    hospitalName = null;
    healthInsuranceName = null;
  }
}
