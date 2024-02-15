import "dart:async";
import 'package:chopper/chopper.dart';

part "health_insurances.service.chopper.dart";

@ChopperApi(baseUrl: "/")
abstract class HealthInsurancesService extends ChopperService {
  static HealthInsurancesService create([ChopperClient? client]) =>
      _$HealthInsurancesService(client);
  @Get(path: 'api/v1/health_insurances')
  Future<Response> getAllHealthInsurances();

  @Post(path: 'api/v1/health_insurances')
  Future<Response> registerHealthInsurances(@Body() dynamic body);
}
