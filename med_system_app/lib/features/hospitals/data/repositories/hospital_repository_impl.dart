import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/exceptions.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/hospitals/data/datasources/hospital_remote_datasource.dart';
import 'package:distrito_medico/features/hospitals/domain/entities/hospital_entity.dart';
import 'package:distrito_medico/features/hospitals/domain/repositories/hospital_repository.dart';

/// Implementação do HospitalRepository
/// Coordena o data source e converte exceções em failures
class HospitalRepositoryImpl implements HospitalRepository {
  final HospitalRemoteDataSource remoteDataSource;

  HospitalRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<HospitalEntity>>> getAllHospitals({
    int page = 1,
    int perPage = 10000,
  }) async {
    try {
      final hospitalModels = await remoteDataSource.getAllHospitals(
        page: page,
        perPage: perPage,
      );

      // Converte Models → Entities
      final entities = hospitalModels.map((model) => model.toEntity()).toList();

      return Right(entities);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, HospitalEntity>> createHospital({
    required String name,
    required String address,
  }) async {
    try {
      final hospitalModel = await remoteDataSource.createHospital(
        name: name,
        address: address,
      );

      return Right(hospitalModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, HospitalEntity>> updateHospital({
    required int id,
    required String name,
    required String address,
  }) async {
    try {
      final hospitalModel = await remoteDataSource.updateHospital(
        id: id,
        name: name,
        address: address,
      );

      return Right(hospitalModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
}
