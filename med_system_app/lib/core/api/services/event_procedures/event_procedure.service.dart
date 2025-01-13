import "dart:async";
import 'package:chopper/chopper.dart';

part "event_procedure.service.chopper.dart";

@ChopperApi(baseUrl: "/")
abstract class EventProcedureService extends ChopperService {
  static EventProcedureService create([ChopperClient? client]) =>
      _$EventProcedureService(client);

  @Get(path: 'api/v1/event_procedures')
  Future<Response> getAllEventProcedures(
    @Query('page') int page,
    @Query('per_page') int perPage,
  );

  @Get(path: 'api/v1/event_procedures')
  Future<Response> getAllEventProceduresByPaid(@Query('page') int page,
      @Query('per_page') int perPage, @Query('payd') bool payd);

  @Get(path: 'api/v1/event_procedures')
  Future<Response> getAllEventProceduresByMonth(@Query('page') int page,
      @Query('per_page') int perPage, @Query('month') int month);

  @Get(path: 'api/v1/event_procedures')
  Future<Response> getLatestEventProcedures(
    @Query('page') int page,
    @Query('per_page') int perPage,
    @Query('year') int? year,
  );

  @Post(path: 'api/v1/event_procedures')
  Future<Response> registerEventProcedure(@Body() dynamic body);

  @Put(path: 'api/v1/event_procedures/{id}')
  Future<Response> editEventProcedure(@Path('id') id, @Body() dynamic body);

  @Put(path: 'api/v1/event_procedures/{id}')
  Future<Response> editPaymentEventProcedure(
      @Path('id') id, @Body() dynamic body);

  @Delete(path: 'api/v1/event_procedures/{id}')
  Future<Response> deleteEventProcedure(@Path('id') id);

  @Get(path: 'api/v1/event_procedures')
  Future<Response> getEventProceduresByFilters({
    @Query('page') int? page,
    @Query('per_page') int? perPage,
    @Query('month') int? month,
    @Query('year') int? year,
    @Query('payd') bool? payd,
    @Query('health_insurance[name]') String? healthInsuranceName,
    @Query('hospital[name]') String? hospitalName,
  });

  @Get(path: 'api/v1/pdf_reports/generate')
  Future<Response> generatePdfReport({
    @Query('entity_name') String? entityName,
    @Query('month') int? month,
    @Query('year') int? year,
    @Query('payd') bool? payd,
    @Query('health_insurance[name]') String? healthInsuranceName,
    @Query('hospital[name]') String? hospitalName,
  });
}
