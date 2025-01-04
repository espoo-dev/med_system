import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:distrito_medico/core/api/api.dart';
import 'package:distrito_medico/core/api/api_result.dart';
import 'package:distrito_medico/core/api/network_exceptions.dart';
import 'package:distrito_medico/features/event_procedures/model/add_event_procedure_request.model.dart';
import 'package:distrito_medico/features/event_procedures/model/edit_payment_procedure_request.model.dart';
import 'package:distrito_medico/features/event_procedures/model/event_procedure.model.dart';

class EventProcedureRepository {
  Future<Result<EventProcedureModel?>?> getEventProceduresByFilters(
      {int? page,
      int? perPage,
      int? month,
      int? year,
      bool? payd,
      String? healthInsuranceName,
      String? hospitalName}) async {
    try {
      final response = await eventProcedureService.getEventProceduresByFilters(
          page: page,
          perPage: perPage,
          month: month,
          year: year,
          payd: payd,
          healthInsuranceName: healthInsuranceName,
          hospitalName: hospitalName);
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

  Future<Result<EventProcedureModel?>?> getAllEventProcedures(
      [int? page, int? perPage]) async {
    try {
      page ??= 1;

      perPage ??= 10;
      final response =
          await eventProcedureService.getAllEventProcedures(page, perPage);
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

  Future<Result<EventProcedureModel?>?> getAllEventProceduresByMonth(
      [int? page, int? perPage, int? month]) async {
    try {
      page ??= 1;

      perPage ??= 10;
      month ??= DateTime.now().month;

      final response = await eventProcedureService.getAllEventProceduresByMonth(
          page, perPage, month);
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

  Future<Result<EventProcedureModel?>?> getAllEventProceduresByPayd(
      [int? page, int? perPage, bool payd = false]) async {
    try {
      page ??= 1;

      perPage ??= 10;

      final response = await eventProcedureService.getAllEventProceduresByPaid(
          page, perPage, payd);
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

  Future<Result<EventProcedures>?> editPaymentEventProcedure(
      int eventProcedureId,
      EditPaymentEventProcedureModel editPaymentEventProcedureModel) async {
    try {
      final response = await eventProcedureService.editPaymentEventProcedure(
          eventProcedureId,
          json.encode(editPaymentEventProcedureModel.toJson()));

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

  Future<Result<EventProcedures>?> deleteEventProcedure(
      int eventProcedureId) async {
    try {
      final response =
          await eventProcedureService.deleteEventProcedure(eventProcedureId);

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

  Future<Result<Response>?> generatePdfReport() async {
    try {
      final response = await eventProcedureService.generatePdfReport();

      if (response.isSuccessful) {
        return Result.success(response);
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
