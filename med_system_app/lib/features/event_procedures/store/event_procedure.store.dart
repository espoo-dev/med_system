import 'package:distrito_medico/core/api/api_result.dart';
import 'package:distrito_medico/core/api/network_exceptions.dart';
import 'package:distrito_medico/features/event_procedures/model/event_procedure.model.dart';
import 'package:distrito_medico/features/event_procedures/repository/event_procedure_repository.dart';
import 'package:mobx/mobx.dart';

part 'event_procedure.store.g.dart';

// ignore: library_private_types_in_public_api
class EventProcedureStore = _EventProcedureStoreBase with _$EventProcedureStore;

enum EventProcedureState { idle, success, error, loading }

abstract class _EventProcedureStoreBase with Store {
  final EventProcedureRepository _eventProcedureRepository;

  ObservableList<EventProcedures> eventProcedureList =
      ObservableList<EventProcedures>();

  @observable
  EventProcedureState state = EventProcedureState.idle;

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

  _EventProcedureStoreBase(EventProcedureRepository eventProcedureRepository)
      : _eventProcedureRepository = eventProcedureRepository;

  @action
  getEventProcedures() {}

  @action
  getAllEventProcedures({bool isRefresh = false}) async {
    Result<List<EventProcedures>?>? resultEventProcedures;
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
          .getAllEventProceduresByPayd(_page, true)
          .asObservable();
    } else if (_showUnpaid) {
      resultEventProcedures = await _eventProcedureRepository
          .getAllEventProceduresByPayd(_page, false)
          .asObservable();
    } else if (_showMonth && _month != 0) {
      resultEventProcedures = await _eventProcedureRepository
          .getAllEventProceduresByMonth(_page, month)
          .asObservable();
    } else {
      resultEventProcedures = await _eventProcedureRepository
          .getAllEventProcedures(_page)
          .asObservable();
    }

    resultEventProcedures?.when(
      success: (List<EventProcedures>? listEventProcedures) {
        handleSuccess(listEventProcedures);
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
  dispose() {
    eventProcedureList.clear();
    _page = 1;
    _showAll = true;
    _showPaid = false;
    _showUnpaid = false;
    _showMonth = false;
  }
}
