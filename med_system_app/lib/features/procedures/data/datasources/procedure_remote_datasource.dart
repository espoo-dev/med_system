import 'dart:convert';
import 'package:distrito_medico/core/api/api.dart';
import 'package:distrito_medico/core/errors/exceptions.dart';
import 'package:distrito_medico/features/procedures/data/models/procedure_model.dart';
import 'package:distrito_medico/features/procedures/data/models/procedure_request_model.dart';

abstract class ProcedureRemoteDataSource {
  Future<List<ProcedureModel>> getAllProcedures({
    required int page,
    required int perPage,
  });

  Future<ProcedureModel> createProcedure({
    required String name,
    required String code,
    required String description,
    required String amountCents,
  });

  Future<ProcedureModel> updateProcedure({
    required int id,
    required String name,
    required String code,
    required String description,
    required String amountCents,
  });
}

class ProcedureRemoteDataSourceImpl implements ProcedureRemoteDataSource {
  @override
  Future<List<ProcedureModel>> getAllProcedures({
    required int page,
    required int perPage,
  }) async {
    try {
      final response = await procedureService.getAllProcedures(page, perPage);

      if (response.isSuccessful && response.body != null) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList
            .map((json) =>
                ProcedureModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else if (response.statusCode == 500) {
        throw const ServerException(message: 'Erro interno do servidor');
      } else {
        throw const ServerException(message: 'Erro ao buscar procedimentos');
      }
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      throw ServerException(
        message: 'Erro ao conectar com o servidor: ${e.toString()}',
      );
    }
  }

  @override
  Future<ProcedureModel> createProcedure({
    required String name,
    required String code,
    required String description,
    required String amountCents,
  }) async {
    try {
      final request = ProcedureRequestModel(
        name: name,
        code: code,
        description: description,
        amountCents: amountCents,
      );
      final response = await procedureService.registerProcedure(
        json.encode(request.toJson()),
      );

      if (response.isSuccessful && response.body != null) {
        return ProcedureModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 422) {
        throw const ServerException(
          message: 'Dados inválidos. Verifique as informações',
        );
      } else if (response.statusCode == 500) {
        throw const ServerException(message: 'Erro interno do servidor');
      } else {
        throw const ServerException(message: 'Erro ao criar procedimento');
      }
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      throw ServerException(
        message: 'Erro ao conectar com o servidor: ${e.toString()}',
      );
    }
  }

  @override
  Future<ProcedureModel> updateProcedure({
    required int id,
    required String name,
    required String code,
    required String description,
    required String amountCents,
  }) async {
    try {
      final request = ProcedureRequestModel(
        name: name,
        code: code,
        description: description,
        amountCents: amountCents,
      );
      final response = await procedureService.editProcedure(
        id,
        json.encode(request.toJson()),
      );

      if (response.isSuccessful && response.body != null) {
        return ProcedureModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 422) {
        throw const ServerException(
          message: 'Dados inválidos. Verifique as informações',
        );
      } else if (response.statusCode == 500) {
        throw const ServerException(message: 'Erro interno do servidor');
      } else {
        throw const ServerException(message: 'Erro ao atualizar procedimento');
      }
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      throw ServerException(
        message: 'Erro ao conectar com o servidor: ${e.toString()}',
      );
    }
  }
}
