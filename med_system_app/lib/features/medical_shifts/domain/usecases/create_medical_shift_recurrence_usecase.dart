import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/core/usecases/usecase.dart';
import 'package:distrito_medico/features/medical_shifts/domain/repositories/medical_shift_repository.dart';

class CreateMedicalShiftRecurrenceUseCase implements UseCase<void, CreateMedicalShiftRecurrenceParams> {
  final IMedicalShiftRepository repository;

  CreateMedicalShiftRecurrenceUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(CreateMedicalShiftRecurrenceParams params) async {
    return await repository.createMedicalShiftRecurrence(
      frequency: params.frequency,
      dayOfWeek: params.dayOfWeek,
      dayOfMonth: params.dayOfMonth,
      endDate: params.endDate,
      workload: params.workload,
      startDate: params.startDate,
      amount: params.amount,
      hospitalName: params.hospitalName,
      startHour: params.startHour,
    );
  }
}

class CreateMedicalShiftRecurrenceParams extends Equatable {
  final String frequency;
  final int? dayOfWeek;
  final int? dayOfMonth;
  final String? endDate;
  final String workload;
  final String startDate;
  final double amount;
  final String hospitalName;
  final String startHour;

  const CreateMedicalShiftRecurrenceParams({
    required this.frequency,
    this.dayOfWeek,
    this.dayOfMonth,
    this.endDate,
    required this.workload,
    required this.startDate,
    required this.amount,
    required this.hospitalName,
    required this.startHour,
  });

  @override
  List<Object?> get props => [
        frequency,
        dayOfWeek,
        dayOfMonth,
        endDate,
        workload,
        startDate,
        amount,
        hospitalName,
        startHour,
      ];
}
