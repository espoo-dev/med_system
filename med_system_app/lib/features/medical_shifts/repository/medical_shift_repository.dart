import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:distrito_medico/core/api/api.dart';
import 'package:distrito_medico/core/api/api_result.dart';
import 'package:distrito_medico/core/api/network_exceptions.dart';
import 'package:distrito_medico/features/medical_shifts/model/add_medical_shift.model.dart';
import 'package:distrito_medico/features/medical_shifts/model/edit_payment_medical_shift_request.model.dart';
import 'package:distrito_medico/features/medical_shifts/model/hospital_suggestions.model.dart';
import 'package:distrito_medico/features/medical_shifts/model/medical_shift.model.dart';
import 'package:distrito_medico/features/medical_shifts/model/medical_shift_list.model.dart';

import '../model/amount_suggestions.model.dart';
import '../../medical_shift_recurrences/repository/medical_shift_recurrence_repository.dart';

class MedicalShiftRepository {
  final MedicalShiftRecurrenceRepository _recurrenceRepository =
      MedicalShiftRecurrenceRepository();
  Future<Result<MedicalShiftList?>?> getMedicalShiftsByFilters(
      {int? page,
      int? perPage,
      int? month,
      int? year,
      bool? paid,
      String? hospitalName}) async {
    try {
      final response = await medicalShiftService.getMedicalShiftsByFilters(
          page: page,
          perPage: perPage,
          month: month,
          year: year,
          paid: paid,
          hospitalName: hospitalName);
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
      [int? page, int? perPage, int? month, int? year]) async {
    try {
      page ??= 1;

      perPage ??= 10;
      month ??= DateTime.now().month;
      year ??= DateTime.now().year;

      final response = await medicalShiftService.getAllMedicalShiftsByMonth(
          page, perPage, month, year);
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

  Future<Result<MedicalShiftList?>?> getAllMedicalShiftsBypaid(
      [int? page, int? perPage, bool paid = false]) async {
    try {
      page ??= 1;

      perPage ??= 10;

      final response = await medicalShiftService.getAllMedicalShiftsByPaid(
          page, perPage, paid);
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

  Future<Result<MedicalShiftModel>?> deleteMedicalShift(int medicalShiftId,
      {int? medicalShiftRecurrenceId}) async {
    try {
      // If there's a recurrence ID, delete ONLY the recurrence
      if (medicalShiftRecurrenceId != null) {
        final recurrenceResult = await _recurrenceRepository
            .deleteMedicalShiftRecurrence(medicalShiftRecurrenceId);
        
        // Return success based on recurrence deletion
        return recurrenceResult?.when(
          success: (recurrence) {
            // Create a dummy MedicalShiftModel for success response
            return Result.success(MedicalShiftModel(id: medicalShiftId));
          },
          failure: (error) {
            return Result.failure(error);
          },
        );
      }

      // If no recurrence ID, delete the shift normally
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

  Future<Result<List<String>?>?> getHospitalNameSuggestions() async {
    try {
      final response = await medicalShiftService.getHospitalSuggetions();
      if (response.isSuccessful) {
        HospitalSuggestionModel? hospitalSuggestionModel =
            HospitalSuggestionModel.fromJson(json.decode(response.body));

        return Result.success(hospitalSuggestionModel.names);
      } else if (response.statusCode == 500) {
        return Result.failure(NetworkExceptions.getException(
            const NetworkExceptions.internalServerError()));
      }
    } catch (e) {
      throw Result.failure(NetworkExceptions.getException(e));
    }
    return null;
  }

  Future<Result<List<String>?>?> getAmountSuggestions() async {
    try {
      final response = await medicalShiftService.getAmountSuggetions();
      if (response.isSuccessful) {
        AmountSuggestionModel? hospitalSuggestionModel =
            AmountSuggestionModel.fromJson(json.decode(response.body));

        return Result.success(hospitalSuggestionModel.names);
      } else if (response.statusCode == 500) {
        return Result.failure(NetworkExceptions.getException(
            const NetworkExceptions.internalServerError()));
      }
    } catch (e) {
      throw Result.failure(NetworkExceptions.getException(e));
    }
    return null;
  }

  Future<Result<Response>?> generatePdfReport(
      {String? entityName,
      int? month,
      int? year,
      bool? paid,
      String? hospitalName}) async {
    try {
      final response = await medicalShiftService.generatePdfReport(
          entityName: 'medical_shifts',
          month: month,
          year: year,
          paid: paid,
          hospitalName: hospitalName);

      if (response.isSuccessful) {
        return Result.success(response);
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
