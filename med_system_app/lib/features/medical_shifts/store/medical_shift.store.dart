import 'package:distrito_medico/core/api/api_result.dart';
import 'package:distrito_medico/core/api/network_exceptions.dart';
import 'package:distrito_medico/features/medical_shifts/model/medical_shift.model.dart';
import 'package:distrito_medico/features/medical_shifts/model/medical_shift_list.model.dart';
import 'package:distrito_medico/features/medical_shifts/repository/medical_shift_repository.dart';
import 'package:mobx/mobx.dart';

part 'medical_shift.store.g.dart';

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
  MedicalShiftList? _medicalShift = MedicalShiftList();
  get medicalShift => _medicalShift;

  _MedicalShiftStoreBase(MedicalShiftRepository medicalShiftRepository)
      : _medicalShiftRepository = medicalShiftRepository;

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

    if (_showPaid) {
      resultMedicalShifts = await _medicalShiftRepository
          .getAllMedicalShiftsByPayd(_page, 10000, true)
          .asObservable();
    } else if (_showUnpaid) {
      resultMedicalShifts = await _medicalShiftRepository
          .getAllMedicalShiftsByPayd(_page, 10000, false)
          .asObservable();
    } else if (_showMonth && _month != 0) {
      resultMedicalShifts = await _medicalShiftRepository
          .getAllMedicalShiftsByMonth(_page, 10000, month)
          .asObservable();
    } else {
      resultMedicalShifts = await _medicalShiftRepository
          .getAllMedicalShifts(_page)
          .asObservable();
    }

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

  // @action
  // deleteMedicalShift(int medicalShiftId, index) async {
  //   deleteState = DeleteMedicalShiftState.loading;
  //   var deleteResult =
  //       await _medicalShiftRepository.deleteMedicalShift(medicalShiftId);
  //   deleteResult?.when(success: (shift) {
  //     medicalShiftList.removeAt(index);
  //     deleteState = DeleteMedicalShiftState.success;
  //   }, failure: (NetworkExceptions error) {
  //     handleError(NetworkExceptions.getErrorMessage(error));
  //     deleteState = DeleteMedicalShiftState.error;
  //   });
  // }

  // @action
  // editPaymentMedicalShift(int medicalShiftId, index) async {
  //   editState = EditMedicalShiftState.loading;
  //   var editResult = await _medicalShiftRepository.editPaymentMedicalShift(
  //       medicalShiftId, EditPaymentMedicalShiftRequestModel(paid: true));
  //   editResult?.when(success: (medicalShift) {
  //     medicalShiftList[index] = medicalShiftList[index].copyWith(paid: true);
  //     editState = EditMedicalShiftState.success;
  //   }, failure: (NetworkExceptions error) {
  //     editState = EditMedicalShiftState.error;
  //     handleError(NetworkExceptions.getErrorMessage(error));
  //   });
  // }

  String getCurrentDate() {
    DateTime currentDate = DateTime.now();
    String day = currentDate.day.toString().padLeft(2, '0');
    String month = currentDate.month.toString().padLeft(2, '0');
    String year = currentDate.year.toString();
    return '$day/$month/$year';
  }

  @action
  dispose() {
    medicalShiftList.clear();
    _page = 1;
    _showAll = false;
    _showPaid = false;
    _showUnpaid = false;
    _showMonth = true;
    _medicalShift = null;
  }
}
