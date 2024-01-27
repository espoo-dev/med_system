import 'dart:convert';

import 'package:med_system_app/core/api/api.dart';
import 'package:med_system_app/core/api/api_result.dart';
import 'package:med_system_app/core/api/network_exceptions.dart';
import 'package:med_system_app/features/event_procedures/model/event_procedure.model.dart';

class HomeRepository {
  Future<Result<EventProcedureModel?>?> getLatestEventProcedures(
      [int? page, int? perPage]) async {
    try {
      page ??= 1;

      perPage ??= 3;

      final response =
          await eventProcedureService.getLatestEventProcedures(page, perPage);
      if (response.isSuccessful) {
        EventProcedureModel? eventProcedureModel =
            EventProcedureModel.fromJson(json.decode(response.body));

        return Result.success(eventProcedureModel);
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
