import 'package:med_system_app/core/api/network_exceptions.dart';
import 'package:med_system_app/features/event_procedures/model/event_procedure.model.dart';
import 'package:med_system_app/features/event_procedures/repository/event_procedure_repository.dart';
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
  String _errorMessage = "";
  get errorMessage => _errorMessage;

  @observable
  int _page = 1;
  get page => _page;

  _EventProcedureStoreBase(EventProcedureRepository eventProcedureRepository)
      : _eventProcedureRepository = eventProcedureRepository;

  @action
  getAllEventProcedures({bool isRefresh = false}) async {
    if (isRefresh) {
      _page = 1;
      eventProcedureList.clear();
    }
    state = EventProcedureState.loading;
    if (!isRefresh) {
      _page++;
    }
    Future.delayed(const Duration(seconds: 3));
    var resultEventProcedures = await _eventProcedureRepository
        .getAllEventProcedures(_page)
        .asObservable();
    resultEventProcedures?.when(
        success: (List<EventProcedures>? listEventProcedures) {
      handleSuccess(listEventProcedures);
    }, failure: (NetworkExceptions error) {
      handleError(NetworkExceptions.getErrorMessage(error));
    });
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
  }
}
