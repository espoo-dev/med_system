import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/core/usecases/usecase.dart';
import 'package:distrito_medico/features/medical_shifts/domain/repositories/medical_shift_repository.dart';

class DeleteMedicalShiftUseCase implements UseCase<void, DeleteMedicalShiftParams> {
  final IMedicalShiftRepository repository;

  DeleteMedicalShiftUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteMedicalShiftParams params) async {
    return await repository.deleteMedicalShift(
      id: params.id,
      recurrenceId: params.recurrenceId,
    );
  }
}

class DeleteMedicalShiftParams extends Equatable {
  final int id;
  final int? recurrenceId;

  const DeleteMedicalShiftParams({
    required this.id,
    this.recurrenceId,
  });

  @override
  List<Object?> get props => [id, recurrenceId];
}
