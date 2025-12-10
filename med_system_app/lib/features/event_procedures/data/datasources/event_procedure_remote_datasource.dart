import 'dart:convert';
import 'dart:typed_data';
import 'package:chopper/chopper.dart';
import '../../../../core/api/services/event_procedures/event_procedure.service.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/event_procedure_model.dart';

abstract class EventProcedureRemoteDataSource {
  Future<EventProcedureResultModel> getEventProcedures({
    int page = 1,
    int perPage = 10,
    int? month,
    int? year,
    bool? paid,
    String? healthInsuranceName,
    String? hospitalName,
  });

  Future<EventProcedureModel> createEventProcedure(Map<String, dynamic> body);

  Future<EventProcedureModel> updateEventProcedure(
      int id, Map<String, dynamic> body);

  Future<void> deleteEventProcedure(int id);

  Future<Uint8List> generatePdfReport({
    int? month,
    int? year,
    bool? paid,
    String? healthInsuranceName,
    String? hospitalName,
  });
}

class EventProcedureRemoteDataSourceImpl
    implements EventProcedureRemoteDataSource {
  final EventProcedureService service;

  EventProcedureRemoteDataSourceImpl(this.service);

  @override
  Future<EventProcedureResultModel> getEventProcedures({
    int page = 1,
    int perPage = 10,
    int? month,
    int? year,
    bool? paid,
    String? healthInsuranceName,
    String? hospitalName,
  }) async {
    final response = await service.getEventProceduresByFilters(
      page: page,
      perPage: perPage,
      month: month,
      year: year,
      paid: paid,
      healthInsuranceName: healthInsuranceName,
      hospitalName: hospitalName,
    );

    if (response.isSuccessful) {
      final body = json.decode(response.bodyString);
      return EventProcedureResultModel.fromJson(body);
    } else {
      throw const ServerException(message: 'Erro ao buscar procedimentos');
    }
  }

  @override
  Future<EventProcedureModel> createEventProcedure(
      Map<String, dynamic> body) async {
    final response = await service.registerEventProcedure(json.encode(body));

    if (response.isSuccessful) {
      final responseBody = json.decode(response.bodyString);
      return EventProcedureModel.fromJson(responseBody);
    } else {
      throw const ServerException(message: 'Erro ao criar procedimento');
    }
  }

  @override
  Future<EventProcedureModel> updateEventProcedure(
      int id, Map<String, dynamic> body) async {
    final response = await service.editEventProcedure(id, json.encode(body));

    if (response.isSuccessful) {
      final responseBody = json.decode(response.bodyString);
      return EventProcedureModel.fromJson(responseBody);
    } else {
      throw const ServerException(message: 'Erro ao atualizar procedimento');
    }
  }

  @override
  Future<void> deleteEventProcedure(int id) async {
    final response = await service.deleteEventProcedure(id);

    if (!response.isSuccessful) {
      throw const ServerException(message: 'Erro ao deletar procedimento');
    }
  }

  @override
  Future<Uint8List> generatePdfReport({
    int? month,
    int? year,
    bool? paid,
    String? healthInsuranceName,
    String? hospitalName,
  }) async {
    final response = await service.generatePdfReport(
        month: month,
        year: year,
        paid: paid,
        healthInsuranceName: healthInsuranceName,
        hospitalName: hospitalName);

    if (response.isSuccessful) {
      return response.bodyBytes;
    } else {
      throw const ServerException(message: 'Erro ao gerar relatório PDF');
    }
  }
}
