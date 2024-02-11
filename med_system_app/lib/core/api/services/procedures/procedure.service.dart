import "dart:async";
import 'package:chopper/chopper.dart';

part "procedure.service.chopper.dart";

@ChopperApi(baseUrl: "/")
abstract class ProcedureService extends ChopperService {
  static ProcedureService create([ChopperClient? client]) =>
      _$ProcedureService(client);
  @Get(path: 'api/v1/procedures')
  Future<Response> getAllProcedures();

  @Post(path: 'api/v1/procedures')
  Future<Response> registerProcedure(@Body() dynamic body);
}
