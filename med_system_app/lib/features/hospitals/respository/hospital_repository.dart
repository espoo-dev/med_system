import 'dart:convert';

import 'package:distrito_medico/core/api/api.dart';
import 'package:distrito_medico/core/api/api_result.dart';
import 'package:distrito_medico/core/api/network_exceptions.dart';
import 'package:distrito_medico/features/hospitals/model/hospital.model.dart';

import '../model/add_hospital_request.model.dart';

class HospitalRepository {
  Future<Result<List<Hospital>?>?> getAllHospitals(
      [int? page, int? perPage]) async {
    try {
      page ??= 1;

      perPage ??= 10000;
      final response = await hospitalService.getAllHospitals(page, perPage);
      if (response.isSuccessful) {
        HospitalModel? hospitalModel =
            HospitalModel.fromJson(json.decode(response.body));

        return Result.success(hospitalModel.hospitalList);
      } else if (response.statusCode == 500) {
        return Result.failure(NetworkExceptions.getException(
            const NetworkExceptions.internalServerError()));
      }
    } catch (e) {
      throw Result.failure(NetworkExceptions.getException(e));
    }
    return null;
  }

  Future<Result<Hospital>?> registerHospital(
      AddHospitalRequestModel addHospitalRequestModel) async {
    try {
      final response = await hospitalService
          .registerHospital(json.encode(addHospitalRequestModel.toJson()));

      if (response.isSuccessful) {
        Hospital? hospital = Hospital.fromJson(json.decode(response.body));

        return Result.success(hospital);
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

  Future<Result<Hospital>?> editHospital(
      int hospitalId, AddHospitalRequestModel addHospitalRequestModel) async {
    try {
      final response = await patientService.editPatient(
          hospitalId, json.encode(addHospitalRequestModel.toJson()));

      if (response.isSuccessful) {
        Hospital? hospital = Hospital.fromJson(json.decode(response.body));

        return Result.success(hospital);
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
