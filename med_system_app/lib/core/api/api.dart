import 'package:chopper/chopper.dart';
import 'package:distrito_medico/core/api/interceptors/MyRequest.interceptor.dart';
import 'package:distrito_medico/core/api/interceptors/MyResponse.interceptor.dart';
import 'package:distrito_medico/core/api/services/auth/sign_in.service.dart';
import 'package:distrito_medico/core/api/services/event_procedures/event_procedure.service.dart';
import 'package:distrito_medico/core/api/services/events/events_procedure.service.dart';
import 'package:distrito_medico/core/api/services/health_insurances/health_insurances.service.dart';
import 'package:distrito_medico/core/api/services/hospitals/hospital.service.dart';
import 'package:distrito_medico/core/api/services/medical_shift/medical_shift.service.dart';
import 'package:distrito_medico/core/api/services/patients/patient.service.dart';
import 'package:distrito_medico/core/api/services/procedures/procedure.service.dart';

var customHeaders = {
  'content-type': 'application/json; charset=UTF-8',
  'Accept': '*/*',
  'Cache-Control': 'no-cache',
  'Connection': 'keep-alive',
};

final _chopper = ChopperClient(
  baseUrl: Uri.parse("https://med-system-backend.onrender.com"),
  services: [
    SignInService.create(),
    ProcedureService.create(),
    EventsService.create(),
    PatientService.create(),
    HospitalService.create(),
    HealthInsurancesService.create(),
    EventProcedureService.create(),
    MedicalShiftService.create()
  ],
  interceptors: [
    HeadersInterceptor(customHeaders),
    HttpLoggingInterceptor(),
    MyRequestInterceptor(),
    MyResponseInterceptor(),
  ],
);
final signInService = _chopper.getService<SignInService>();
final procedureService = _chopper.getService<ProcedureService>();
final eventsService = _chopper.getService<EventsService>();
final patientService = _chopper.getService<PatientService>();
final hospitalService = _chopper.getService<HospitalService>();
final healthInsurancesService = _chopper.getService<HealthInsurancesService>();
final eventProcedureService = _chopper.getService<EventProcedureService>();
final medicalShiftService = _chopper.getService<MedicalShiftService>();
