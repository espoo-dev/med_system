import 'package:distrito_medico/core/api/api_result.dart';
import 'package:distrito_medico/core/api/network_exceptions.dart';
import 'package:distrito_medico/features/event_procedures/model/edit_payment_procedure_request.model.dart';
import 'package:distrito_medico/features/event_procedures/model/event_procedure.model.dart';
import 'package:distrito_medico/features/event_procedures/repository/event_procedure_repository.dart';
import 'package:mobx/mobx.dart';

part 'event_procedure.store.g.dart';

// ignore: library_private_types_in_public_api
class EventProcedureStore = _EventProcedureStoreBase with _$EventProcedureStore;

enum EventProcedureState { idle, success, error, loading }

enum EditEventProcedureState { idle, success, error, loading }

enum DeleteEventProcedureState { idle, success, error, loading }

abstract class _EventProcedureStoreBase with Store {
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
  bool _showAll = false;
  bool? get showAll => _showAll;

  @observable
  bool _showPaid = false;
  bool? get showPaid => _showPaid;

  @observable
  bool _showMonth = true;
  bool? get showMonth => _showMonth;

  @observable
  bool _showUnpaid = false;
  bool? get showUnpaid => _showUnpaid;

  @observable
  int _month = DateTime.now().month;
  get month => _month;

  @action
  updateMonth(int month) {
    _month = month;
  }

  @action
  void updateFilter(bool all, bool paid, bool unpaid, bool month) {
    _showAll = all;
    _showPaid = paid;
    _showUnpaid = unpaid;
    _showMonth = month;
    _page = 1;
  }

  @observable
  String _errorMessage = "";
  get errorMessage => _errorMessage;

  @observable
  int _page = 1;
  get page => _page;

  @observable
  EventProcedureModel? _eventProcedureModel = EventProcedureModel();
  get eventProcedureModel => _eventProcedureModel;

  _EventProcedureStoreBase(EventProcedureRepository eventProcedureRepository)
      : _eventProcedureRepository = eventProcedureRepository;

  @action
  getEventProcedures() {}

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

    if (_showPaid) {
      resultEventProcedures = await _eventProcedureRepository
          .getAllEventProceduresByPayd(_page, 10, true)
          .asObservable();
    } else if (_showUnpaid) {
      resultEventProcedures = await _eventProcedureRepository
          .getAllEventProceduresByPayd(_page, 10, false)
          .asObservable();
    } else if (_showMonth && _month != 0) {
      resultEventProcedures = await _eventProcedureRepository
          .getAllEventProceduresByMonth(_page, 10, month)
          .asObservable();
    } else {
      resultEventProcedures = await _eventProcedureRepository
          .getAllEventProcedures(_page)
          .asObservable();
    }

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
    _showAll = false;
    _showPaid = false;
    _showUnpaid = false;
    _showMonth = true;
    _eventProcedureModel = null;
  }
}
