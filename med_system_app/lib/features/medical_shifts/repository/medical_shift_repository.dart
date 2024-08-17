import 'dart:convert';

import 'package:distrito_medico/core/api/api.dart';
import 'package:distrito_medico/core/api/api_result.dart';
import 'package:distrito_medico/core/api/network_exceptions.dart';
import 'package:distrito_medico/features/medical_shifts/model/add_medical_shift.model.dart';
import 'package:distrito_medico/features/medical_shifts/model/edit_payment_medical_shift_request.model.dart';
import 'package:distrito_medico/features/medical_shifts/model/medical_shift.model.dart';
import 'package:distrito_medico/features/medical_shifts/model/medical_shift_list.model.dart';

class MedicalShiftRepository {
  Future<Result<MedicalShiftList?>?> getAllMedicalShifts(
      [int? page, int? perPage]) async {
    try {
      page ??= 1;

      perPage ??= 10;
      final response =
          await medicalShiftService.getAllMedicalShifts(page, perPage);
      if (response.isSuccessful) {
        MedicalShiftList? medicalShiftList =
            MedicalShiftList.fromJson(json.decode(response.body));

        return Result.success(medicalShiftList);
      } else if (response.statusCode == 500) {
        return Result.failure(NetworkExceptions.getException(
            const NetworkExceptions.internalServerError()));
      }
    } catch (e) {
      throw Result.failure(NetworkExceptions.getException(e));
    }
    return null;
  }

  Future<Result<MedicalShiftList?>?> getAllMedicalShiftsByMonth(
      [int? page, int? perPage, int? month]) async {
    try {
      page ??= 1;

      perPage ??= 10;
      month ??= DateTime.now().month;

      final response = await medicalShiftService.getAllMedicalShiftsByMonth(
          page, perPage, month);
      if (response.isSuccessful) {
        MedicalShiftList? medicalShiftList =
            MedicalShiftList.fromJson(json.decode(response.body));

        return Result.success(medicalShiftList);
      } else if (response.statusCode == 500) {
        return Result.failure(NetworkExceptions.getException(
            const NetworkExceptions.internalServerError()));
      }
    } catch (e) {
      throw Result.failure(NetworkExceptions.getException(e));
    }
    return null;
  }

  Future<Result<MedicalShiftList?>?> getAllMedicalShiftsByPayd(
      [int? page, int? perPage, bool payd = false]) async {
    try {
      page ??= 1;

      perPage ??= 10;

      final response = await medicalShiftService.getAllMedicalShiftsByPaid(
          page, perPage, payd);
      if (response.isSuccessful) {
        MedicalShiftList? medicalShiftList =
            MedicalShiftList.fromJson(json.decode(response.body));

        return Result.success(medicalShiftList);
      } else if (response.statusCode == 500) {
        return Result.failure(NetworkExceptions.getException(
            const NetworkExceptions.internalServerError()));
      }
    } catch (e) {
      throw Result.failure(NetworkExceptions.getException(e));
    }
    return null;
  }

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

  Future<Result<MedicalShiftModel>?> editMedicalShift(int medicalShiftId,
      AddMedicalShiftRequestModel addMedicalShiftRequestModel) async {
    try {
      final response = await medicalShiftService.editMedicalShift(
          medicalShiftId, json.encode(addMedicalShiftRequestModel.toJson()));

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

  Future<Result<MedicalShiftModel>?> editPaymentMedicalShift(int medicalShiftId,
      EditPaymentMedicalShiftModel editPaymentMedicalShiftModel) async {
    try {
      final response = await medicalShiftService.editPaymentMedicalShift(
          medicalShiftId, json.encode(editPaymentMedicalShiftModel.toJson()));

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

  Future<Result<MedicalShiftModel>?> deleteMedicalShift(
      int medicalShiftId) async {
    try {
      final response =
          await medicalShiftService.deleteEventMedicalShifts(medicalShiftId);

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
