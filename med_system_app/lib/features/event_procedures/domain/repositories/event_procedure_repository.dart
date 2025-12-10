import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import '../entities/event_procedure_entity.dart';
import '../entities/event_procedure_result_entity.dart';

abstract class EventProcedureRepository {
  Future<Either<Failure, EventProcedureResultEntity>> getEventProcedures({
    int page = 1,
    int perPage = 10,
    int? month,
    int? year,
    bool? paid,
    String? healthInsuranceName,
    String? hospitalName,
  });

  Future<Either<Failure, EventProcedureEntity>> createEventProcedure({
    required int hospitalId,
    required String patientServiceNumber,
    required String date,
    required String roomType,
    required bool urgency,
    String? paidAt,
    bool? paid,
    String? payment,
    // Nested objects (simplified for now as Maps or specific small entities could be used, 
    // but passing raw data is acceptable if no complex logic exists)
    // Actually, let's use a specific DTO-like structure for params if needed, 
    // or just receive the complex object. usage:
    required Map<String, dynamic> healthInsuranceAttributes,
    required Map<String, dynamic> patientAttributes,
    required Map<String, dynamic> procedureAttributes,
  });

  Future<Either<Failure, EventProcedureEntity>> updateEventProcedure({
    required int id,
    required int hospitalId,
    required String patientServiceNumber,
    required String date,
    required String roomType,
    required bool urgency,
    String? paidAt,
    bool? paid,
    String? payment,
    required Map<String, dynamic> healthInsuranceAttributes,
    required Map<String, dynamic> patientAttributes,
    required Map<String, dynamic> procedureAttributes,
  });

  Future<Either<Failure, EventProcedureEntity>> updatePaymentStatus({
    required int id,
    required bool paid,
    String? paidAt,
    String? payment,
  });

  Future<Either<Failure, Unit>> deleteEventProcedure(int id);

  Future<Either<Failure, Uint8List>> generatePdfReport({
    int? month,
    int? year,
    bool? paid,
    String? healthInsuranceName,
    String? hospitalName,
  });
}
