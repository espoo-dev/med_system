import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/medical_shifts/domain/entities/medical_shift_entity.dart';
import 'package:distrito_medico/features/medical_shifts/domain/entities/medical_shift_list_entity.dart';

abstract class IMedicalShiftRepository {
  Future<Either<Failure, MedicalShiftListEntity>> getMedicalShifts({
    int page = 1,
    int? month,
    int? year,
    bool? paid,
    String? hospitalName,
  });

  Future<Either<Failure, MedicalShiftEntity>> createMedicalShift({
    required String hospitalName,
    required String workload,
    required String startDate,
    required String startHour,
    required double amount,
    required bool paid,
  });

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
  });

  Future<Either<Failure, MedicalShiftEntity>> editMedicalShift({
    required int id,
    required String hospitalName,
    required String workload,
    required String startDate,
    required String startHour,
    required double amount,
    required bool paid,
  });

  Future<Either<Failure, void>> deleteMedicalShift({
    required int id,
    int? recurrenceId,
  });

  Future<Either<Failure, MedicalShiftEntity>> updatePaymentStatus({
    required int id,
    required bool paid,
  });

  Future<Either<Failure, List<String>>> getHospitalSuggestions();

  Future<Either<Failure, List<String>>> getAmountSuggestions();

  Future<Either<Failure, String>> generatePdfReport({
    int? month,
    int? year,
    bool? paid,
    String? hospitalName,
  });
}
