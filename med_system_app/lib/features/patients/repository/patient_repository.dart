import 'dart:convert';

import 'package:med_system_app/core/api/api.dart';
import 'package:med_system_app/core/api/api_result.dart';
import 'package:med_system_app/core/api/network_exceptions.dart';
import 'package:med_system_app/features/patients/model/add_patient_request.model.dart';
import 'package:med_system_app/features/patients/model/patient.model.dart';

class PatientRepository {
  Future<Result<List<Patient>?>?> getAllPatients(
      [int? page, int? perPage]) async {
    try {
      page ??= 1;

      perPage ??= 10;

      final response = await patientService.getAllPatients(page, perPage);
      if (response.isSuccessful) {
        PatientModel? patientModel =
            PatientModel.fromJson(json.decode(response.body));

        return Result.success(patientModel.patientList);
      } else if (response.statusCode == 500) {
        return Result.failure(NetworkExceptions.getException(
            const NetworkExceptions.internalServerError()));
      }
    } catch (e) {
      throw Result.failure(NetworkExceptions.getException(e));
    }
    return null;
  }

  Future<Result<Patient>?> registerPatient(
      AddPatientRequestModel addPatientRequestModel) async {
    try {
      final response = await patientService
          .registerPatient(json.encode(addPatientRequestModel.toJson()));

      if (response.isSuccessful) {
        Patient? patient = Patient.fromJson(json.decode(response.body));

        return Result.success(patient);
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

  Future<Result<Patient>?> editPatient(
      int patientId, AddPatientRequestModel addPatientRequestModel) async {
    try {
      final response = await patientService.editPatient(
          patientId, json.encode(addPatientRequestModel.toJson()));

      if (response.isSuccessful) {
        Patient? patient = Patient.fromJson(json.decode(response.body));

        return Result.success(patient);
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

  Future<Result<Patient>?> deletePatient(int patientId) async {
    try {
      final response = await patientService.deletePatient(patientId);

      if (response.isSuccessful) {
        Patient? patient = Patient.fromJson(json.decode(response.body));

        return Result.success(patient);
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
