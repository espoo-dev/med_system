// ignore: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:med_system_app/core/api/network_exceptions.dart';
import 'package:med_system_app/features/health_insurances/model/health_insurances.model.dart';
import 'package:med_system_app/features/health_insurances/repository/health_insurances_repository.dart';
import 'package:med_system_app/features/hospitals/model/hospital.model.dart';
import 'package:med_system_app/features/hospitals/respository/hospital_repository.dart';
import 'package:med_system_app/features/patients/model/patient.model.dart';
import 'package:med_system_app/features/patients/repository/patient_repository.dart';
import 'package:med_system_app/features/procedures/model/procedure.model.dart';
import 'package:med_system_app/features/procedures/repository/procedure_repository.dart';
import 'package:mobx/mobx.dart';

part 'add_event_procedure.store.g.dart';

// ignore: library_private_types_in_public_api
class AddEventProcedureStore = _AddEventProcedureStoreBase
    with _$AddEventProcedureStore;

enum AddEventProcedureState { idle, success, error, loading }

abstract class _AddEventProcedureStoreBase with Store {
  final ProcedureRepository _procedureRepository;
  final PatientRepository _patientRepository;
  final HospitalRepository _hospitalRepository;
  final HealthInsurancesRepository _healthInsurancesRepository;

  ObservableList<Procedure> procedureList = ObservableList<Procedure>();
  ObservableList<Patient> patientList = ObservableList<Patient>();
  ObservableList<Hospital> hospitalList = ObservableList<Hospital>();
  ObservableList<HealthInsurance> healthInsuranceList =
      ObservableList<HealthInsurance>();

  @observable
  AddEventProcedureState state = AddEventProcedureState.idle;

  _AddEventProcedureStoreBase(
    this._procedureRepository,
    this._patientRepository,
    this._hospitalRepository,
    this._healthInsurancesRepository,
  );

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
    _accommodation = (accommodation == 'Enfermaria') ? 'ward' : 'appartment';
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

  createEventProcedure() {
    if (isValidData) {
      debugPrint("procedure: $_procedureId");
      debugPrint("patient: $_patientId");
      debugPrint("hospital: $_hospitalId");
      debugPrint("health_insurance: $_healthInsuranceId");
      debugPrint("patient number service: $_patientServiceNumber");
      debugPrint("accommodation: $_accommodation");
      debugPrint("create date: $_createdDate");
      debugPrint("urgency: $_urgency");
      debugPrint("payd_at: $_paydAt");
    }
  }

  @action
  fetchAllData() async {
    try {
      state = AddEventProcedureState.loading;

      // Fetch all procedures
      await getAllProcedures();

      // Fetch all patients
      await getAllPatients();

      // Fetch all hospitals
      await getAllHospitals();

      // Fetch all health insurances
      await getAllHealthInsurances();

      state = AddEventProcedureState.success;
    } catch (error) {
      state = AddEventProcedureState.error;
      handleError(error.toString());
    }
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
  }
}
