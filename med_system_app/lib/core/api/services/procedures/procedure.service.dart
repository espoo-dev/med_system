import "dart:async";
import 'package:chopper/chopper.dart';

part "procedure.service.chopper.dart";

@ChopperApi(baseUrl: "/")
abstract class ProcedureService extends ChopperService {
  static ProcedureService create([ChopperClient? client]) =>
      _$ProcedureService(client);
  @Get(path: 'api/v1/procedures')
  Future<Response> getAllProcedures(
      @Query('page') int page, @Query('per_page') int perPage);

  @Post(path: 'api/v1/procedures')
  Future<Response> registerProcedure(@Body() dynamic body);

  @Put(path: 'api/v1/procedures/{id}')
  Future<Response> editProcedure(@Path('id') id, @Body() dynamic body);
}
