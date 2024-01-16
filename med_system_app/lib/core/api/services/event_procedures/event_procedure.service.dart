import "dart:async";
import 'package:chopper/chopper.dart';

part "event_procedure.service.chopper.dart";

@ChopperApi(baseUrl: "/")
abstract class EventProcedureService extends ChopperService {
  static EventProcedureService create([ChopperClient? client]) =>
      _$EventProcedureService(client);

  @Get(path: 'api/v1/event_procedures')
  Future<Response> getAllEventProcedures(@Query('page') int page);
}
