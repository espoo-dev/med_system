import 'dart:convert';

import 'package:distrito_medico/core/api/api.dart';
import 'package:distrito_medico/core/api/api_result.dart';
import 'package:distrito_medico/core/api/network_exceptions.dart';
import 'package:distrito_medico/features/health_insurances/model/add_health_insurances_request.model.dart';
import 'package:distrito_medico/features/health_insurances/model/health_insurances.model.dart';

class HealthInsurancesRepository {
  Future<Result<List<HealthInsurance>?>?> getAllInsurances(
      [int? page, int? perPage]) async {
    try {
      page ??= 1;

      perPage ??= 10;

      final response =
          await healthInsurancesService.getAllHealthInsurances(page, perPage);
      if (response.isSuccessful) {
        HealthInsuranceModel? healthInsuranceModel =
            HealthInsuranceModel.fromJson(json.decode(response.body));

        return Result.success(healthInsuranceModel.healthInsurancesList);
      } else if (response.statusCode == 500) {
        return Result.failure(NetworkExceptions.getException(
            const NetworkExceptions.internalServerError()));
      }
    } catch (e) {
      throw Result.failure(NetworkExceptions.getException(e));
    }
    return null;
  }

  Future<Result<HealthInsurance>?> registerHealthInsurance(
      AddHealthInsurancesRequestModel addHealthInsurancesRequestModel) async {
    try {
      final response = await healthInsurancesService.registerHealthInsurances(
          json.encode(addHealthInsurancesRequestModel.toJson()));

      if (response.isSuccessful) {
        HealthInsurance? healthInsurance =
            HealthInsurance.fromJson(json.decode(response.body));

        return Result.success(healthInsurance);
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

  Future<Result<HealthInsurance>?> editHealthInsurance(int healthInsuranceId,
      AddHealthInsurancesRequestModel addHealthInsurancesRequestModel) async {
    try {
      final response = await healthInsurancesService.editHealthInsurance(
          healthInsuranceId,
          json.encode(addHealthInsurancesRequestModel.toJson()));

      if (response.isSuccessful) {
        HealthInsurance? healthInsurance =
            HealthInsurance.fromJson(json.decode(response.body));

        return Result.success(healthInsurance);
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
