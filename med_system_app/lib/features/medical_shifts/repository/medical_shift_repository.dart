import 'dart:convert';

import 'package:distrito_medico/core/api/api.dart';
import 'package:distrito_medico/core/api/api_result.dart';
import 'package:distrito_medico/core/api/network_exceptions.dart';
import 'package:distrito_medico/features/medical_shifts/model/add_medical_shift.model.dart';
import 'package:distrito_medico/features/medical_shifts/model/medical_shift.model.dart';

class MedicalShiftRepository {
  Future<Result<MedicalShiftModel>?> registerMedicalShift(
      AddMedicalShiftRequestModel addMedicalShiftRequestModel) async {
    try {
      final response = await medicalShiftService.registerMedicalShift(
          json.encode(addMedicalShiftRequestModel.toJson()));

      if (response.isSuccessful) {
        MedicalShiftModel? medicalShiftModel =
            MedicalShiftModel.fromJson(json.decode(response.body));

        return Result.success(medicalShiftModel);
      } else if (response.statusCode == 422) {
        return Result.failure(NetworkExceptions.getException(
            const NetworkExceptions.unableToProcess()));
      } else if (response.statusCode == 500) {
        return Result.failure(NetworkExceptions.getException(
            const NetworkExceptions.internalServerError()));
      }
    } catch (e) {
      throw Result.failure(NetworkExceptions.getException(e));
    }
    return null;
  }
}
