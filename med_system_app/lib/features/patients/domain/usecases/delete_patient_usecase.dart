import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/core/usecases/usecase.dart';
import 'package:distrito_medico/features/patients/domain/repositories/patient_repository.dart';
import 'package:equatable/equatable.dart';

/// Parâmetros para DeletePatientUseCase
class DeletePatientParams extends Equatable {
  final int id;

  const DeletePatientParams({required this.id});

  @override
  List<Object?> get props => [id];
}

/// Use Case responsável por deletar um paciente
class DeletePatientUseCase implements UseCase<Unit, DeletePatientParams> {
  final PatientRepository repository;

  DeletePatientUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(DeletePatientParams params) async {
    // Validação do ID
    if (params.id <= 0) {
      return const Left(
        ValidationFailure(message: 'ID do paciente inválido'),
      );
    }

    return await repository.deletePatient(id: params.id);
  }
}
