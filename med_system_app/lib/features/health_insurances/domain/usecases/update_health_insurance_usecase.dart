import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/core/usecases/usecase.dart';
import 'package:distrito_medico/features/health_insurances/domain/entities/health_insurance_entity.dart';
import 'package:distrito_medico/features/health_insurances/domain/repositories/health_insurance_repository.dart';
import 'package:equatable/equatable.dart';

class UpdateHealthInsuranceUseCase
    implements UseCase<HealthInsuranceEntity, UpdateHealthInsuranceParams> {
  final HealthInsuranceRepository repository;

  UpdateHealthInsuranceUseCase(this.repository);

  @override
  Future<Either<Failure, HealthInsuranceEntity>> call(
      UpdateHealthInsuranceParams params) async {
    if (params.id <= 0) {
      return const Left(ValidationFailure(message: 'ID inválido'));
    }
    if (params.name.trim().isEmpty) {
      return const Left(ValidationFailure(message: 'Nome não pode ser vazio'));
    }
    return await repository.updateHealthInsurance(
      id: params.id,
      name: params.name,
    );
  }
}

class UpdateHealthInsuranceParams extends Equatable {
  final int id;
  final String name;

  const UpdateHealthInsuranceParams({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
