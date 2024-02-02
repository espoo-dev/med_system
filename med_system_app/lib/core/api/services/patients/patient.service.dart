import "dart:async";
import 'package:chopper/chopper.dart';

part "patient.service.chopper.dart";

@ChopperApi(baseUrl: "/")
abstract class PatientService extends ChopperService {
  static PatientService create([ChopperClient? client]) =>
      _$PatientService(client);
  @Get(path: 'api/v1/patients')
  Future<Response> getAllPatients(
      @Query('page') int page, @Query('per_page') int perPage);

  @Post(path: 'api/v1/patients')
  Future<Response> registerPatient(@Body() dynamic body);

  @Put(path: 'api/v1/patients/{id}')
  Future<Response> editPatient(@Path('id') id, @Body() dynamic body);
}
