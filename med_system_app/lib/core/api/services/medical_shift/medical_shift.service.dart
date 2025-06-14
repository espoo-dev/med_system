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
      @Query('per_page') int perPage, @Query('paid') bool paid);

  @Get(path: 'api/v1/medical_shifts')
  Future<Response> getAllMedicalShiftsByMonth(
      @Query('page') int page,
      @Query('per_page') int perPage,
      @Query('month') int month,
      @Query('year') int year);

  @Put(path: 'api/v1/medical_shifts/{id}')
  Future<Response> editPaymentMedicalShift(
      @Path('id') id, @Body() dynamic body);

  @Put(path: 'api/v1/medical_shifts/{id}')
  Future<Response> editMedicalShift(@Path('id') id, @Body() dynamic body);

  @Delete(path: 'api/v1/medical_shifts/{id}')
  Future<Response> deleteEventMedicalShifts(@Path('id') id);

  @Get(path: 'api/v1/medical_shifts/amount_suggestions')
  Future<Response> getAmountSuggetions();

  @Get(path: 'api/v1/medical_shifts/hospital_name_suggestion')
  Future<Response> getHospitalSuggetions();

  @Get(path: 'api/v1/medical_shifts')
  Future<Response> getLatestMedicalShifts(
    @Query('page') int page,
    @Query('per_page') int perPage,
    @Query('year') int? year,
  );

  @Get(path: 'api/v1/medical_shifts')
  Future<Response> getMedicalShiftsByFilters({
    @Query('page') int? page,
    @Query('per_page') int? perPage,
    @Query('month') int? month,
    @Query('year') int? year,
    @Query('paid') bool? paid,
    @Query('hospital_name') String? hospitalName,
  });

  @Get(path: 'api/v1/pdf_reports/generate')
  Future<Response> generatePdfReport({
    @Query('entity_name') String? entityName,
    @Query('month') int? month,
    @Query('year') int? year,
    @Query('paid') bool? paid,
    @Query('hospital[name]') String? hospitalName,
  });
}
