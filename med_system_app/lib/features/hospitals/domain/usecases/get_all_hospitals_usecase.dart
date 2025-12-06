import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/core/usecases/usecase.dart';
import 'package:distrito_medico/features/hospitals/domain/entities/hospital_entity.dart';
import 'package:distrito_medico/features/hospitals/domain/repositories/hospital_repository.dart';
import 'package:equatable/equatable.dart';

/// Parâmetros para GetAllHospitalsUseCase
class GetAllHospitalsParams extends Equatable {
  final int page;
  final int perPage;

  const GetAllHospitalsParams({
    this.page = 1,
    this.perPage = 10000,
  });

  @override
  List<Object?> get props => [page, perPage];
}

/// Use Case responsável por obter a lista de hospitais
class GetAllHospitalsUseCase
    implements UseCase<List<HospitalEntity>, GetAllHospitalsParams> {
  final HospitalRepository repository;

  GetAllHospitalsUseCase(this.repository);

  @override
  Future<Either<Failure, List<HospitalEntity>>> call(
    GetAllHospitalsParams params,
  ) async {
    if (params.page < 1) {
      return const Left(
        ValidationFailure(message: 'Página deve ser maior que 0'),
      );
    }
    return await repository.getAllHospitals(
      page: params.page,
      perPage: params.perPage,
    );
  }
}
