import 'dart:convert';

import 'package:distrito_medico/core/api/api.dart';
import 'package:distrito_medico/core/api/api_result.dart';
import 'package:distrito_medico/core/api/network_exceptions.dart';
import 'package:distrito_medico/features/procedures/model/add_procedure.model.dart';
import 'package:distrito_medico/features/procedures/model/procedure.model.dart';

class ProcedureRepository {
  Future<Result<List<Procedure>?>?> getProcedures() async {
    try {
      final response = await procedureService.getProcedures();
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

  Future<Result<List<Procedure>?>?> getProceduresByCustom(bool custom) async {
    try {
      final response = await procedureService.getProceduresByCustom(custom);
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

  Future<Result<Procedure>?> editProcedure(
      int id, AddProcedureRequestModel addProcedureRequestModel) async {
    try {
      final response = await procedureService.editProcedure(
          id, json.encode(addProcedureRequestModel.toJson()));

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
