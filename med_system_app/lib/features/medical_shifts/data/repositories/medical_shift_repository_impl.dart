import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:path_provider/path_provider.dart';
import 'package:distrito_medico/core/errors/exceptions.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/medical_shifts/data/datasources/medical_shift_remote_datasource.dart';
import 'package:distrito_medico/features/medical_shifts/data/models/add_medical_shift_request_model.dart';
import 'package:distrito_medico/features/medical_shifts/data/models/edit_payment_medical_shift_request_model.dart';
import 'package:distrito_medico/features/medical_shifts/data/models/medical_shift_recurrence_model.dart';
import 'package:distrito_medico/features/medical_shifts/domain/entities/medical_shift_entity.dart';
import 'package:distrito_medico/features/medical_shifts/domain/entities/medical_shift_list_entity.dart';
import 'package:distrito_medico/features/medical_shifts/domain/repositories/medical_shift_repository.dart';

class MedicalShiftRepositoryImpl implements IMedicalShiftRepository {
  final IMedicalShiftRemoteDataSource remoteDataSource;

  MedicalShiftRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, MedicalShiftListEntity>> getMedicalShifts({
    int page = 1,
    int? month,
    int? year,
    bool? paid,
    String? hospitalName,
  }) async {
    try {
      final result = await remoteDataSource.getMedicalShifts(
        page: page,
        month: month,
        year: year,
        paid: paid,
        hospitalName: hospitalName,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, MedicalShiftEntity>> createMedicalShift({
    required String hospitalName,
    required String workload,
    required String startDate,
    required String startHour,
    required double amount,
    required bool paid,
  }) async {
    try {
      final request = AddMedicalShiftRequestModel(
        hospitalName: hospitalName,
        workload: workload,
        startDate: startDate,
        startHour: startHour,
        amountCents: (amount * 100).toInt(),
        paid: paid,
      );
      final result = await remoteDataSource.createMedicalShift(request);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> createMedicalShiftRecurrence({
    required String frequency,
    int? dayOfWeek,
    int? dayOfMonth,
    String? endDate,
    required String workload,
    required String startDate,
    required double amount,
    required String hospitalName,
    required String startHour,
  }) async {
    try {
      final request = MedicalShiftRecurrenceModel(
        frequency: frequency,
        dayOfWeek: dayOfWeek,
        dayOfMonth: dayOfMonth,
        endDate: endDate,
        workload: workload,
        startDate: startDate,
        amountCents: (amount * 100).toInt(),
        hospitalName: hospitalName,
        startHour: startHour,
      );
      await remoteDataSource.createMedicalShiftRecurrence(request);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, MedicalShiftEntity>> editMedicalShift({
    required int id,
    required String hospitalName,
    required String workload,
    required String startDate,
    required String startHour,
    required double amount,
    required bool paid,
  }) async {
    try {
      final request = AddMedicalShiftRequestModel(
        hospitalName: hospitalName,
        workload: workload,
        startDate: startDate,
        startHour: startHour,
        amountCents: (amount * 100).toInt(),
        paid: paid,
      );
      final result = await remoteDataSource.editMedicalShift(id, request);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, MedicalShiftEntity>> updatePaymentStatus({
    required int id,
    required bool paid,
  }) async {
    try {
      final request = EditPaymentMedicalShiftModel(paid: paid);
      final result = await remoteDataSource.updatePaymentStatus(id, request);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteMedicalShift({
    required int id,
    int? recurrenceId,
  }) async {
    try {
      if (recurrenceId != null) {
        await remoteDataSource.deleteMedicalShiftRecurrence(recurrenceId);
      } else {
        await remoteDataSource.deleteMedicalShift(id);
      }
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getHospitalSuggestions() async {
    try {
      final result = await remoteDataSource.getHospitalSuggestions();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getAmountSuggestions() async {
    try {
      final result = await remoteDataSource.getAmountSuggestions();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> generatePdfReport({
    int? month,
    int? year,
    bool? paid,
    String? hospitalName,
  }) async {
    try {
      final bytes = await remoteDataSource.generatePdfReport(
        month: month,
        year: year,
        paid: paid,
        hospitalName: hospitalName,
      );

      final pdfPath = await _savePdfFile(bytes);
      return Right(pdfPath);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  Future<String> _savePdfFile(List<int> pdfBytes) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final pdfPath = '${directory.path}/report.pdf';

      final pdfFile = File(pdfPath);
      await pdfFile.writeAsBytes(pdfBytes);

      return pdfPath;
    } catch (e) {
      throw const ServerException(message: 'Erro ao salvar arquivo PDF');
    }
  }
}
