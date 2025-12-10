import 'package:distrito_medico/core/errors/failures.dart';

import 'package:distrito_medico/features/medical_shifts/domain/entities/medical_shift_entity.dart';
import 'package:distrito_medico/features/medical_shifts/domain/entities/medical_shift_list_entity.dart';
import 'package:distrito_medico/features/medical_shifts/domain/usecases/delete_medical_shift_usecase.dart';
import 'package:distrito_medico/features/medical_shifts/domain/usecases/generate_pdf_report_usecase.dart';
import 'package:distrito_medico/features/medical_shifts/domain/usecases/get_medical_shifts_usecase.dart';
import 'package:distrito_medico/features/medical_shifts/domain/usecases/update_payment_status_usecase.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

part 'medical_shifts_list_viewmodel.g.dart';

enum MedicalShiftListState { idle, loading, success, error }
enum MedicalShiftDeleteState { idle, loading, success, error }

class MedicalShiftsListViewModel = _MedicalShiftsListViewModelBase with _$MedicalShiftsListViewModel;

abstract class _MedicalShiftsListViewModelBase with Store {
  final GetMedicalShiftsUseCase getMedicalShiftsUseCase;
  final DeleteMedicalShiftUseCase deleteMedicalShiftUseCase;
  final UpdatePaymentStatusUseCase updatePaymentStatusUseCase;
  final GeneratePdfReportUseCase generatePdfReportUseCase;

  _MedicalShiftsListViewModelBase({
    required this.getMedicalShiftsUseCase,
    required this.deleteMedicalShiftUseCase,
    required this.updatePaymentStatusUseCase,
    required this.generatePdfReportUseCase,
  });

  @observable
  ObservableList<MedicalShiftEntity> medicalShifts = ObservableList<MedicalShiftEntity>();

  @observable
  ObservableList<MedicalShiftEntity> allShiftsForCalendar = ObservableList<MedicalShiftEntity>();

  @observable
  MedicalShiftListState state = MedicalShiftListState.idle;

  @observable
  String errorMessage = '';

  @observable
  int page = 1;

  @observable
  int? selectedMonth;

  @observable
  int? selectedYear;

  @observable
  bool? selectedPaymentStatus;

  @observable
  String? hospitalNameFilter;

  @observable
  DateTime? selectedDateDisplay; // For local filter

  @observable
  String? totalAmount = "";

  @observable
  String? totalPaid = "";

  @observable
  String? totalUnpaid = "";

  // PDF Generation State
  @observable
  bool isGeneratingPdf = false;

  @observable
  MedicalShiftDeleteState deleteState = MedicalShiftDeleteState.idle;

  @observable
  String? pdfPath;

  @action
  void init() {
    selectedMonth = DateTime.now().month;
    selectedYear = DateTime.now().year;
  }

  @action
  Future<void> loadMedicalShifts({bool isRefresh = false}) async {
    if (isRefresh) {
      page = 1;
      medicalShifts.clear();
      allShiftsForCalendar.clear();
    } else {
      page++;
    }

    state = MedicalShiftListState.loading;

    final params = GetMedicalShiftsParams(
      page: page,
      month: selectedMonth,
      year: selectedYear,
      paid: selectedPaymentStatus,
      hospitalName: hospitalNameFilter,
    );

    final result = await getMedicalShiftsUseCase(params);

    result.fold(
      (failure) {
        errorMessage = failure.message ?? "Erro ao carregar plantões";
        state = MedicalShiftListState.error;
      },
      (listEntity) {
        if (isRefresh) {
           // If refreshing, we replace everything
           medicalShifts.addAll(listEntity.items);
           allShiftsForCalendar.addAll(listEntity.items);
        } else {
           medicalShifts.addAll(listEntity.items);
           allShiftsForCalendar.addAll(listEntity.items);
        }
        
        totalAmount = listEntity.total;
        totalPaid = listEntity.totalPaid;
        totalUnpaid = listEntity.totalUnpaid;
        
        state = MedicalShiftListState.success;
      },
    );
  }

  @action
  void setMonthAndYear(int month, int year) {
    selectedMonth = month;
    selectedYear = year;
    loadMedicalShifts(isRefresh: true);
  }

  @action
  void filterByDate(DateTime date) {
    selectedDateDisplay = date;
    
    final filtered = allShiftsForCalendar.where((shift) {
      if (shift.date == null || shift.date!.isEmpty) return false;
      try {
        // Assuming date format is dd/MM/yyyy based on existing code
        final shiftDate = DateFormat('dd/MM/yyyy').parse(shift.date!);
        return shiftDate.year == date.year && 
               shiftDate.month == date.month && 
               shiftDate.day == date.day;
      } catch (e) {
        return false;
      }
    }).toList();

    medicalShifts.clear();
    medicalShifts.addAll(filtered);
  }

  @action
  Future<void> deleteMedicalShift(int id, int index, {int? recurrenceId}) async {
    deleteState = MedicalShiftDeleteState.loading;
    
    final result = await deleteMedicalShiftUseCase(DeleteMedicalShiftParams(
      id: id,
      recurrenceId: recurrenceId,
    ));

    result.fold(
      (failure) {
        errorMessage = failure.message ?? "Erro ao deletar";
        deleteState = MedicalShiftDeleteState.error;
      },
      (success) {
        medicalShifts.removeWhere((e) => e.id == id);
        allShiftsForCalendar.removeWhere((e) => e.id == id);
        deleteState = MedicalShiftDeleteState.success;
      },
    );
  }

  @action
  Future<void> markAsPaid(int id, int index) async {
    final result = await updatePaymentStatusUseCase(UpdatePaymentStatusParams(
      id: id,
      paid: true,
    ));

    result.fold(
      (failure) {
        errorMessage = failure.message ?? "Erro ao atualizar pagamento";
      },
      (updatedEntity) {
        if (index < medicalShifts.length) {
          medicalShifts[index] = medicalShifts[index].copyWith(paid: true);
        }
        // Update in allShifts as well
        final indexInAll = allShiftsForCalendar.indexWhere((e) => e.id == id);
        if (indexInAll != -1) {
          allShiftsForCalendar[indexInAll] = allShiftsForCalendar[indexInAll].copyWith(paid: true);
        }
      },
    );
  }

  @action
  Future<void> generatePdf() async {
    isGeneratingPdf = true;
    pdfPath = null;
    
    final params = GeneratePdfReportParams(
      month: selectedMonth,
      year: selectedYear,
      paid: selectedPaymentStatus,
      hospitalName: hospitalNameFilter,
    );

    final result = await generatePdfReportUseCase(params);

    result.fold(
      (failure) {
        errorMessage = failure.message ?? "Erro ao gerar PDF";
        isGeneratingPdf = false;
      },
      (path) {
        pdfPath = path;
        isGeneratingPdf = false;
      },
    );
  }

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
  void setHospitalNameFilter(String? name) {
    hospitalNameFilter = name;
  }

  @action
  void clearFilters() {
    selectedYear = DateTime.now().year;
    selectedMonth = DateTime.now().month;
    selectedPaymentStatus = null;
    hospitalNameFilter = null;
  }

  /* Helpers */
  List<int> get years {
    int currentYear = DateTime.now().year;
    return List.generate(5, (index) => currentYear - 2 + index); // e.g. 2023,2024,2025,2026,2027
  }

  List<int> get months => List.generate(12, (index) => index + 1);

  String getMonthName(int month) {
    // Basic Portuguese names
    const names = [
      "Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul", "Ago", "Set", "Out", "Nov", "Dez"
    ];
    if (month >= 1 && month <= 12) return names[month - 1];
    return "";
  }
}
