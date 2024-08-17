import "dart:async";
import 'package:chopper/chopper.dart';

part "medical_shift.service.chopper.dart";

@ChopperApi(baseUrl: "/")
abstract class MedicalShiftService extends ChopperService {
  static MedicalShiftService create([ChopperClient? client]) =>
      _$MedicalShiftService(client);

  @Post(path: 'api/v1/medical_shifts')
  Future<Response> registerMedicalShift(@Body() dynamic body);

  @Get(path: 'api/v1/medical_shifts')
  Future<Response> getAllMedicalShifts(
    @Query('page') int page,
    @Query('per_page') int perPage,
  );

  @Get(path: 'api/v1/medical_shifts')
  Future<Response> getAllMedicalShiftsByPaid(@Query('page') int page,
      @Query('per_page') int perPage, @Query('payd') bool payd);

  @Get(path: 'api/v1/medical_shifts')
  Future<Response> getAllMedicalShiftsByMonth(@Query('page') int page,
      @Query('per_page') int perPage, @Query('month') int month);

  @Put(path: 'api/v1/medical_shifts/{id}')
  Future<Response> editPaymentMedicalShift(
      @Path('id') id, @Body() dynamic body);

  @Put(path: 'api/v1/medical_shifts/{id}')
  Future<Response> editMedicalShift(@Path('id') id, @Body() dynamic body);

  @Delete(path: 'api/v1/medical_shifts/{id}')
  Future<Response> deleteEventMedicalShifts(@Path('id') id);
}
