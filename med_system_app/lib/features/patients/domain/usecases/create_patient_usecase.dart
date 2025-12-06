import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/core/usecases/usecase.dart';
import 'package:distrito_medico/features/patients/domain/entities/patient_entity.dart';
import 'package:distrito_medico/features/patients/domain/repositories/patient_repository.dart';
import 'package:equatable/equatable.dart';

/// Parâmetros para CreatePatientUseCase
class CreatePatientParams extends Equatable {
  final String name;

  const CreatePatientParams({required this.name});

  @override
  List<Object?> get props => [name];
}

/// Use Case responsável por criar um novo paciente
class CreatePatientUseCase
    implements UseCase<PatientEntity, CreatePatientParams> {
  final PatientRepository repository;

  CreatePatientUseCase(this.repository);

  @override
  Future<Either<Failure, PatientEntity>> call(
    CreatePatientParams params,
  ) async {
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

    return await repository.createPatient(name: params.name.trim());
  }
}
