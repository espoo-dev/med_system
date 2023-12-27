import 'package:chopper/chopper.dart';
import 'package:med_system_app/core/api/services/auth/sign_in.service.dart';
import 'package:med_system_app/core/api/services/procedures/procedure.service.dart';

var customHeaders = {
  'content-type': 'application/json; charset=UTF-8',
  'Accept': '*/*',
  'Cache-Control': 'no-cache',
  'Connection': 'keep-alive',
};

final _chopper = ChopperClient(
  baseUrl: Uri.parse("https://med-system-backend.onrender.com"),
  services: [SignInService.create(), ProcedureService.create()],
  interceptors: [
    HeadersInterceptor(customHeaders),
    HttpLoggingInterceptor(),
  ],
);
final signInService = _chopper.getService<SignInService>();
final procedureService = _chopper.getService<ProcedureService>();
