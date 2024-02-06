import 'dart:convert';

import 'package:med_system_app/core/api/api.dart';
import 'package:med_system_app/core/api/api_result.dart';
import 'package:med_system_app/core/api/network_exceptions.dart';
import 'package:med_system_app/features/hospitals/model/hospital.model.dart';

class HospitalRepository {
  Future<Result<List<Hospital>?>?> getAllHospitals(
      [int? page, int? perPage]) async {
    try {
      page ??= 1;

      perPage ??= 10;
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
}
