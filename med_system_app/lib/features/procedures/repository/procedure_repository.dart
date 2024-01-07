import 'dart:convert';

import 'package:med_system_app/core/api/api.dart';
import 'package:med_system_app/core/api/api_result.dart';
import 'package:med_system_app/core/api/network_exceptions.dart';
import 'package:med_system_app/features/procedures/model/procedure.model.dart';

class ProcedureRepository {
  Future<Result<List<Procedure>?>?> getAllProcedures() async {
    try {
      final response = await procedureService.getAllProcedures();
      if (response.isSuccessful) {
        ProcedureModel? procedureModel =
            ProcedureModel.fromJson(json.decode(response.body));

        return Result.success(procedureModel.procedureList);
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
