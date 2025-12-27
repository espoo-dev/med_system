import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/core/usecases/usecase.dart';
import 'package:distrito_medico/features/health_insurances/domain/entities/health_insurance_entity.dart';
import 'package:distrito_medico/features/health_insurances/domain/repositories/health_insurance_repository.dart';
import 'package:equatable/equatable.dart';

class GetAllHealthInsurancesUseCase
    implements UseCase<List<HealthInsuranceEntity>, GetAllHealthInsurancesParams> {
  final HealthInsuranceRepository repository;

  GetAllHealthInsurancesUseCase(this.repository);

  @override
  Future<Either<Failure, List<HealthInsuranceEntity>>> call(
      GetAllHealthInsurancesParams params) async {
    return await repository.getAllHealthInsurances(
      page: params.page,
      perPage: params.perPage,
      custom: params.custom,
    );
  }
}

class GetAllHealthInsurancesParams extends Equatable {
  final int page;
  final int perPage;
  final bool? custom;

  const GetAllHealthInsurancesParams({
    this.page = 1,
    this.perPage = 10,
    this.custom,
  });

  @override
  List<Object?> get props => [page, perPage, custom];
}
