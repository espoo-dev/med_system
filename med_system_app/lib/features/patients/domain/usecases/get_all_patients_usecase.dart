import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/core/usecases/usecase.dart';
import 'package:distrito_medico/features/patients/domain/entities/patient_entity.dart';
import 'package:distrito_medico/features/patients/domain/repositories/patient_repository.dart';
import 'package:equatable/equatable.dart';

/// Parâmetros para GetAllPatientsUseCase
class GetAllPatientsParams extends Equatable {
  final int page;
  final int perPage;

  const GetAllPatientsParams({
    this.page = 1,
    this.perPage = 10000,
  });

  @override
  List<Object?> get props => [page, perPage];
}

/// Use Case responsável por obter todos os pacientes
class GetAllPatientsUseCase
    implements UseCase<List<PatientEntity>, GetAllPatientsParams> {
  final PatientRepository repository;

  GetAllPatientsUseCase(this.repository);

  @override
  Future<Either<Failure, List<PatientEntity>>> call(
    GetAllPatientsParams params,
  ) async {
    // Validação de parâmetros
    if (params.page < 1) {
      return const Left(
        ValidationFailure(message: 'Página deve ser maior que 0'),
      );
    }

    if (params.perPage < 1) {
      return const Left(
        ValidationFailure(message: 'Itens por página deve ser maior que 0'),
      );
    }

    return await repository.getAllPatients(
      page: params.page,
      perPage: params.perPage,
    );
  }
}
