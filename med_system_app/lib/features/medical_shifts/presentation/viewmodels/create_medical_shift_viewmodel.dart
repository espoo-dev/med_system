import 'package:distrito_medico/features/medical_shifts/domain/usecases/create_medical_shift_usecase.dart';
import 'package:distrito_medico/features/medical_shifts/domain/usecases/create_medical_shift_recurrence_usecase.dart';
import 'package:distrito_medico/features/medical_shifts/domain/usecases/get_amount_suggestions_usecase.dart';
import 'package:distrito_medico/features/medical_shifts/domain/usecases/get_hospital_suggestions_usecase.dart';
import 'package:mobx/mobx.dart';
import 'package:distrito_medico/core/usecases/usecase.dart';

part 'create_medical_shift_viewmodel.g.dart';

enum CreateMedicalShiftState { idle, loading, success, error }

// ignore: library_private_types_in_public_api
class CreateMedicalShiftViewModel = _CreateMedicalShiftViewModelBase with _$CreateMedicalShiftViewModel;

abstract class _CreateMedicalShiftViewModelBase with Store {
  final CreateMedicalShiftUseCase createMedicalShiftUseCase;
  final CreateMedicalShiftRecurrenceUseCase createMedicalShiftRecurrenceUseCase;
  final GetHospitalSuggestionsUseCase getHospitalSuggestionsUseCase;
  final GetAmountSuggestionsUseCase getAmountSuggestionsUseCase;

  _CreateMedicalShiftViewModelBase({
    required this.createMedicalShiftUseCase,
    required this.createMedicalShiftRecurrenceUseCase,
    required this.getHospitalSuggestionsUseCase,
    required this.getAmountSuggestionsUseCase,
  });

  @observable
  String hospitalName = '';

  @observable
  String workload = '';

  @observable
  String startDate = '';

  @observable
  String startHour = '';

  @observable
  double amount = 0.0;

  @observable
  bool paid = false;

  @observable
  bool isRecurrent = false;

  @observable
  String? frequency;

  @observable
  int? dayOfWeek;

  @observable
  int? dayOfMonth;

  @observable
  String? endDate;

  @observable
  CreateMedicalShiftState state = CreateMedicalShiftState.idle;

  @observable
  String errorMessage = '';
  
  @observable
  ObservableList<String> hospitalSuggestions = ObservableList<String>();

  @observable
  ObservableList<String> amountSuggestions = ObservableList<String>();

  @computed
  bool get isValidData =>
      hospitalName.isNotEmpty &&
      workload.isNotEmpty &&
      startDate.isNotEmpty &&
      startHour.isNotEmpty &&
      amount > 0;

  @action
  void setHospitalName(String value) => hospitalName = value;

  @action
  void setWorkload(String value) => workload = value;

  @action
  void setStartDate(String value) => startDate = value;

  @action
  void setStartHour(String value) => startHour = value;

  @action
  void setAmount(double value) => amount = value;

  @action
  void setAmountCents(String text) {
    String cleanedText = text.replaceAll(RegExp('[^0-9]'), '');
    int value = int.tryParse(cleanedText) ?? 0;
    amount = value / 100.0;
  }

  @action
  void setPaid(bool value) => paid = value;

  @action
  void setIsRecurrent(bool value) {
    isRecurrent = value;
    if (!value) {
      frequency = null;
      dayOfWeek = null;
      dayOfMonth = null;
      endDate = null;
    }
  }

  @action
  void setFrequency(String? value) {
    frequency = value;
    if (value != 'monthly_fixed_day') {
      dayOfMonth = null;
    }
    if (value == 'monthly_fixed_day') {
      dayOfWeek = null;
    }
  }

  @action
  void setDayOfWeek(int? value) => dayOfWeek = value;

  @action
  void setDayOfMonth(int? value) => dayOfMonth = value;

  @action
  void setEndDate(String? value) => endDate = value;

  @action
  Future<void> loadSuggestions() async {
    final hospResult = await getHospitalSuggestionsUseCase(const NoParams());
    hospResult.fold((l) {}, (r) => hospitalSuggestions = ObservableList.of(r));
    
    final amountResult = await getAmountSuggestionsUseCase(const NoParams());
    amountResult.fold((l) {}, (r) => amountSuggestions = ObservableList.of(r));
  }

  @action
  Future<void> createMedicalShift() async {
    if (!isValidData) return;

    state = CreateMedicalShiftState.loading;
    errorMessage = '';

    final params = CreateMedicalShiftParams(
      hospitalName: hospitalName,
      workload: workload,
      startDate: startDate,
      startHour: startHour,
      amount: amount,
      paid: paid,
    );

    final result = await createMedicalShiftUseCase(params);

    await result.fold(
      (failure) async {
        errorMessage = failure.message;
        state = CreateMedicalShiftState.error;
      },
      (entity) async {
        if (isRecurrent && frequency != null) {
          await _createRecurrence();
        }
        state = CreateMedicalShiftState.success;
      },
    );
  }

  Future<void> _createRecurrence() async {
     final recurrenceParams = CreateMedicalShiftRecurrenceParams(
        frequency: frequency!,
        dayOfWeek: dayOfWeek,
        dayOfMonth: dayOfMonth,
        endDate: endDate,
        workload: workload,
        startDate: startDate,
        amount: amount,
        hospitalName: hospitalName,
        startHour: startHour,
     );

     final result = await createMedicalShiftRecurrenceUseCase(recurrenceParams);
     
     result.fold(
       (failure) {
         // Silently fail or log? The existing code logged it.
         errorMessage = "Usuário criado, mas erro na recorrência: ${failure.message}";
       },
       (success) {},
     );
  }
  
  @action
  void reset() {
    hospitalName = '';
    workload = 'six';
    startDate = '';
    startHour = '';
    amount = 0.0;
    paid = false;
    isRecurrent = false;
    frequency = null;
    dayOfWeek = null;
    dayOfMonth = null;
    endDate = null;
    state = CreateMedicalShiftState.idle;
    errorMessage = '';
  }
}
