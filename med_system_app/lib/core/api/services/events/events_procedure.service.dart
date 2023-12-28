import "dart:async";
import 'package:chopper/chopper.dart';

part "events_procedure.service.chopper.dart";

@ChopperApi(baseUrl: "/")
abstract class EventsService extends ChopperService {
  static EventsService create([ChopperClient? client]) =>
      _$EventsService(client);
  @Get(path: 'api/v1/event_procedures')
  Future<Response> getAllProcedures();
}
