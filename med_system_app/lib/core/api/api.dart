import 'package:chopper/chopper.dart';
import 'package:med_system_app/core/api/interceptors/MyRequest.interceptor.dart';
import 'package:med_system_app/core/api/interceptors/MyResponse.interceptor.dart';
import 'package:med_system_app/core/api/services/auth/sign_in.service.dart';
import 'package:med_system_app/core/api/services/events/events_procedure.service.dart';
import 'package:med_system_app/core/api/services/hospitals/hospital.service.dart';
import 'package:med_system_app/core/api/services/patients/patient.service.dart';
import 'package:med_system_app/core/api/services/procedures/procedure.service.dart';

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
    HospitalService.create()
  ],
  interceptors: [
    HeadersInterceptor(customHeaders),
    HttpLoggingInterceptor(),
    MyRequestInterceptor(),
    MyResponseInterceptor()
  ],
);
final signInService = _chopper.getService<SignInService>();
final procedureService = _chopper.getService<ProcedureService>();
final eventsService = _chopper.getService<EventsService>();
final patientService = _chopper.getService<PatientService>();
final hospitalService = _chopper.getService<HospitalService>();
