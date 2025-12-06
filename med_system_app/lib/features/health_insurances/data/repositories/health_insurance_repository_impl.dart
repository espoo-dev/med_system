import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/exceptions.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/health_insurances/data/datasources/health_insurance_remote_datasource.dart';
import 'package:distrito_medico/features/health_insurances/data/models/health_insurance_request_model.dart';
import 'package:distrito_medico/features/health_insurances/domain/entities/health_insurance_entity.dart';
import 'package:distrito_medico/features/health_insurances/domain/repositories/health_insurance_repository.dart';

class HealthInsuranceRepositoryImpl implements HealthInsuranceRepository {
  final HealthInsuranceRemoteDataSource remoteDataSource;

  HealthInsuranceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<HealthInsuranceEntity>>> getAllHealthInsurances({
    int page = 1,
    int perPage = 10,
    bool? custom,
  }) async {
    try {
      final models = await remoteDataSource.getAllHealthInsurances(
        page: page,
        perPage: perPage,
        custom: custom,
      );
      return Right(models.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, HealthInsuranceEntity>> createHealthInsurance({
    required String name,
  }) async {
    try {
      final request = HealthInsuranceRequestModel(name: name);
      final model = await remoteDataSource.createHealthInsurance(request);
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, HealthInsuranceEntity>> updateHealthInsurance({
    required int id,
    required String name,
  }) async {
    try {
      final request = HealthInsuranceRequestModel(name: name);
      final model = await remoteDataSource.updateHealthInsurance(id, request);
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
}
