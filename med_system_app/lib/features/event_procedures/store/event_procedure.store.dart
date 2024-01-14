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

  _EventProcedureStoreBase(EventProcedureRepository eventProcedureRepository)
      : _eventProcedureRepository = eventProcedureRepository;

  @action
  getAllEventProcedures() async {
    eventProcedureList.clear();
    state = EventProcedureState.loading;
    var resultEventProcedures =
        await _eventProcedureRepository.getAllEventProcedures().asObservable();
    resultEventProcedures?.when(
        success: (List<EventProcedures>? listEventProcedures) {
      eventProcedureList.addAll(listEventProcedures!);
      state = EventProcedureState.success;
    }, failure: (NetworkExceptions error) {
      handleError(NetworkExceptions.getErrorMessage(error));
      state = EventProcedureState.error;
    });
  }

  handleError(String reason) {
    _errorMessage = reason;
  }

  dispose() {
    eventProcedureList.clear();
  }
}
