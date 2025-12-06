import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/core/usecases/usecase.dart';
import 'package:distrito_medico/features/health_insurances/domain/entities/health_insurance_entity.dart';
import 'package:distrito_medico/features/health_insurances/domain/repositories/health_insurance_repository.dart';
import 'package:equatable/equatable.dart';

class CreateHealthInsuranceUseCase
    implements UseCase<HealthInsuranceEntity, CreateHealthInsuranceParams> {
  final HealthInsuranceRepository repository;

  CreateHealthInsuranceUseCase(this.repository);

  @override
  Future<Either<Failure, HealthInsuranceEntity>> call(
      CreateHealthInsuranceParams params) async {
    if (params.name.trim().isEmpty) {
      return const Left(ValidationFailure(message: 'Nome não pode ser vazio'));
    }
    return await repository.createHealthInsurance(name: params.name);
  }
}

class CreateHealthInsuranceParams extends Equatable {
  final String name;

  const CreateHealthInsuranceParams({required this.name});

  @override
  List<Object?> get props => [name];
}
