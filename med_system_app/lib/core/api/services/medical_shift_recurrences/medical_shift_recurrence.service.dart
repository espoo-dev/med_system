import "dart:async";
import 'package:chopper/chopper.dart';

part "medical_shift_recurrence.service.chopper.dart";

@ChopperApi(baseUrl: "/")
abstract class MedicalShiftRecurrenceService extends ChopperService {
  static MedicalShiftRecurrenceService create([ChopperClient? client]) =>
      _$MedicalShiftRecurrenceService(client);

  @Post(path: 'api/v1/medical_shift_recurrences')
  Future<Response> createMedicalShiftRecurrence(@Body() dynamic body);

  @Delete(path: 'api/v1/medical_shift_recurrences/{id}')
  Future<Response> deleteMedicalShiftRecurrence(@Path('id') id);
}
