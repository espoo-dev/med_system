import "dart:async";
import 'package:chopper/chopper.dart';

part "medical_shift.service.chopper.dart";

@ChopperApi(baseUrl: "/")
abstract class MedicalShiftService extends ChopperService {
  static MedicalShiftService create([ChopperClient? client]) =>
      _$MedicalShiftService(client);

  @Post(path: 'api/v1/medical_shifts')
  Future<Response> registerMedicalShift(@Body() dynamic body);
}
