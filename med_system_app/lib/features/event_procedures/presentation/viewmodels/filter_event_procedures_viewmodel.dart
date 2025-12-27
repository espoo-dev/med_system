import 'package:distrito_medico/features/health_insurances/domain/entities/health_insurance_entity.dart';
import 'package:distrito_medico/features/health_insurances/domain/usecases/get_all_health_insurances_usecase.dart';
import 'package:distrito_medico/features/hospitals/domain/entities/hospital_entity.dart';
import 'package:distrito_medico/features/hospitals/domain/usecases/get_all_hospitals_usecase.dart';
import 'package:mobx/mobx.dart';

part 'filter_event_procedures_viewmodel.g.dart';

// ignore: library_private_types_in_public_api
class FilterEventProceduresViewModel = _FilterEventProceduresViewModelBase
    with _$FilterEventProceduresViewModel;

abstract class _FilterEventProceduresViewModelBase with Store {
  final GetAllHospitalsUseCase _getAllHospitalsUseCase;
  final GetAllHealthInsurancesUseCase _getAllHealthInsurancesUseCase;

  _FilterEventProceduresViewModelBase(
      this._getAllHospitalsUseCase, this._getAllHealthInsurancesUseCase);

  @observable
  ObservableList<HospitalEntity> hospitals = ObservableList<HospitalEntity>();

  @observable
  ObservableList<HealthInsuranceEntity> healthInsurances =
      ObservableList<HealthInsuranceEntity>();

  @observable
  int? selectedYear = DateTime.now().year;

  @observable
  int? selectedMonth = DateTime.now().month;

  @observable
  bool? selectedPaymentStatus;

  @observable
  HospitalEntity? selectedHospital;

  @observable
  HealthInsuranceEntity? selectedHealthInsurance;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @computed
  List<int> get years => List.generate(31, (index) => 2050 - index);

  @computed
  List<int> get months => List.generate(12, (index) => index + 1);

  @action
  Future<void> loadFiltersData() async {
    isLoading = true;
    try {
      await Future.wait([_loadHospitals(), _loadHealthInsurances()]);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  Future<void> _loadHospitals() async {
    final result = await _getAllHospitalsUseCase(const GetAllHospitalsParams());
    result.fold((l) => null, (r) => hospitals.addAll(r));
  }

  Future<void> _loadHealthInsurances() async {
    final result = await _getAllHealthInsurancesUseCase(const GetAllHealthInsurancesParams());
    result.fold((l) => null, (r) => healthInsurances.addAll(r));
  }

  @action
  void setSelectedYear(int? year) => selectedYear = year;

  @action
  void setSelectedMonth(int? month) => selectedMonth = month;

  @action
  void setSelectedPaymentStatus(bool? status) => selectedPaymentStatus = status;

  @action
  void setSelectedHospital(HospitalEntity? hospital) => selectedHospital = hospital;

  @action
  void setSelectedHealthInsurance(HealthInsuranceEntity? insurance) =>
      selectedHealthInsurance = insurance;

  @action
  void clearFilters() {
    selectedYear = null;
    selectedMonth = null;
    selectedPaymentStatus = null;
    selectedHospital = null;
    selectedHealthInsurance = null;
  }
  
  String getMonthName(int month) {
    const monthsNames = [
      'Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun',
      'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'
    ];
    if (month >= 1 && month <= 12) {
      return monthsNames[month - 1];
    }
    return '';
  }
}
