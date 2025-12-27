import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/health_insurances/domain/entities/health_insurance_entity.dart';

abstract class HealthInsuranceRepository {
  Future<Either<Failure, List<HealthInsuranceEntity>>> getAllHealthInsurances({
    int page = 1,
    int perPage = 10,
    bool? custom,
  });

  Future<Either<Failure, HealthInsuranceEntity>> createHealthInsurance({
    required String name,
  });

  Future<Either<Failure, HealthInsuranceEntity>> updateHealthInsurance({
    required int id,
    required String name,
  });
}
