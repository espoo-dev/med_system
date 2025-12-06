import 'dart:convert';
import 'package:distrito_medico/core/api/api.dart';
import 'package:distrito_medico/core/errors/exceptions.dart';
import 'package:distrito_medico/features/health_insurances/data/models/health_insurance_model.dart';
import 'package:distrito_medico/features/health_insurances/data/models/health_insurance_request_model.dart';

abstract class HealthInsuranceRemoteDataSource {
  Future<List<HealthInsuranceModel>> getAllHealthInsurances({
    int page = 1,
    int perPage = 10,
    bool? custom,
  });

  Future<HealthInsuranceModel> createHealthInsurance(
      HealthInsuranceRequestModel request);

  Future<HealthInsuranceModel> updateHealthInsurance(
      int id, HealthInsuranceRequestModel request);
}

class HealthInsuranceRemoteDataSourceImpl
    implements HealthInsuranceRemoteDataSource {
  @override
  Future<List<HealthInsuranceModel>> getAllHealthInsurances({
    int page = 1,
    int perPage = 10,
    bool? custom,
  }) async {
    try {
      final response = await healthInsurancesService.getAllHealthInsurances(
        page: page,
        perPage: perPage,
        custom: custom,
      );

      if (response.isSuccessful) {
        final body = json.decode(response.body);
        if (body is List) {
          return body
              .map((e) => HealthInsuranceModel.fromJson(e))
              .toList();
        } else if (body is Map && body['healthInsurancesList'] != null) {
           return (body['healthInsurancesList'] as List)
              .map((e) => HealthInsuranceModel.fromJson(e))
              .toList();
        }
        return [];
      } else {
        throw ServerException(
            message: 'Erro ao carregar convênios: ${response.statusCode}');
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<HealthInsuranceModel> createHealthInsurance(
      HealthInsuranceRequestModel request) async {
    try {
      final response = await healthInsurancesService.registerHealthInsurances(
        json.encode(request.toJson()),
      );

      if (response.isSuccessful) {
        return HealthInsuranceModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 422) {
        throw const ServerException(message: 'Convênio já cadastrado ou inválido');
      } else {
        throw ServerException(
            message: 'Erro ao criar convênio: ${response.statusCode}');
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<HealthInsuranceModel> updateHealthInsurance(
      int id, HealthInsuranceRequestModel request) async {
    try {
      final response = await healthInsurancesService.editHealthInsurance(
        id,
        json.encode(request.toJson()),
      );

      if (response.isSuccessful) {
        return HealthInsuranceModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 422) {
        throw const ServerException(message: 'Dados inválidos');
      } else {
        throw ServerException(
            message: 'Erro ao atualizar convênio: ${response.statusCode}');
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: e.toString());
    }
  }
}
