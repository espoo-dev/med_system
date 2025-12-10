import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/core/usecases/usecase.dart';
import 'package:distrito_medico/features/medical_shifts/domain/entities/medical_shift_entity.dart';
import 'package:distrito_medico/features/medical_shifts/domain/repositories/medical_shift_repository.dart';

class UpdatePaymentStatusUseCase implements UseCase<MedicalShiftEntity, UpdatePaymentStatusParams> {
  final IMedicalShiftRepository repository;

  UpdatePaymentStatusUseCase(this.repository);

  @override
  Future<Either<Failure, MedicalShiftEntity>> call(UpdatePaymentStatusParams params) async {
    return await repository.updatePaymentStatus(
      id: params.id,
      paid: params.paid,
    );
  }
}

class UpdatePaymentStatusParams extends Equatable {
  final int id;
  final bool paid;

  const UpdatePaymentStatusParams({
    required this.id,
    required this.paid,
  });

  @override
  List<Object?> get props => [id, paid];
}
