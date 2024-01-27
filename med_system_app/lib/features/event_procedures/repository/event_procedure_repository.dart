import 'dart:convert';

import 'package:med_system_app/core/api/api.dart';
import 'package:med_system_app/core/api/api_result.dart';
import 'package:med_system_app/core/api/network_exceptions.dart';
import 'package:med_system_app/features/event_procedures/model/add_event_procedure_request.model.dart';
import 'package:med_system_app/features/event_procedures/model/event_procedure.model.dart';

class EventProcedureRepository {
  Future<Result<List<EventProcedures>?>?> getAllEventProcedures(
      int page) async {
    try {
      final response = await eventProcedureService.getAllEventProcedures(page);
      if (response.isSuccessful) {
        EventProcedureModel? eventProcedureModel =
            EventProcedureModel.fromJson(json.decode(response.body));

        return Result.success(eventProcedureModel.eventProceduresList);
      } else if (response.statusCode == 500) {
        return Result.failure(NetworkExceptions.getException(
            const NetworkExceptions.internalServerError()));
      }
    } catch (e) {
      throw Result.failure(NetworkExceptions.getException(e));
    }
    return null;
  }

  Future<Result<EventProcedures>?> registerEventProcedure(
      AddEventProcedureRequestModel addEventProcedureRequestModel) async {
    try {
      final response = await eventProcedureService.registerEventProcedure(
          json.encode(addEventProcedureRequestModel.toJson()));

      if (response.isSuccessful) {
        EventProcedures? eventProcedureModel =
            EventProcedures.fromJson(json.decode(response.body));

        return Result.success(eventProcedureModel);
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

  Future<Result<EventProcedures>?> editEventProcedure(int eventProcedureId,
      AddEventProcedureRequestModel addEventProcedureRequestModel) async {
    try {
      final response = await eventProcedureService.editEventProcedure(
          eventProcedureId,
          json.encode(addEventProcedureRequestModel.toJson()));

      if (response.isSuccessful) {
        EventProcedures? eventProcedureModel =
            EventProcedures.fromJson(json.decode(response.body));

        return Result.success(eventProcedureModel);
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
