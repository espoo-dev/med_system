import 'dart:convert';
import 'package:chopper/chopper.dart';
import 'package:distrito_medico/features/event_procedures/data/models/event_procedure_list_model.dart';
import 'package:distrito_medico/features/medical_shifts/data/models/medical_shift_list_model.dart';
import '../../../../core/api/api.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../event_procedures/data/models/event_procedure_model.dart';
import '../../../medical_shifts/data/models/medical_shift_model.dart';

/// Interface do DataSource remoto da Home
abstract class HomeRemoteDataSource {
  Future<EventProcedureListModel> getLatestEventProcedures({
    required int page,
    required int perPage,
  });

  Future<MedicalShiftListModel> getLatestMedicalShifts({
    required int page,
    required int perPage,
  });
}

/// Implementação do DataSource remoto usando Chopper
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<EventProcedureListModel> getLatestEventProcedures({
    required int page,
    required int perPage,
  }) async {
    try {
      final response = await eventProcedureService.getLatestEventProcedures(
        page,
        perPage,
        DateTime.now().year,
      );

      if (response.isSuccessful && response.body != null) {
        final data = json.decode(response.body);
        return EventProcedureListModel.fromJson(data);
      } else {
        throw const ServerException(
          message: 'Erro ao buscar últimos procedimentos',
        );
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: 'Erro de conexão: ${e.toString()}');
    }
  }

  @override
  Future<MedicalShiftListModel> getLatestMedicalShifts({
    required int page,
    required int perPage,
  }) async {
    try {
      final response = await medicalShiftService.getLatestMedicalShifts(
        page,
        perPage,
        DateTime.now().year,
      );

      if (response.isSuccessful && response.body != null) {
        final data = json.decode(response.body);
        return MedicalShiftListModel.fromJson(data);
      } else {
        throw const ServerException(
          message: 'Erro ao buscar últimos plantões',
        );
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: 'Erro de conexão: ${e.toString()}');
    }
  }
}
