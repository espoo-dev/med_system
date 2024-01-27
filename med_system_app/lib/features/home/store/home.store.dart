import 'package:med_system_app/core/api/network_exceptions.dart';
import 'package:med_system_app/features/event_procedures/model/event_procedure.model.dart';
import 'package:med_system_app/features/home/repository/home_repository.dart';
import 'package:mobx/mobx.dart';
part 'home.store.g.dart';

// ignore: library_private_types_in_public_api
class HomeStore = _HomeStoreBase with _$HomeStore;

enum EventProcedureState { idle, success, error, loading }

abstract class _HomeStoreBase with Store {
  final HomeRepository _homeRepository;

  ObservableList<EventProcedures> eventProcedureList =
      ObservableList<EventProcedures>();

  @observable
  EventProcedureState state = EventProcedureState.idle;

  @observable
  String _errorMessage = "";
  get errorMessage => _errorMessage;

  @observable
  EventProcedureModel? _eventProcedureModel;
  get eventProcedureModel => _eventProcedureModel;

  _HomeStoreBase(HomeRepository homeRepository)
      : _homeRepository = homeRepository;

  @action
  getLatestEventProcedures() async {
    eventProcedureList.clear();

    state = EventProcedureState.loading;

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
  }
}
