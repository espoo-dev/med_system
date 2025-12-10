import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/core/usecases/usecase.dart';
import 'package:distrito_medico/features/event_procedures/domain/entities/event_procedure_entity.dart';
import 'package:distrito_medico/features/event_procedures/domain/usecases/create_event_procedure_usecase.dart';
import 'package:distrito_medico/features/health_insurances/domain/entities/health_insurance_entity.dart';
import 'package:distrito_medico/features/health_insurances/domain/usecases/get_all_health_insurances_usecase.dart';
import 'package:distrito_medico/features/hospitals/domain/entities/hospital_entity.dart';
import 'package:distrito_medico/features/hospitals/domain/usecases/get_all_hospitals_usecase.dart';
import 'package:distrito_medico/features/patients/domain/entities/patient_entity.dart';
import 'package:distrito_medico/features/patients/domain/usecases/get_all_patients_usecase.dart';
import 'package:distrito_medico/features/procedures/domain/entities/procedure_entity.dart';
import 'package:distrito_medico/features/procedures/domain/usecases/get_all_procedures_usecase.dart';
import 'package:mobx/mobx.dart';

part 'create_event_procedure_viewmodel.g.dart';

class CreateEventProcedureViewModel = _CreateEventProcedureViewModelBase
    with _$CreateEventProcedureViewModel;

abstract class _CreateEventProcedureViewModelBase with Store {
  final CreateEventProcedureUseCase _createEventProcedureUseCase;
  final GetAllHospitalsUseCase _getAllHospitalsUseCase;
  final GetAllPatientsUseCase _getAllPatientsUseCase;
  final GetAllProceduresUseCase _getAllProceduresUseCase;
  final GetAllHealthInsurancesUseCase _getAllHealthInsurancesUseCase;

  _CreateEventProcedureViewModelBase(
    this._createEventProcedureUseCase,
    this._getAllHospitalsUseCase,
    this._getAllPatientsUseCase,
    this._getAllProceduresUseCase,
    this._getAllHealthInsurancesUseCase,
  );

  // Observable Data Lists
  @observable
  ObservableList<HospitalEntity> hospitals = ObservableList<HospitalEntity>();

  @observable
  ObservableList<PatientEntity> patients = ObservableList<PatientEntity>();

  @observable
  ObservableList<ProcedureEntity> procedures = ObservableList<ProcedureEntity>();

  @observable
  ObservableList<HealthInsuranceEntity> healthInsurances =
      ObservableList<HealthInsuranceEntity>();

  // Form Fields
  @observable
  HospitalEntity? selectedHospital;

  @observable
  PatientEntity? selectedPatient;

  @observable
  ProcedureEntity? selectedProcedure;

  @observable
  HealthInsuranceEntity? selectedHealthInsurance;
  
  @observable
  String patientServiceNumber = '';

  @observable
  bool isPaid = false;
  
  @observable
  bool urgency = false;

  @observable
  String roomType = 'ward'; // 'ward' or 'apartment'
  
  @observable
  String createdDate = '';

  @observable
  String paymentType = 'health_insurance'; // 'health_insurance' or 'others'

  // Other Payment Fields (when paymentType != 'health_insurance')
  @observable
  String otherProcedureName = '';
  
  @observable
  String otherProcedureAmount = '';
  
  @observable
  String otherProcedureDescription = '';
  
  @observable
  String otherHealthInsuranceName = '';

  // State Management
  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  bool isSuccess = false;

  // Actions
  @action
  Future<void> loadInitialData() async {
    isLoading = true;
    errorMessage = null;
    
    // Using Future.wait to load all dependencies in parallel would be better but
    // let's do sequential for simplicity and better error tracking initially
    // Or we could try catch each block
    
    try {
      final hospitalResult = await _getAllHospitalsUseCase(const GetAllHospitalsParams());
      hospitalResult.fold((l) => null, (r) => hospitals.addAll(r));

      final patientResult = await _getAllPatientsUseCase(const GetAllPatientsParams());
      patientResult.fold((l) => null, (r) => patients.addAll(r));

      final procedureResult = await _getAllProceduresUseCase(const GetAllProceduresParams());
      procedureResult.fold((l) => null, (r) => procedures.addAll(r));

      final healthResult = await _getAllHealthInsurancesUseCase(const GetAllHealthInsurancesParams());
      healthResult.fold((l) => null, (r) => healthInsurances.addAll(r));
      
    } catch (e) {
      errorMessage = 'Erro ao carregar dados iniciais';
    } finally {
      isLoading = false;
    }
  }

  @action
  void setHospital(HospitalEntity? value) => selectedHospital = value;

  @action
  void setPatient(PatientEntity? value) => selectedPatient = value;

  @action
  void setProcedure(ProcedureEntity? value) => selectedProcedure = value;

  @action
  void setHealthInsurance(HealthInsuranceEntity? value) => selectedHealthInsurance = value;
  
  @action
  void setPatientServiceNumber(String value) => patientServiceNumber = value;
  
  @action
  void setIsPaid(bool value) => isPaid = value;
  
  @action
  void setUrgency(bool value) => urgency = value;
  
  @action
  void setRoomType(String value) => roomType = value;
  
  @action
  void setCreatedDate(String value) => createdDate = value;
  
  @action
  void setPaymentType(String value) => paymentType = value;
  
  @action
  void setOtherProcedureName(String value) => otherProcedureName = value;
  
  @action
  void setOtherProcedureAmount(String value) => otherProcedureAmount = value;
  
  @action
  void setOtherProcedureDescription(String value) => otherProcedureDescription = value;
  
  @action
  void setOtherHealthInsuranceName(String value) => otherHealthInsuranceName = value;

  @computed
  bool get isValidFullData {
    if (selectedHospital == null) return false;
    if (selectedPatient == null) return false;
    if (patientServiceNumber.isEmpty) return false;
    if (createdDate.isEmpty) return false;
    
    if (paymentType == 'health_insurance') {
      if (selectedProcedure == null) return false;
      if (selectedHealthInsurance == null) return false;
    } else {
      if (otherProcedureName.isEmpty) return false;
      if (otherHealthInsuranceName.isEmpty) return false;
    }
    
    return true;
  }

  @action
  Future<void> createEventProcedure() async {
    if (!isValidFullData) {
      errorMessage = 'Preencha todos os campos obrigatórios';
      return;
    }

    isLoading = true;
    errorMessage = null;
    isSuccess = false;
    
    Map<String, dynamic> procedureAttributes;
    Map<String, dynamic> healthInsuranceAttributes;
    
    if (paymentType == 'health_insurance') {
      procedureAttributes = {
        'id': selectedProcedure!.id,
          // Assuming existing procedure, we just send ID usually, or partial object as needed by current API
          // The old store sent name, code, etc. Let's try to match structure if needed,
          // but usually ID is enough for relational DBs unless it is a snapshot.
          // Looking at old store: it sends ALL attributes.
        'name': selectedProcedure!.name,
        'code': selectedProcedure!.code,
        'amount_cents': int.tryParse(selectedProcedure!.amountCents) ?? 0,
        'description': selectedProcedure!.description,
        'custom': false
      };
      
      healthInsuranceAttributes = {
        'id': selectedHealthInsurance!.id,
        'name': selectedHealthInsurance!.name,
        'custom': false
      };
    } else {
      procedureAttributes = {
        'id': null,
        'name': otherProcedureName,
        'code': null,
        'amount_cents': int.tryParse(otherProcedureAmount) ?? 0,
        'description': otherProcedureDescription,
        'custom': true
      };
      
      healthInsuranceAttributes = {
        'id': null,
        'name': otherHealthInsuranceName,
        'custom': true
      };
    }

    final result = await _createEventProcedureUseCase(CreateEventProcedureParams(
      hospitalId: selectedHospital!.id!,
      patientServiceNumber: patientServiceNumber,
      date: createdDate,
      roomType: roomType,
      urgency: paymentType == 'health_insurance' ? urgency : false, 
      paid: isPaid,
      payment: paymentType,
      patientAttributes: {
        'id': selectedPatient!.id,
        'name': selectedPatient!.name
      },
      healthInsuranceAttributes: healthInsuranceAttributes,
      procedureAttributes: procedureAttributes,
    ));

    result.fold(
      (failure) {
        errorMessage = _mapFailureToMessage(failure);
        isLoading = false;
      },
      (success) {
        isSuccess = true;
        isLoading = false;
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message; // Use the message from the server failure
    }
    return 'Erro ao criar procedimento';
  }
}
