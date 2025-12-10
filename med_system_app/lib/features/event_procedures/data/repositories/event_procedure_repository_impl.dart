import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/event_procedure_entity.dart';
import '../../domain/entities/event_procedure_result_entity.dart';
import '../../domain/repositories/event_procedure_repository.dart';
import '../datasources/event_procedure_remote_datasource.dart';

class EventProcedureRepositoryImpl implements EventProcedureRepository {
  final EventProcedureRemoteDataSource remoteDataSource;

  EventProcedureRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, EventProcedureResultEntity>> getEventProcedures({
    int page = 1,
    int perPage = 10,
    int? month,
    int? year,
    bool? paid,
    String? healthInsuranceName,
    String? hospitalName,
  }) async {
    try {
      final result = await remoteDataSource.getEventProcedures(
        page: page,
        perPage: perPage,
        month: month,
        year: year,
        paid: paid,
        healthInsuranceName: healthInsuranceName,
        hospitalName: hospitalName,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, EventProcedureEntity>> createEventProcedure({
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
  }) async {
    try {
      final body = {
        'hospital_id': hospitalId,
        'patient_service_number': patientServiceNumber,
        'date': date,
        'room_type': roomType,
        'urgency': urgency,
        'paid_at': paidAt,
        'paid': paid,
        'payment': payment,
        'health_insurance_attributes': healthInsuranceAttributes,
        'patient_attributes': patientAttributes,
        'procedure_attributes': procedureAttributes,
      };

      final result = await remoteDataSource.createEventProcedure(body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
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
  }) async {
    try {
      final body = {
        'hospital_id': hospitalId,
        'patient_service_number': patientServiceNumber,
        'date': date,
        'room_type': roomType,
        'urgency': urgency,
        'paid_at': paidAt,
        'paid': paid,
        'payment': payment,
        'health_insurance_attributes': healthInsuranceAttributes,
        'patient_attributes': patientAttributes,
        'procedure_attributes': procedureAttributes,
      };

      final result = await remoteDataSource.updateEventProcedure(id, body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, EventProcedureEntity>> updatePaymentStatus({
    required int id,
    required bool paid,
    String? paidAt,
    String? payment,
  }) async {
    try {
      final body = {
        'paid': paid,
        'paid_at': paidAt,
        'payment': payment,
      };
      // Reuse update endpoint for partial update if supported, or assuming simple update works
      final result = await remoteDataSource.updateEventProcedure(id, body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteEventProcedure(int id) async {
    try {
      await remoteDataSource.deleteEventProcedure(id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Uint8List>> generatePdfReport({
    int? month,
    int? year,
    bool? paid,
    String? healthInsuranceName,
    String? hospitalName,
  }) async {
    try {
      final result = await remoteDataSource.generatePdfReport(
        month: month,
        year: year,
        paid: paid,
        healthInsuranceName: healthInsuranceName,
        hospitalName: hospitalName,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
