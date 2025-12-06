import 'dart:convert';
import 'package:distrito_medico/core/api/api.dart';
import 'package:distrito_medico/core/errors/exceptions.dart';
import 'package:distrito_medico/features/hospitals/data/models/hospital_model.dart';
import 'package:distrito_medico/features/hospitals/data/models/hospital_request_model.dart';

/// Interface do Remote Data Source de hospitais
abstract class HospitalRemoteDataSource {
  /// Obtém todos os hospitais
  /// Lança [ServerException] em caso de erro
  Future<List<HospitalModel>> getAllHospitals({
    required int page,
    required int perPage,
  });

  /// Cria um novo hospital
  /// Lança [ServerException] em caso de erro
  Future<HospitalModel> createHospital({
    required String name,
    required String address,
  });

  /// Atualiza um hospital
  /// Lança [ServerException] em caso de erro
  Future<HospitalModel> updateHospital({
    required int id,
    required String name,
    required String address,
  });
}

/// Implementação do Remote Data Source usando Chopper
class HospitalRemoteDataSourceImpl implements HospitalRemoteDataSource {
  @override
  Future<List<HospitalModel>> getAllHospitals({
    required int page,
    required int perPage,
  }) async {
    try {
      final response = await hospitalService.getAllHospitals(page, perPage);

      if (response.isSuccessful && response.body != null) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList
            .map((json) => HospitalModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else if (response.statusCode == 500) {
        throw const ServerException(message: 'Erro interno do servidor');
      } else {
        throw const ServerException(message: 'Erro ao buscar hospitais');
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
  Future<HospitalModel> createHospital({
    required String name,
    required String address,
  }) async {
    try {
      final request = HospitalRequestModel(name: name, address: address);
      final response = await hospitalService.registerHospital(
        json.encode(request.toJson()),
      );

      if (response.isSuccessful && response.body != null) {
        return HospitalModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 422) {
        throw const ServerException(
          message: 'Dados inválidos. Verifique as informações',
        );
      } else if (response.statusCode == 500) {
        throw const ServerException(message: 'Erro interno do servidor');
      } else {
        throw const ServerException(message: 'Erro ao criar hospital');
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
  Future<HospitalModel> updateHospital({
    required int id,
    required String name,
    required String address,
  }) async {
    try {
      final request = HospitalRequestModel(name: name, address: address);
      // Correção: Usando hospitalService.editHospital em vez de patientService
      final response = await hospitalService.editHospital(
        id,
        json.encode(request.toJson()),
      );

      if (response.isSuccessful && response.body != null) {
        return HospitalModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 422) {
        throw const ServerException(
          message: 'Dados inválidos. Verifique as informações',
        );
      } else if (response.statusCode == 500) {
        throw const ServerException(message: 'Erro interno do servidor');
      } else {
        throw const ServerException(message: 'Erro ao atualizar hospital');
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
