import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/core/usecases/usecase.dart';
import 'package:distrito_medico/features/patients/domain/entities/patient_entity.dart';
import 'package:distrito_medico/features/patients/domain/repositories/patient_repository.dart';
import 'package:equatable/equatable.dart';

/// Parâmetros para UpdatePatientUseCase
class UpdatePatientParams extends Equatable {
  final int id;
  final String name;

  const UpdatePatientParams({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}

/// Use Case responsável por atualizar um paciente
class UpdatePatientUseCase
    implements UseCase<PatientEntity, UpdatePatientParams> {
  final PatientRepository repository;

  UpdatePatientUseCase(this.repository);

  @override
  Future<Either<Failure, PatientEntity>> call(
    UpdatePatientParams params,
  ) async {
    // Validação do ID
    if (params.id <= 0) {
      return const Left(
        ValidationFailure(message: 'ID do paciente inválido'),
      );
    }

    // Validação do nome
    if (params.name.isEmpty) {
      return const Left(
        ValidationFailure(message: 'Nome do paciente não pode ser vazio'),
      );
    }

    if (params.name.trim().length < 3) {
      return const Left(
        ValidationFailure(
          message: 'Nome do paciente deve ter no mínimo 3 caracteres',
        ),
      );
    }

    return await repository.updatePatient(
      id: params.id,
      name: params.name.trim(),
    );
  }
}
