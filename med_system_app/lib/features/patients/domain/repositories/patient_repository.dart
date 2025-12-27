import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/patients/domain/entities/patient_entity.dart';

/// Interface do repositório de pacientes
/// Define o contrato que a camada de dados deve implementar
abstract class PatientRepository {
  /// Obtém todos os pacientes com paginação
  /// Retorna Either<Failure, List<PatientEntity>>
  Future<Either<Failure, List<PatientEntity>>> getAllPatients({
    int page = 1,
    int perPage = 10000,
  });

  /// Cria um novo paciente
  /// Retorna Either<Failure, PatientEntity>
  Future<Either<Failure, PatientEntity>> createPatient({
    required String name,
  });

  /// Atualiza um paciente existente
  /// Retorna Either<Failure, PatientEntity>
  Future<Either<Failure, PatientEntity>> updatePatient({
    required int id,
    required String name,
  });

  /// Deleta um paciente
  /// Retorna Either<Failure, Unit>
  Future<Either<Failure, Unit>> deletePatient({
    required int id,
  });
}
