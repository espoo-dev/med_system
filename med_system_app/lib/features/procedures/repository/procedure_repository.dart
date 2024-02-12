import 'dart:convert';

import 'package:med_system_app/core/api/api.dart';
import 'package:med_system_app/core/api/api_result.dart';
import 'package:med_system_app/core/api/network_exceptions.dart';
import 'package:med_system_app/features/procedures/model/add_procedure.model.dart';
import 'package:med_system_app/features/procedures/model/procedure.model.dart';

class ProcedureRepository {
  Future<Result<List<Procedure>?>?> getAllProcedures(
      [int? page, int? perPage]) async {
    try {
      page ??= 1;

      perPage ??= 10;
      final response = await procedureService.getAllProcedures(page, perPage);
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

  Future<Result<Procedure>?> registerProcedure(
      AddProcedureRequestModel addProcedureRequestModel) async {
    try {
      final response = await procedureService
          .registerProcedure(json.encode(addProcedureRequestModel.toJson()));

      if (response.isSuccessful) {
        Procedure? procedure = Procedure.fromJson(json.decode(response.body));

        return Result.success(procedure);
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
