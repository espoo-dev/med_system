// ignore: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:med_system_app/core/api/network_exceptions.dart';
import 'package:med_system_app/features/event_procedures/repository/event_procedure_repository.dart';
import 'package:med_system_app/features/health_insurances/model/health_insurances.model.dart';
import 'package:med_system_app/features/health_insurances/repository/health_insurances_repository.dart';
import 'package:med_system_app/features/hospitals/model/hospital.model.dart';
import 'package:med_system_app/features/hospitals/respository/hospital_repository.dart';
import 'package:med_system_app/features/patients/model/patient.model.dart';
import 'package:med_system_app/features/patients/repository/patient_repository.dart';
import 'package:med_system_app/features/procedures/model/procedure.model.dart';
import 'package:med_system_app/features/procedures/repository/procedure_repository.dart';
import 'package:mobx/mobx.dart';

part 'edit_event_procedure.store.g.dart';

// ignore: library_private_types_in_public_api
class EditEventProcedureStore = _EditEventProcedureStoreBase
    with _$EditEventProcedureStore;

enum EditEventProcedureState { idle, success, error, loading }

enum SaveEventProcedureState { idle, success, error, loading }

abstract class _EditEventProcedureStoreBase with Store {
  final ProcedureRepository _procedureRepository;
  final PatientRepository _patientRepository;
  final HospitalRepository _hospitalRepository;
  final HealthInsurancesRepository _healthInsurancesRepository;
  final EventProcedureRepository _eventProcedureRepository;

  ObservableList<Procedure> procedureList = ObservableList<Procedure>();
  ObservableList<Patient> patientList = ObservableList<Patient>();
  ObservableList<Hospital> hospitalList = ObservableList<Hospital>();
  ObservableList<HealthInsurance> healthInsuranceList =
      ObservableList<HealthInsurance>();

  @observable
  EditEventProcedureState state = EditEventProcedureState.idle;

  @observable
  SaveEventProcedureState saveState = SaveEventProcedureState.idle;

  _EditEventProcedureStoreBase(
      this._procedureRepository,
      this._patientRepository,
      this._hospitalRepository,
      this._healthInsurancesRepository,
      this._eventProcedureRepository);

  @observable
  String _errorMessage = "";
  get errorMessage => _errorMessage;

  @observable
  int _patientId = 0;

  int? get patientId => _patientId;

  @action
  void setPatientId(int patientId) {
    _patientId = patientId;
  }

  bool validatePatientId() {
    if (_patientId == 0) {
      return false;
    }
    return true;
  }

  @observable
  int _procedureId = 0;

  int? get procedureId => _procedureId;

  @action
  void setProcedureId(int procedureId) {
    _procedureId = procedureId;
  }

  bool validateProcedureId() {
    if (_procedureId == 0) {
      return false;
    }
    return true;
  }

  @observable
  int _hospitalId = 0;

  int? get hospitalId => _hospitalId;

  @action
  void setHospitalId(int hospitalId) {
    _hospitalId = hospitalId;
  }

  bool validateHospitalId() {
    if (_hospitalId == 0) {
      return false;
    }
    return true;
  }

  @observable
  int _healthInsuranceId = 0;

  int? get healthInsuranceId => _healthInsuranceId;

  @action
  void setHealthInsuranceId(int healthInsuranceId) {
    _healthInsuranceId = healthInsuranceId;
  }

  bool validateHealthInsuranceIdId() {
    if (_healthInsuranceId == 0) {
      return false;
    }
    return true;
  }

  @observable
  String _patientServiceNumber = '';

  String? get patientServiceNumber => _patientServiceNumber;

  @action
  void setPatientServiceNumber(String patientServiceNumber) {
    _patientServiceNumber = patientServiceNumber;
  }

  bool validatePatientServiceNumber() {
    if (_patientServiceNumber.isEmpty) {
      return false;
    }
    return true;
  }

  @observable
  String _accommodation = 'ward';

  String? get accommodation => _accommodation;

  @action
  void setAccommodation(String accommodation) {
    _accommodation = (accommodation == 'Enfermaria') ? 'ward' : 'apartment';
  }

  @observable
  bool _urgency = false;

  bool? get urgency => _urgency;

  @action
  void setUrgency(bool urgency) {
    _urgency = urgency;
  }

  @observable
  String _createdDate = '';

  String? get createdDate => _createdDate;

  @action
  void setCreatedDate(String createdDate) {
    _createdDate = createdDate;
  }

  bool validateCreatedDate() {
    if (_createdDate.isEmpty) {
      return false;
    }
    return true;
  }

  @observable
  String _paydAt = '';

  String? get paydAt => _paydAt;

  @action
  void setPaydAt(String paydAt) {
    _paydAt = paydAt;
  }

  @computed
  bool get isValidData {
    bool isValid = true;

    if (!validateHospitalId()) {
      debugPrint('Hospital ID is not valid');
      isValid = false;
    }

    if (!validateCreatedDate()) {
      debugPrint('Created Date is not valid');
      isValid = false;
    }

    if (!validatePatientId()) {
      debugPrint('Patient ID is not valid');
      isValid = false;
    }

    if (!validateProcedureId()) {
      debugPrint('Procedure ID is not valid');
      isValid = false;
    }

    if (!validatePatientServiceNumber()) {
      debugPrint('Patient Service Number is not valid');
      isValid = false;
    }

    if (!validateHealthInsuranceIdId()) {
      debugPrint('Health Insurance ID is not valid');
      isValid = false;
    }

    return isValid;
  }

  @action
  fetchAllData() async {
    try {
      state = EditEventProcedureState.loading;

      // Fetch all procedures
      await getAllProcedures();

      // Fetch all patients
      await getAllPatients();

      // Fetch all hospitals
      await getAllHospitals();

      // Fetch all health insurances
      await getAllHealthInsurances();

      state = EditEventProcedureState.success;
    } catch (error) {
      state = EditEventProcedureState.error;
      handleError(error.toString());
    }
  }

  @action
  editEventProcedure() {
    debugPrint(_eventProcedureRepository.toString());
  }

  @action
  getAllProcedures() async {
    procedureList.clear();
    var resultProcedures =
        await _procedureRepository.getAllProcedures().asObservable();
    resultProcedures?.when(success: (List<Procedure>? listProcedures) {
      procedureList.addAll(listProcedures!);
      setProcedureId(procedureList.first.id!);
    }, failure: (NetworkExceptions error) {
      handleError(NetworkExceptions.getErrorMessage(error));
    });
  }

  @action
  getAllPatients() async {
    patientList.clear();
    var resultPatient =
        await _patientRepository.getAllPatients().asObservable();
    resultPatient?.when(success: (List<Patient>? listPatient) {
      patientList.addAll(listPatient!);
      setPatientId(patientList.first.id!);
    }, failure: (NetworkExceptions error) {
      handleError(NetworkExceptions.getErrorMessage(error));
    });
  }

  @action
  getAllHospitals() async {
    hospitalList.clear();
    var resultHospital =
        await _hospitalRepository.getAllHospitals().asObservable();
    resultHospital?.when(success: (List<Hospital>? listHospital) {
      hospitalList.addAll(listHospital!);
      setHospitalId(hospitalList.first.id!);
    }, failure: (NetworkExceptions error) {
      handleError(NetworkExceptions.getErrorMessage(error));
    });
  }

  @action
  getAllHealthInsurances() async {
    healthInsuranceList.clear();

    var resultHealthInsurances =
        await _healthInsurancesRepository.getAllInsurances().asObservable();
    resultHealthInsurances?.when(
        success: (List<HealthInsurance>? listHealthInsurances) {
      healthInsuranceList.addAll(listHealthInsurances!);
      setHealthInsuranceId(healthInsuranceList.first.id!);
    }, failure: (NetworkExceptions error) {
      handleError(NetworkExceptions.getErrorMessage(error));
    });
  }

  handleError(String reason) {
    _errorMessage = reason;
  }

  dispose() {
    procedureList.clear();
    patientList.clear();
    hospitalList.clear();
    healthInsuranceList.clear();
    _patientId = 0;
    _accommodation = "";
    _hospitalId = 0;
    _procedureId = 0;
    _urgency = false;
    _accommodation = "ward";
    _createdDate = "";
    _paydAt = "";
    saveState = SaveEventProcedureState.idle;
    state = EditEventProcedureState.idle;
  }
}
