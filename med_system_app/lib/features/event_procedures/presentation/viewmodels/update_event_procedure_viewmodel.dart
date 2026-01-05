import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/event_procedures/domain/entities/event_procedure_entity.dart';
import 'package:distrito_medico/features/event_procedures/domain/usecases/update_event_procedure_usecase.dart';
import 'package:distrito_medico/features/health_insurances/domain/entities/health_insurance_entity.dart';
import 'package:distrito_medico/features/health_insurances/domain/usecases/get_all_health_insurances_usecase.dart';
import 'package:distrito_medico/features/hospitals/domain/entities/hospital_entity.dart';
import 'package:distrito_medico/features/hospitals/domain/usecases/get_all_hospitals_usecase.dart';
import 'package:distrito_medico/features/patients/domain/entities/patient_entity.dart';
import 'package:distrito_medico/features/patients/domain/usecases/get_all_patients_usecase.dart';
import 'package:distrito_medico/features/procedures/domain/entities/procedure_entity.dart';
import 'package:distrito_medico/features/procedures/domain/usecases/get_all_procedures_usecase.dart';
import 'package:mobx/mobx.dart';

part 'update_event_procedure_viewmodel.g.dart';

// ignore: library_private_types_in_public_api
class UpdateEventProcedureViewModel = _UpdateEventProcedureViewModelBase
    with _$UpdateEventProcedureViewModel;

abstract class _UpdateEventProcedureViewModelBase with Store {
  final UpdateEventProcedureUseCase _updateEventProcedureUseCase;
  final GetAllHospitalsUseCase _getAllHospitalsUseCase;
  final GetAllPatientsUseCase _getAllPatientsUseCase;
  final GetAllProceduresUseCase _getAllProceduresUseCase;
  final GetAllHealthInsurancesUseCase _getAllHealthInsurancesUseCase;

  _UpdateEventProcedureViewModelBase(
    this._updateEventProcedureUseCase,
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
  
  // ID do evento sendo editado
  int? _eventProcedureId;

  // State Management
  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  bool isSuccess = false;

  // Actions
  @action
  Future<void> loadInitialData(EventProcedureEntity eventProcedure) async {
    isLoading = true;
    errorMessage = null;
    _eventProcedureId = eventProcedure.id;
    
    // Populating fields with existing data
    // Nota: Entities might simpler than models in existing code, need to map correctly.
    // Assuming EventProcedureEntity has necessary nested objects or we find match in lists.
    
    // Fields direct mapping
    patientServiceNumber = eventProcedure.patientServiceNumber ?? '';
    createdDate = eventProcedure.date ?? ''; // Assuming format date matches
    roomType = eventProcedure.roomType ?? 'ward';
    urgency = eventProcedure.urgency ?? false;
    isPaid = eventProcedure.paid ?? false; // Fixed typo.
    paymentType = eventProcedure.payment ?? 'health_insurance';
    
    // For nested objects, we load lists and then find the match.
    // Or we set partial objects if lists fail to load? 
    // Ideally we match from list to ensure consistency.
    
    try {
      await Future.wait([
        _loadHospitals(eventProcedure.hospital),
        _loadPatients(eventProcedure.patient),
        _loadProcedures(eventProcedure.procedure),
        _loadHealthInsurances(eventProcedure.healthInsurance)
      ]);
      
      // Handle 'Others' fields if applicable
      if (paymentType != 'health_insurance') {
        otherProcedureName = eventProcedure.procedure ?? '';
        otherProcedureAmount = eventProcedure.totalAmountCents ?? ''; // Using totalAmountCents
        // Description?
        // Health Insurance Other Name?
      } else {
         // If standard, finding in list should have set selectedProcedure/Insurance
      }

    } catch (e) {
      errorMessage = 'Erro ao carregar dados iniciais';
    } finally {
      isLoading = false;
    }
  }

  Future<void> _loadHospitals(String? hospitalName) async {
    final result = await _getAllHospitalsUseCase(const GetAllHospitalsParams());
    result.fold((l) => null, (r) {
      hospitals.addAll(r);
      if (hospitalName != null) {
        selectedHospital = r.cast<HospitalEntity?>().firstWhere(
          (element) => element?.name == hospitalName, 
          orElse: () => null
        );
      }
    });
  }

  Future<void> _loadPatients(String? patientName) async {
    final result = await _getAllPatientsUseCase(const GetAllPatientsParams());
    result.fold((l) => null, (r) {
      patients.addAll(r);
      if (patientName != null) {
        selectedPatient = r.cast<PatientEntity?>().firstWhere(
           (element) => element?.name == patientName,
           orElse: () => null
        );
      }
    });
  }
  
  Future<void> _loadProcedures(String? procedureName) async {
    final result = await _getAllProceduresUseCase(const GetAllProceduresParams());
    result.fold((l) => null, (r) {
      procedures.addAll(r);
      if (procedureName != null) {
        selectedProcedure = r.cast<ProcedureEntity?>().firstWhere(
           (element) => element?.name == procedureName,
           orElse: () => null
        );
      }
    });
  }
  
  Future<void> _loadHealthInsurances(String? insuranceName) async {
    final result = await _getAllHealthInsurancesUseCase(const GetAllHealthInsurancesParams());
    result.fold((l) => null, (r) {
      healthInsurances.addAll(r);
      if (insuranceName != null) {
        selectedHealthInsurance = r.cast<HealthInsuranceEntity?>().firstWhere(
           (element) => element?.name == insuranceName,
           orElse: () => null
        );
      }
    });
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

  // Helper method to convert formatted currency string to cents
  int _convertToCents(String formattedValue) {
    if (formattedValue.isEmpty) return 0;
    
    // Remove all non-digit characters except comma and period
    // The RealInputFormatter formats as "R$ 1.500,00"
    // We need to extract just the digits
    final digitsOnly = formattedValue.replaceAll(RegExp('[^0-9]'), '');
    
    if (digitsOnly.isEmpty) return 0;
    
    // The formatter already stores the value in cents (last 2 digits are cents)
    return int.tryParse(digitsOnly) ?? 0;
  }

  @action
  Future<void> updateEventProcedure() async {
    if (!isValidFullData || _eventProcedureId == null) {
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
        'amount_cents': _convertToCents(otherProcedureAmount),
        'description': otherProcedureDescription,
        'custom': true
      };
      
      // Add timestamp to custom health insurance name to avoid duplicates
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      healthInsuranceAttributes = {
        'id': null,
        'name': '${otherHealthInsuranceName}_$timestamp',
        'custom': true
      };
    }

    final result = await _updateEventProcedureUseCase(UpdateEventProcedureParams(
      id: _eventProcedureId!,
      hospitalId: selectedHospital!.id,
      patientServiceNumber: patientServiceNumber,
      date: createdDate,
      roomType: roomType,
      urgency: paymentType == 'health_insurance' ? urgency : false, 
      paid: isPaid,
      payment: paymentType,
      patientAttributes: {
        'id': selectedPatient!.id, // Ensure is int. If String, need to check API.
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
      return failure.message;
    }
    return 'Erro ao atualizar procedimento';
  }
}
