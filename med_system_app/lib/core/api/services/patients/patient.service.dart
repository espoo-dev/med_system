import "dart:async";
import 'package:chopper/chopper.dart';

part "patient.service.chopper.dart";

@ChopperApi(baseUrl: "/")
abstract class PatientService extends ChopperService {
  static PatientService create([ChopperClient? client]) =>
      _$PatientService(client);
  @Get(path: 'api/v1/patients')
  Future<Response> getAllPatients();
}
