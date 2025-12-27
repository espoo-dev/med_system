import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/core/usecases/usecase.dart';
import 'package:distrito_medico/features/medical_shifts/domain/entities/medical_shift_entity.dart';
import 'package:distrito_medico/features/medical_shifts/domain/repositories/medical_shift_repository.dart';

class UpdateMedicalShiftUseCase implements UseCase<MedicalShiftEntity, UpdateMedicalShiftParams> {
  final IMedicalShiftRepository repository;

  UpdateMedicalShiftUseCase(this.repository);

  @override
  Future<Either<Failure, MedicalShiftEntity>> call(UpdateMedicalShiftParams params) async {
    return await repository.editMedicalShift(
      id: params.id,
      hospitalName: params.hospitalName,
      workload: params.workload,
      startDate: params.startDate,
      startHour: params.startHour,
      amount: params.amount,
      paid: params.paid,
      color: params.color,
    );
  }
}

class UpdateMedicalShiftParams extends Equatable {
  final int id;
  final String hospitalName;
  final String workload;
  final String startDate;
  final String startHour;
  final double amount;
  final bool paid;
  final String? color;

  const UpdateMedicalShiftParams({
    required this.id,
    required this.hospitalName,
    required this.workload,
    required this.startDate,
    required this.startHour,
    required this.amount,
    required this.paid,
    this.color,
  });

  @override
  List<Object?> get props => [
        id,
        hospitalName,
        workload,
        startDate,
        startHour,
        amount,
        paid,
        color,
      ];
}
