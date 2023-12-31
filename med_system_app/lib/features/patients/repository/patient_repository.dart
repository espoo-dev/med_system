import 'dart:convert';

import 'package:med_system_app/core/api/api.dart';
import 'package:med_system_app/core/api/api_result.dart';
import 'package:med_system_app/core/api/network_exceptions.dart';
import 'package:med_system_app/features/patients/model/patient.model.dart';

class PatientRepository {
  Future<Result<List<Patient>?>?> getAllPatients() async {
    try {
      final response = await patientService.getAllPatients();
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
}
