import 'dart:convert';
import 'package:distrito_medico/core/api/api.dart';
import 'package:distrito_medico/core/errors/exceptions.dart';
import 'package:distrito_medico/features/patients/data/models/patient_model.dart';
import 'package:distrito_medico/features/patients/data/models/patient_request_model.dart';

/// Interface do Remote Data Source de pacientes
abstract class PatientRemoteDataSource {
  /// Obtém todos os pacientes
  /// Lança [ServerException] em caso de erro
  Future<List<PatientModel>> getAllPatients({
    required int page,
    required int perPage,
  });

  /// Cria um novo paciente
  /// Lança [ServerException] em caso de erro
  Future<PatientModel> createPatient({
    required String name,
  });

  /// Atualiza um paciente
  /// Lança [ServerException] em caso de erro
  Future<PatientModel> updatePatient({
    required int id,
    required String name,
  });

  /// Deleta um paciente
  /// Lança [ServerException] em caso de erro
  Future<void> deletePatient({
    required int id,
  });
}

/// Implementação do Remote Data Source usando Chopper
class PatientRemoteDataSourceImpl implements PatientRemoteDataSource {
  @override
  Future<List<PatientModel>> getAllPatients({
    required int page,
    required int perPage,
  }) async {
    try {
      final response = await patientService.getAllPatients(page, perPage);

      if (response.isSuccessful && response.body != null) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList
            .map((json) => PatientModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else if (response.statusCode == 500) {
        throw const ServerException(message: 'Erro interno do servidor');
      } else {
        throw const ServerException(message: 'Erro ao buscar pacientes');
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
  Future<PatientModel> createPatient({required String name}) async {
    try {
      final request = PatientRequestModel(name: name);
      final response = await patientService.registerPatient(
        json.encode(request.toJson()),
      );

      if (response.isSuccessful && response.body != null) {
        return PatientModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 422) {
        throw const ServerException(
          message: 'Dados inválidos. Verifique as informações',
        );
      } else if (response.statusCode == 500) {
        throw const ServerException(message: 'Erro interno do servidor');
      } else {
        throw const ServerException(message: 'Erro ao criar paciente');
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
  Future<PatientModel> updatePatient({
    required int id,
    required String name,
  }) async {
    try {
      final request = PatientRequestModel(name: name);
      final response = await patientService.editPatient(
        id,
        json.encode(request.toJson()),
      );

      if (response.isSuccessful && response.body != null) {
        return PatientModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 422) {
        throw const ServerException(
          message: 'Dados inválidos. Verifique as informações',
        );
      } else if (response.statusCode == 500) {
        throw const ServerException(message: 'Erro interno do servidor');
      } else {
        throw const ServerException(message: 'Erro ao atualizar paciente');
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
  Future<void> deletePatient({required int id}) async {
    try {
      final response = await patientService.deletePatient(id);

      if (response.isSuccessful) {
        return;
      } else if (response.statusCode == 422) {
        throw const ServerException(
          message: 'Não é possível deletar este paciente',
        );
      } else if (response.statusCode == 500) {
        throw const ServerException(message: 'Erro interno do servidor');
      } else {
        throw const ServerException(message: 'Erro ao deletar paciente');
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
