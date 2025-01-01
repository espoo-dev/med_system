import 'package:distrito_medico/core/api/api_result.dart';
import 'package:distrito_medico/core/api/network_exceptions.dart';
import 'package:distrito_medico/features/medical_shifts/model/edit_payment_medical_shift_request.model.dart';
import 'package:distrito_medico/features/medical_shifts/model/medical_shift.model.dart';
import 'package:distrito_medico/features/medical_shifts/model/medical_shift_list.model.dart';
import 'package:distrito_medico/features/medical_shifts/repository/medical_shift_repository.dart';
import 'package:mobx/mobx.dart';

part 'medical_shift.store.g.dart';

// ignore: library_private_types_in_public_api
class MedicalShiftStore = _MedicalShiftStoreBase with _$MedicalShiftStore;

enum MedicalShiftState { idle, success, error, loading }

enum EditMedicalShiftState { idle, success, error, loading }

enum DeleteMedicalShiftState { idle, success, error, loading }

abstract class _MedicalShiftStoreBase with Store {
  final MedicalShiftRepository _medicalShiftRepository;

  ObservableList<MedicalShiftModel> medicalShiftList =
      ObservableList<MedicalShiftModel>();

  @observable
  MedicalShiftState state = MedicalShiftState.idle;

  @observable
  EditMedicalShiftState editState = EditMedicalShiftState.idle;

  @observable
  DeleteMedicalShiftState deleteState = DeleteMedicalShiftState.idle;

  @observable
  String _errorMessage = "";
  get errorMessage => _errorMessage;

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

  @observable
  int _page = 1;
  get page => _page;

  @observable
  MedicalShiftList? _medicalShift = MedicalShiftList();
  get medicalShift => _medicalShift;

  _MedicalShiftStoreBase(MedicalShiftRepository medicalShiftRepository)
      : _medicalShiftRepository = medicalShiftRepository;

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
  getMedicalShifts() {}

  @action
  getAllMedicalShifts({bool isRefresh = false}) async {
    Result<MedicalShiftList?>? resultMedicalShifts;
    if (isRefresh) {
      _page = 1;
      medicalShiftList.clear();
    }
    state = MedicalShiftState.loading;
    if (!isRefresh) {
      _page++;
    }
    await Future.delayed(const Duration(seconds: 3));

    resultMedicalShifts = await _medicalShiftRepository
        .getMedicalShiftsByFilters(
            page: _page,
            perPage: 10000,
            month: selectedMonth,
            year: selectedYear,
            payd: selectedPaymentStatus,
            hospitalName: hospitalName)
        .asObservable();

    resultMedicalShifts?.when(
      success: (MedicalShiftList? medicalShiftModel) {
        _medicalShift = medicalShiftModel;
        handleSuccess(medicalShiftModel?.medicalShiftModelList);
      },
      failure: (NetworkExceptions error) {
        handleError(NetworkExceptions.getErrorMessage(error));
      },
    );
  }

  @action
  getAllMedicalShiftByFilters({bool isRefresh = false}) async {
    Result<MedicalShiftList?>? resultMedicalShifts;
    medicalShiftList.clear();
    state = MedicalShiftState.loading;

    await Future.delayed(const Duration(seconds: 3));

    resultMedicalShifts = await _medicalShiftRepository
        .getMedicalShiftsByFilters(
            month: selectedMonth,
            year: selectedYear,
            payd: selectedPaymentStatus,
            hospitalName: hospitalName)
        .asObservable();

    resultMedicalShifts?.when(
      success: (MedicalShiftList? medicalShiftModel) {
        _medicalShift = medicalShiftModel;
        handleSuccess(medicalShiftModel?.medicalShiftModelList);
      },
      failure: (NetworkExceptions error) {
        handleError(NetworkExceptions.getErrorMessage(error));
      },
    );
  }

  handleSuccess(List<MedicalShiftModel>? listMedicalShifts) {
    medicalShiftList.addAll(listMedicalShifts!);
    state = MedicalShiftState.success;
  }

  handleError(String reason) {
    _errorMessage = reason;
    state = MedicalShiftState.error;
  }

  @action
  deleteMedicalShift(int medicalShiftId, index) async {
    deleteState = DeleteMedicalShiftState.loading;
    var deleteResult =
        await _medicalShiftRepository.deleteMedicalShift(medicalShiftId);
    deleteResult?.when(success: (shift) {
      medicalShiftList.removeAt(index);
      deleteState = DeleteMedicalShiftState.success;
    }, failure: (NetworkExceptions error) {
      handleError(NetworkExceptions.getErrorMessage(error));
      deleteState = DeleteMedicalShiftState.error;
    });
  }

  @action
  editPaymentMedicalShift(int medicalShiftId, index) async {
    editState = EditMedicalShiftState.loading;
    var editResult = await _medicalShiftRepository.editPaymentMedicalShift(
        medicalShiftId, EditPaymentMedicalShiftModel(payd: true));
    editResult?.when(success: (medicalShift) {
      medicalShiftList[index] = medicalShiftList[index].copyWith(payd: true);
      editState = EditMedicalShiftState.success;
    }, failure: (NetworkExceptions error) {
      editState = EditMedicalShiftState.error;
      handleError(NetworkExceptions.getErrorMessage(error));
    });
  }

  @action
  dispose() {
    medicalShiftList.clear();
    _page = 1;
    _medicalShift = null;
    selectedMonth = null;
    selectedPaymentStatus = null;
    selectedYear = null;
    hospitalName = null;
  }
}
