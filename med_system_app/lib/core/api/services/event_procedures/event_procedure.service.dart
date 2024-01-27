import "dart:async";
import 'package:chopper/chopper.dart';

part "event_procedure.service.chopper.dart";

@ChopperApi(baseUrl: "/")
abstract class EventProcedureService extends ChopperService {
  static EventProcedureService create([ChopperClient? client]) =>
      _$EventProcedureService(client);

  @Get(path: 'api/v1/event_procedures')
  Future<Response> getAllEventProcedures(@Query('page') int page);

  @Get(path: 'api/v1/event_procedures')
  Future<Response> getLatestEventProcedures(
      @Query('page') int page, @Query('per_page') int perPage);

  @Post(path: 'api/v1/event_procedures')
  Future<Response> registerEventProcedure(@Body() dynamic body);

  @Put(path: 'api/v1/event_procedures/{id}')
  Future<Response> editEventProcedure(@Path('id') id, @Body() dynamic body);
}
