import "dart:async";
import 'package:chopper/chopper.dart';

part "medical_shift.service.chopper.dart";

@ChopperApi(baseUrl: "/")
abstract class MedicalShiftService extends ChopperService {
  static MedicalShiftService create([ChopperClient? client]) =>
      _$MedicalShiftService(client);

  @POST(path: 'api/v1/medical_shifts')
  Future<Response> registerMedicalShift(@Body() dynamic body);

  @GET(path: 'api/v1/medical_shifts')
  Future<Response> getAllMedicalShifts(
    @Query('page') int page,
    @Query('per_page') int perPage,
  );

  @GET(path: 'api/v1/medical_shifts')
  Future<Response> getAllMedicalShiftsByPaid(@Query('page') int page,
      @Query('per_page') int perPage, @Query('paid') bool paid);

  @GET(path: 'api/v1/medical_shifts')
  Future<Response> getAllMedicalShiftsByMonth(
      @Query('page') int page,
      @Query('per_page') int perPage,
      @Query('month') int month,
      @Query('year') int year);

  @PUT(path: 'api/v1/medical_shifts/{id}')
  Future<Response> editPaymentMedicalShift(
      @Path('id') id, @Body() dynamic body);

  @PUT(path: 'api/v1/medical_shifts/{id}')
  Future<Response> editMedicalShift(@Path('id') id, @Body() dynamic body);

  @DELETE(path: 'api/v1/medical_shifts/{id}')
  Future<Response> deleteEventMedicalShifts(@Path('id') id);

  @GET(path: 'api/v1/medical_shifts/amount_suggestions')
  Future<Response> getAmountSuggetions();

  @GET(path: 'api/v1/medical_shifts/hospital_name_suggestion')
  Future<Response> getHospitalSuggetions();

  @GET(path: 'api/v1/medical_shifts')
  Future<Response> getLatestMedicalShifts(
    @Query('page') int page,
    @Query('per_page') int perPage,
    @Query('year') int? year,
  );

  @GET(path: 'api/v1/medical_shifts')
  Future<Response> getMedicalShiftsByFilters({
    @Query('page') int? page,
    @Query('per_page') int? perPage,
    @Query('month') int? month,
    @Query('year') int? year,
    @Query('paid') bool? paid,
    @Query('hospital_name') String? hospitalName,
  });

  @GET(path: 'api/v1/pdf_reports/generate')
  Future<Response> generatePdfReport({
    @Query('entity_name') String? entityName,
    @Query('month') int? month,
    @Query('year') int? year,
    @Query('paid') bool? paid,
    @Query('hospital[name]') String? hospitalName,
  });
}
