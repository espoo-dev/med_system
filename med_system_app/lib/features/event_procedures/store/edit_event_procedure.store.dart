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
  ObservableList<Procedure> procedureListOthers = ObservableList<Procedure>();
  ObservableList<Patient> patientList = ObservableList<Patient>();
  ObservableList<Hospital> hospitalList = ObservableList<Hospital>();
  ObservableList<HealthInsurance> healthInsuranceList =
      ObservableList<HealthInsurance>();
  ObservableList<HealthInsurance> healthInsuranceListOthers =
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

  bool validatePatient() {
    if (_patient == null) {
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
    _payment = (payment == 'Convênio' || payment == "health_insurance")
        ? 'health_insurance'
        : 'others';
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
  bool _payd = false;

  bool? get payd => _payd;

  @action
  void setPayd(bool payd) {
    _payd = payd;
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
  Procedure? _procedureOthers;
  Procedure? get procedureOther => _procedureOthers;

  @action
  void setProcedureOther(Procedure procedure) {
    // ignore: unnecessary_null_in_if_null_operators
    _procedureOthers = Procedure(
        // ignore: unnecessary_null_in_if_null_operators
        id: procedure.id ?? null,
        name: procedure.name ?? _procedureOthers?.name ?? "",
        //code: procedure.code ?? _procedureOthers?.code ?? "",
        description:
            procedure.description ?? _procedureOthers?.description ?? "",
        amountCents:
            procedure.amountCents ?? _procedureOthers?.amountCents ?? "");
  }

  @observable
  HealthInsurance? _healthInsuranceOther;

  HealthInsurance? get healthInsuranceOther => _healthInsuranceOther;

  @action
  void setHealthInsuranceOther(HealthInsurance healthInsurance) {
    // ignore: unnecessary_null_in_if_null_operators
    _healthInsuranceOther = HealthInsurance(
      // ignore: unnecessary_null_in_if_null_operators
      id: healthInsurance.id ?? null,
      name: healthInsurance.name ?? _healthInsuranceOther?.name ?? "",
    );
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

  bool validateProcedureOther() {
    if (_procedureOthers == null) {
      return false;
    }
    return true;
  }

  bool validateHealthInsuranceOther() {
    if (_healthInsuranceOther == null) {
      return false;
    }
    return true;
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

    if (!validatePatientServiceNumber()) {
      debugPrint('Patient Service Number is not valid');
      isValid = false;
    }

    if (isOtherPayment) {
      if (!validateProcedureOther()) {
        debugPrint('Procedure other is not valid');
        isValid = false;
      }

      if (!validateHealthInsuranceOther()) {
        debugPrint('Health Insurance other is not valid');
        isValid = false;
      }
    } else {
      if (!validateProcedure()) {
        debugPrint('Procedure  is not valid');
        isValid = false;
      }

      if (!validateHealthInsurance()) {
        debugPrint('Health Insurance  is not valid');
        isValid = false;
      }
    }

    return isValid;
  }

  @action
  editEventProcedure(int eventProcedureId) async {
    if (isValidData) {
      saveState = SaveEventProcedureState.loading;
      var registerEventProcedureResult =
          await _eventProcedureRepository.editEventProcedure(
              eventProcedureId,
              AddEventProcedureRequestModel(
                  procedureAttributes: ProcedureAttributes(
                      id: isOtherPayment
                          ? _procedureOthers?.id
                          : _procedure?.id,
                      name: isOtherPayment
                          ? _procedureOthers?.name
                          : _procedure?.name,
                      code: isOtherPayment ? null : _procedure?.code,
                      amountCents: isOtherPayment
                          ? parseInt(_procedureOthers?.amountCents ?? "")
                          : parseInt(_procedure?.amountCents ?? ""),
                      description: isOtherPayment
                          ? _procedureOthers?.description
                          : _procedure?.description,
                      custom: isOtherPayment ? true : false),
                  patientAttributes:
                      PatientAttributes(id: _patient?.id, name: _patient?.name),
                  hospitalId: _hospitalId,
                  healthInsuranceAttributes: HealthInsuranceAttributes(
                      id: isOtherPayment
                          ? _healthInsuranceOther?.id
                          : _healthInsurance?.id,
                      name: isOtherPayment
                          ? _healthInsuranceOther?.name
                          : _healthInsurance?.name,
                      custom: isOtherPayment ? true : false),
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
  fetchAllData(String namePatient, String nameProcedure,
      String nameHealthInsurance) async {
    try {
      state = EditEventProcedureState.loading;

      await Future.wait([
        // Fetch all procedures

        getAllProceduresByCustom(nameProcedure),

        getAllProcedures(nameProcedure),

        // Fetch all patients
        getAllPatients(namePatient),

        // Fetch all hospitals
        getAllHospitals(),

        // Fetch all health insurances

        getAllHealthInsurancesByCustom(nameHealthInsurance),

        getAllHealthInsurances(nameHealthInsurance),
      ]);

      state = EditEventProcedureState.success;
    } catch (error) {
      state = EditEventProcedureState.error;
      handleError(error.toString());
    }
  }

  @action
  Future getAllProceduresByCustom(String nameProcedure) async {
    procedureListOthers.clear();
    var resultProcedures =
        await _procedureRepository.getProceduresByCustom(true).asObservable();
    resultProcedures?.when(success: (List<Procedure>? listProcedures) {
      procedureListOthers.addAll(listProcedures!);
      if (isOtherPayment) {
        setProcedureOther(
            findProcedureCustom(nameProcedure) ?? procedureListOthers.first);
      } else {
        setProcedure(Procedure());
      }
    }, failure: (NetworkExceptions error) {
      handleError(NetworkExceptions.getErrorMessage(error));
    });
  }

  @action
  Future getAllHealthInsurancesByCustom(String nameHealthInsurance) async {
    healthInsuranceListOthers.clear();

    var resultHealthInsurances = await _healthInsurancesRepository
        .getAllInsurancesByCustom(true)
        .asObservable();
    resultHealthInsurances?.when(
        success: (List<HealthInsurance>? listHealthInsurances) {
      healthInsuranceListOthers.addAll(listHealthInsurances!);
      if (isOtherPayment) {
        setHealthInsuranceOther(
            findHealthInsuranceCustom(nameHealthInsurance) ??
                healthInsuranceListOthers.first);
      } else {
        setHealthInsurance(HealthInsurance());
      }
    }, failure: (NetworkExceptions error) {
      handleError(NetworkExceptions.getErrorMessage(error));
    });
  }

  @action
  Future getAllProcedures(String nameProcedure) async {
    procedureList.clear();
    var resultProcedures =
        await _procedureRepository.getProcedures().asObservable();
    resultProcedures?.when(success: (List<Procedure>? listProcedures) {
      procedureList.addAll(listProcedures!);
      if (!isOtherPayment) {
        setProcedure(findProcedure(nameProcedure) ?? procedureList.first);
      } else {
        setProcedureOther(Procedure());
      }
    }, failure: (NetworkExceptions error) {
      handleError(NetworkExceptions.getErrorMessage(error));
    });
  }

  @action
  Future getAllPatients(String namePatient) async {
    patientList.clear();
    var resultPatient =
        await _patientRepository.getAllPatients(1, 500).asObservable();
    resultPatient?.when(success: (List<Patient>? listPatient) {
      patientList.addAll(listPatient!);
      setPatient(findPatient(namePatient) ?? patientList.first);
    }, failure: (NetworkExceptions error) {
      handleError(NetworkExceptions.getErrorMessage(error));
    });
  }

  @action
  Future getAllHospitals() async {
    hospitalList.clear();
    var resultHospital =
        await _hospitalRepository.getAllHospitals(1, 500).asObservable();
    resultHospital?.when(success: (List<Hospital>? listHospital) {
      hospitalList.addAll(listHospital!);
    }, failure: (NetworkExceptions error) {
      handleError(NetworkExceptions.getErrorMessage(error));
    });
  }

  @action
  Future getAllHealthInsurances(String nameHealthInsurance) async {
    healthInsuranceList.clear();

    var resultHealthInsurances = await _healthInsurancesRepository
        .getAllInsurances(1, 500)
        .asObservable();
    resultHealthInsurances?.when(
        success: (List<HealthInsurance>? listHealthInsurances) {
      healthInsuranceList.addAll(listHealthInsurances!);
      if (!isOtherPayment) {
        setHealthInsurance(findHealthInsurance(nameHealthInsurance) ??
            healthInsuranceList.first);
      } else {
        setHealthInsuranceOther(HealthInsurance());
      }
    }, failure: (NetworkExceptions error) {
      handleError(NetworkExceptions.getErrorMessage(error));
    });
  }

  handleError(String reason) {
    _errorMessage = reason;
  }

  HealthInsurance? findHealthInsurance(String nameHealthInsurance) {
    if (isOtherPayment) {
      return HealthInsurance();
    }

    for (var healthInsurance in healthInsuranceList) {
      if (healthInsurance.name == nameHealthInsurance) {
        _healthInsuranceId = healthInsurance.id ?? 0;
        return healthInsurance;
      }
    }
    return HealthInsurance();
  }

  HealthInsurance? findHealthInsuranceCustom(String nameHealthInsurance) {
    if (!isOtherPayment) {
      return HealthInsurance();
    }

    for (var healthInsurance in healthInsuranceListOthers) {
      if (healthInsurance.name == nameHealthInsurance) {
        _healthInsuranceId = healthInsurance.id ?? 0;
        return healthInsurance;
      }
    }
    return HealthInsurance();
  }

  Hospital? findHospital(String nameHospital) {
    for (var hospital in hospitalList) {
      if (hospital.name == nameHospital) {
        _hospitalId = hospital.id ?? 0;
        return hospital;
      }
    }
    return null;
  }

  Patient? findPatient(String namePatient) {
    for (var patient in patientList) {
      if (patient.name == namePatient) {
        _patientId = patient.id ?? 0;
        return patient;
      }
    }
    return null;
  }

  Procedure? findProcedure(String nameProcedure) {
    if (isOtherPayment) {
      return Procedure();
    }

    for (var procedure in procedureList) {
      if (procedure.name == nameProcedure) {
        _procedureId = procedure.id ?? 0;
        return procedure;
      }
    }
    return Procedure();
  }

  Procedure? findProcedureCustom(String nameProcedure) {
    if (!isOtherPayment) {
      return Procedure();
    }
    for (var procedure in procedureListOthers) {
      if (procedure.name == nameProcedure) {
        _procedureId = procedure.id ?? 0;
        return procedure;
      }
    }
    return Procedure();
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
    healthInsuranceListOthers.clear();
    procedureListOthers.clear();
    _procedureOthers = null;
    _healthInsuranceOther = null;
    _patient = null;
    _patient = null;
    _procedure = null;
    _healthInsurance = null;
    saveState = SaveEventProcedureState.idle;
    state = EditEventProcedureState.idle;
  }
}
