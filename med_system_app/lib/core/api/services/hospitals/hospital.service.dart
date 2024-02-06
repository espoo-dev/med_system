import "dart:async";
import 'package:chopper/chopper.dart';

part "hospital.service.chopper.dart";

@ChopperApi(baseUrl: "/")
abstract class HospitalService extends ChopperService {
  static HospitalService create([ChopperClient? client]) =>
      _$HospitalService(client);
  @Get(path: 'api/v1/hospitals')
  Future<Response> getAllHospitals(
      @Query('page') int page, @Query('per_page') int perPage);
}
