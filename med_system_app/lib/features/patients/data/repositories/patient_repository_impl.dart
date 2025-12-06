import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/exceptions.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/patients/data/datasources/patient_remote_datasource.dart';
import 'package:distrito_medico/features/patients/domain/entities/patient_entity.dart';
import 'package:distrito_medico/features/patients/domain/repositories/patient_repository.dart';

/// Implementação do PatientRepository
/// Coordena o data source e converte exceções em failures
class PatientRepositoryImpl implements PatientRepository {
  final PatientRemoteDataSource remoteDataSource;

  PatientRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<PatientEntity>>> getAllPatients({
    int page = 1,
    int perPage = 10000,
  }) async {
    try {
      final patientModels = await remoteDataSource.getAllPatients(
        page: page,
        perPage: perPage,
      );

      // Converte Models → Entities
      final entities = patientModels.map((model) => model.toEntity()).toList();

      return Right(entities);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PatientEntity>> createPatient({
    required String name,
  }) async {
    try {
      final patientModel = await remoteDataSource.createPatient(name: name);

      return Right(patientModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PatientEntity>> updatePatient({
    required int id,
    required String name,
  }) async {
    try {
      final patientModel = await remoteDataSource.updatePatient(
        id: id,
        name: name,
      );

      return Right(patientModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deletePatient({required int id}) async {
    try {
      await remoteDataSource.deletePatient(id: id);

      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
}
