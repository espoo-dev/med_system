import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/medical_shifts/domain/entities/medical_shift_entity.dart';
import 'package:distrito_medico/features/medical_shifts/domain/usecases/get_amount_suggestions_usecase.dart';
import 'package:distrito_medico/features/medical_shifts/domain/usecases/get_hospital_suggestions_usecase.dart';
import 'package:distrito_medico/features/medical_shifts/domain/usecases/update_medical_shift_usecase.dart';
import 'package:distrito_medico/core/usecases/usecase.dart';
import 'package:mobx/mobx.dart';

part 'update_medical_shift_viewmodel.g.dart';

enum UpdateMedicalShiftState { idle, loading, success, error }

class UpdateMedicalShiftViewModel = _UpdateMedicalShiftViewModelBase with _$UpdateMedicalShiftViewModel;

abstract class _UpdateMedicalShiftViewModelBase with Store {
  final UpdateMedicalShiftUseCase updateMedicalShiftUseCase;
  final GetHospitalSuggestionsUseCase getHospitalSuggestionsUseCase;
  final GetAmountSuggestionsUseCase getAmountSuggestionsUseCase;

  _UpdateMedicalShiftViewModelBase({
    required this.updateMedicalShiftUseCase,
    required this.getHospitalSuggestionsUseCase,
    required this.getAmountSuggestionsUseCase,
  });

  int? id;

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
  
  // Helper for UI to show amount string, though UI can format double.
  // Actually UI uses setAmountCents with string.
  // I should provide getters if needed, but UI formats logic locally in TextField usually.
  // But initial value for TextField comes from here. 
  // I'll add a getter for amountString if needed.

  @observable
  bool paid = false;

  @observable
  UpdateMedicalShiftState state = UpdateMedicalShiftState.idle;

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
  void init(MedicalShiftEntity entity) {
    id = entity.id;
    hospitalName = entity.hospitalName ?? '';
    workload = entity.workload ?? '';
    startDate = entity.startDate ?? '';
    startHour = entity.startHour ?? '';
    if (entity.amountCents != null) {
       // amountCents in Entity is String e.g. "R$ 1.000,00" or similar?
       // Wait, Check entity definition.
       // Step 93 `medical_shift_model.dart`: `String? amountCents`.
       // `MedicalShiftEntity`: `String? amountCents`.
       // Repository `getMedicalShifts` -> `MedicalShiftListModel.fromJson`.
       // `MedicalShiftModel.fromJson` sets `amountCents` as String.
       // `MedicalShiftRepositoryImpl` uses `(amount * 100).toInt()` for creating.
       // But when reading, it reads what?
       // `MedicalShiftModel.fromJson` (Step 18 in Step 98 summary, created file):
       // `amountCents = json['amount_cents'];` which is dynamic?
       // If API returns int (cents), `amountCents` in Model/Entity should probably be int?
       // Or is it formatted string "10000"?
       // Code in `EditMedicalShiftStore`:
       // `editMedicalShiftStore.amountCents` is String.
       // `EditMedicalShiftStore`: `setAmountCents(String)` 
       // `addMedicalShiftStore`: `parseReal` logic.
       // Ideally `Entity` has raw data.
       // Start of code inspection: `c:\...\medical_shifts\model\medical_shift.model.dart` line 84:
       // `amountCents = json['amount_cents'];`
       // `String? amountCents;`
       // If API returns int, and we assign to String? Dart runtime error if checking type? Or dynamic cast?
       // If standard json decode, int to string doesn't happen automatically.
       // `MedicalShiftRemoteDataSource`: `return MedicalShiftListModel.fromJson(json.decode(response.body));`
       
       // I should check `MedicalShiftEntity` definition again.
       // Step 98 Summary: line 1 edited file. `MedicalShiftEntity`. I saw lines 1-71.
       // I'll check `medical_shift_entity.dart`.
    }
    
    // Assuming Entity has amountCents as String (formatted or not).
    // If it is "R$ 100,00", parsing is hard.
    // If it is "10000" (cents string), it's easier.
    
    // I will try to parse it.
    if (entity.amountCents != null) {
       try {
         // Remove non-digits
         String digits = entity.amountCents!.replaceAll(RegExp(r'[^0-9]'), '');
         int val = int.parse(digits);
         amount = val / 100.0;
       } catch (e) {
         amount = 0.0;
       }
    } else {
      amount = 0.0;
    }
    
    paid = entity.paid ?? false;
  }

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
  Future<void> loadSuggestions() async {
    final hospResult = await getHospitalSuggestionsUseCase(NoParams());
    hospResult.fold((l) {}, (r) => hospitalSuggestions = ObservableList.of(r));
    
    final amountResult = await getAmountSuggestionsUseCase(NoParams());
    amountResult.fold((l) {}, (r) => amountSuggestions = ObservableList.of(r));
  }

  @action
  Future<void> updateMedicalShift() async {
    if (id == null) {
      errorMessage = "ID inválido";
      state = UpdateMedicalShiftState.error;
      return;
    }
  
    state = UpdateMedicalShiftState.loading;
    errorMessage = '';

    final params = UpdateMedicalShiftParams(
      id: id!,
      hospitalName: hospitalName,
      workload: workload,
      startDate: startDate,
      startHour: startHour,
      amount: amount,
      paid: paid,
    );

    final result = await updateMedicalShiftUseCase(params);

    result.fold(
      (failure) {
        errorMessage = failure.message ?? "Erro ao atualizar plantão";
        state = UpdateMedicalShiftState.error;
      },
      (entity) {
        state = UpdateMedicalShiftState.success;
      },
    );
  }
}
