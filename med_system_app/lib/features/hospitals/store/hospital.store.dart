import 'package:med_system_app/core/api/network_exceptions.dart';
import 'package:med_system_app/features/hospitals/model/hospital.model.dart';
import 'package:med_system_app/features/hospitals/respository/hospital_repository.dart';
import 'package:mobx/mobx.dart';
part 'hospital.store.g.dart';

// ignore: library_private_types_in_public_api
class HospitalStore = _HospitalStoreBase with _$HospitalStore;

enum HospitalState { idle, success, error, loading }

abstract class _HospitalStoreBase with Store {
  final HospitalRepository _hospitalRepository;

  ObservableList<Hospital> hospitalList = ObservableList<Hospital>();

  @observable
  HospitalState state = HospitalState.idle;

  @observable
  String _errorMessage = "";
  get errorMessage => _errorMessage;

  _HospitalStoreBase(HospitalRepository hospitalRepository)
      : _hospitalRepository = hospitalRepository;

  @action
  getAllHospitals() async {
    hospitalList.clear();
    state = HospitalState.loading;
    var resultHospital =
        await _hospitalRepository.getAllHospitals().asObservable();
    resultHospital?.when(success: (List<Hospital>? listHospital) {
      hospitalList.addAll(listHospital!);
      state = HospitalState.success;
    }, failure: (NetworkExceptions error) {
      handleError(NetworkExceptions.getErrorMessage(error));
      state = HospitalState.error;
    });
  }

  handleError(String reason) {
    _errorMessage = reason;
  }

  dispose() {
    hospitalList.clear();
  }
}
