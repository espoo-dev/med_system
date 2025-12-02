import 'dart:convert';

import 'package:distrito_medico/core/api/api.dart';
import 'package:distrito_medico/core/api/api_result.dart';
import 'package:distrito_medico/core/api/network_exceptions.dart';
import 'package:distrito_medico/features/medical_shift_recurrences/model/medical_shift_recurrence.model.dart';

class MedicalShiftRecurrenceRepository {
  Future<Result<MedicalShiftRecurrenceModel>?> createMedicalShiftRecurrence(
      MedicalShiftRecurrenceModel medicalShiftRecurrenceModel) async {
    try {
      final response =
          await medicalShiftRecurrenceService.createMedicalShiftRecurrence(
              json.encode(medicalShiftRecurrenceModel.toJson()));

      if (response.isSuccessful) {
        MedicalShiftRecurrenceModel? model =
            MedicalShiftRecurrenceModel.fromJson(json.decode(response.body));

        return Result.success(model);
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

  Future<Result<MedicalShiftRecurrenceModel>?> deleteMedicalShiftRecurrence(
      int id) async {
    try {
      final response =
          await medicalShiftRecurrenceService.deleteMedicalShiftRecurrence(id);

      if (response.isSuccessful) {
        MedicalShiftRecurrenceModel? model =
            MedicalShiftRecurrenceModel.fromJson(json.decode(response.body));
        return Result.success(model);
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
