import 'dart:convert';

import 'package:med_system_app/core/api/api.dart';
import 'package:med_system_app/core/api/api_result.dart';
import 'package:med_system_app/core/api/network_exceptions.dart';
import 'package:med_system_app/features/health_insurances/model/health_insurances.model.dart';

class HealthInsurancesRepository {
  Future<Result<List<HealthInsurance>?>?> getAllInsurances() async {
    try {
      final response = await healthInsurancesService.getAllHealthInsurances();
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
}
