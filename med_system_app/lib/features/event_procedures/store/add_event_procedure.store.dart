import 'package:distrito_medico/core/api/network_exceptions.dart';
import 'package:distrito_medico/core/utils/utils.dart';
import 'package:distrito_medico/features/event_procedures/model/add_event_procedure_request.model.dart';
import 'package:distrito_medico/features/event_procedures/repository/event_procedure_repository.dart';
import 'package:distrito_medico/features/health_insurances/model/health_insurances.model.dart';
import 'package:distrito_medico/features/health_insurances/repository/health_insurances_repository.dart';
import 'package:distrito_medico/features/hospitals/model/hospital.model.dart';
import 'package:distrito_medico/features/hospitals/respository/hospital_repository.dart';
import 'package:distrito_medico/features/patients/model/patient.model.dart';
import 'package:distrito_medico/features/patients/repository/patient_repository.dart';
import 'package:distrito_medico/features/procedures/model/procedure.model.dart';
import 'package:distrito_medico/features/procedures/repository/procedure_repository.dart';
// ignore: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'add_event_procedure.store.g.dart';

// ignore: library_private_types_in_public_api
class AddEventProcedureStore = _AddEventProcedureStoreBase
    with _$AddEventProcedureStore;

enum AddEventProcedureState { idle, success, error, loading }

enum SaveEventProcedureState { idle, success, error, loading }

abstract class _AddEventProcedureStoreBase with Store {
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
  AddEventProcedureState state = AddEventProcedureState.idle;

  @observable
  SaveEventProcedureState saveState = SaveEventProcedureState.idle;

  _AddEventProcedureStoreBase(
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

  bool validatePatient() {
    if (_patient == null) {
      return false;
    }
    return true;
  }

  bool validateProcedure() {
    if (_procedure == null) {
      return false;
    }
    return true;
  }

  bool validateHealthInsurance() {
    if (_healthInsurance == null) {
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
  String _payment = 'health_insurance';

  String? get payment => _payment;

  @action
  void setPayment(String payment) {
    _payment = (payment == 'Convênio') ? 'health_insurance' : 'others';
  }

  @computed
  bool get isOtherPayment => _payment == 'others';

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
  Patient? _patient;

  Patient? get patient => _patient;

  @action
  void setPatient(Patient patient) {
    // ignore: unnecessary_null_in_if_null_operators
    _patient = Patient(
        // ignore: unnecessary_null_in_if_null_operators
        id: patient.id ?? null,
        name: patient.name ?? _patient?.name ?? "");
  }

  @observable
  Procedure? _procedure;

  Procedure? get procedure => _procedure;

  @action
  void setProcedure(Procedure procedure) {
    // ignore: unnecessary_null_in_if_null_operators
    _procedure = Procedure(
        // ignore: unnecessary_null_in_if_null_operators
        id: procedure.id ?? null,
        name: procedure.name ?? _procedure?.name ?? "",
        code: procedure.code ?? _procedure?.name ?? "",
        description: procedure.description ?? _procedure?.description ?? "",
        amountCents: procedure.amountCents ?? _procedure?.amountCents ?? "");
  }

  @observable
  HealthInsurance? _healthInsurance;

  HealthInsurance? get healthInsurance => _healthInsurance;

  @action
  void setHealthInsurance(HealthInsurance healthInsurance) {
    // ignore: unnecessary_null_in_if_null_operators
    _healthInsurance = HealthInsurance(
      // ignore: unnecessary_null_in_if_null_operators
      id: healthInsurance.id ?? null,
      name: healthInsurance.name ?? _healthInsurance?.name ?? "",
    );
  }

  @observable
  bool _payd = false;

  bool? get payd => _payd;

  @action
  void setPayd(bool payd) {
    _payd = payd;
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

    if (!validatePatient()) {
      debugPrint('Patient ID is not valid');
      isValid = false;
    }

    if (!validateProcedure()) {
      debugPrint('Procedure ID is not valid');
      isValid = false;
    }

    if (!validatePatientServiceNumber()) {
      debugPrint('Patient Service Number is not valid');
      isValid = false;
    }

    if (!validateHealthInsurance()) {
      debugPrint('Health Insurance ID is not valid');
      isValid = false;
    }

    return isValid;
  }

  @action
  createEventProcedure() async {
    if (isValidData) {
      saveState = SaveEventProcedureState.loading;
      var registerEventProcedureResult = await _eventProcedureRepository
          .registerEventProcedure(AddEventProcedureRequestModel(
              procedureAttributes: ProcedureAttributes(
                  id: _procedure?.id,
                  name: _procedure?.name,
                  code: _procedure?.code,
                  amountCents: parseInt(_procedure?.amountCents ?? ""),
                  description: _procedure?.description,
                  custom: true),
              patientAttributes:
                  PatientAttributes(id: _patient?.id, name: _patient?.name),
              hospitalId: _hospitalId,
              healthInsuranceAttributes: HealthInsuranceAttributes(
                  id: _healthInsurance?.id,
                  name: _healthInsurance?.name,
                  custom: true),
              patientServiceNumber: _patientServiceNumber,
              date: _createdDate,
              payd: _payd,
              urgency: isOtherPayment ? null : _urgency,
              payment: _payment,
              roomType: isOtherPayment ? null : _accommodation));
      registerEventProcedureResult?.when(success: (eventProcedure) {
        saveState = SaveEventProcedureState.success;
      }, failure: (NetworkExceptions error) {
        handleError(NetworkExceptions.getErrorMessage(error));
        saveState = SaveEventProcedureState.error;
      });
    }
  }

  @action
  fetchAllData() async {
    try {
      state = AddEventProcedureState.loading;

      await Future.wait([
        // Fetch all procedures
        getAllProcedures(),
        // Fetch all patients
        getAllPatients(),

        // Fetch all hospitals
        getAllHospitals(),

        // Fetch all health insurances
        getAllHealthInsurances()
      ]);

      state = AddEventProcedureState.success;
    } catch (error) {
      state = AddEventProcedureState.error;
      handleError(error.toString());
    }
  }

  @action
  Future getAllProcedures() async {
    procedureList.clear();
    var resultProcedures =
        await _procedureRepository.getProcedures().asObservable();
    resultProcedures?.when(success: (List<Procedure>? listProcedures) {
      procedureList.addAll(listProcedures!);
    }, failure: (NetworkExceptions error) {
      handleError(NetworkExceptions.getErrorMessage(error));
    });
  }

  @action
  Future getAllProceduresByCustom() async {
    procedureList.clear();
    var resultProcedures =
        await _procedureRepository.getProceduresByCustom(true).asObservable();
    resultProcedures?.when(success: (List<Procedure>? listProcedures) {
      procedureList.addAll(listProcedures!);
    }, failure: (NetworkExceptions error) {
      handleError(NetworkExceptions.getErrorMessage(error));
    });
  }

  @action
  Future getAllPatients() async {
    patientList.clear();
    var resultPatient =
        await _patientRepository.getAllPatients().asObservable();
    resultPatient?.when(success: (List<Patient>? listPatient) {
      if (listPatient!.isNotEmpty) {
        patientList.addAll(listPatient);
      }
    }, failure: (NetworkExceptions error) {
      handleError(NetworkExceptions.getErrorMessage(error));
    });
  }

  @action
  Future getAllHospitals() async {
    hospitalList.clear();
    var resultHospital =
        await _hospitalRepository.getAllHospitals().asObservable();
    resultHospital?.when(success: (List<Hospital>? listHospital) {
      hospitalList.addAll(listHospital!);
    }, failure: (NetworkExceptions error) {
      handleError(NetworkExceptions.getErrorMessage(error));
    });
  }

  @action
  Future getAllHealthInsurances() async {
    healthInsuranceList.clear();

    var resultHealthInsurances =
        await _healthInsurancesRepository.getAllInsurances().asObservable();
    resultHealthInsurances?.when(
        success: (List<HealthInsurance>? listHealthInsurances) {
      healthInsuranceList.addAll(listHealthInsurances!);
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
    _payment = "health_insurance";
    _createdDate = "";
    _payd = false;
    _patient = null;
    _patient = null;
    _procedure = null;
    _healthInsurance = null;
    saveState = SaveEventProcedureState.idle;
    state = AddEventProcedureState.idle;
  }
}
