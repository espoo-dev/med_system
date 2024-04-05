import "dart:async";
import 'package:chopper/chopper.dart';

part "health_insurances.service.chopper.dart";

@ChopperApi(baseUrl: "/")
abstract class HealthInsurancesService extends ChopperService {
  static HealthInsurancesService create([ChopperClient? client]) =>
      _$HealthInsurancesService(client);
  @Get(path: 'api/v1/health_insurances')
  Future<Response> getAllHealthInsurances(
      @Query('page') int page, @Query('per_page') int perPage);

  @Get(path: 'api/v1/health_insurances')
  Future<Response> getAllHealthInsurancesByCustom(@Query('custom') bool custom);

  @Post(path: 'api/v1/health_insurances')
  Future<Response> registerHealthInsurances(@Body() dynamic body);

  @Put(path: 'api/v1/health_insurances/{id}')
  Future<Response> editHealthInsurance(@Path('id') id, @Body() dynamic body);
}
