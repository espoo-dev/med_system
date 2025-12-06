import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/exceptions.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/procedures/data/datasources/procedure_remote_datasource.dart';
import 'package:distrito_medico/features/procedures/domain/entities/procedure_entity.dart';
import 'package:distrito_medico/features/procedures/domain/repositories/procedure_repository.dart';

class ProcedureRepositoryImpl implements ProcedureRepository {
  final ProcedureRemoteDataSource remoteDataSource;

  ProcedureRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ProcedureEntity>>> getAllProcedures({
    int page = 1,
    int perPage = 10,
  }) async {
    try {
      final procedureModels = await remoteDataSource.getAllProcedures(
        page: page,
        perPage: perPage,
      );

      final entities =
          procedureModels.map((model) => model.toEntity()).toList();

      return Right(entities);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProcedureEntity>> createProcedure({
    required String name,
    required String code,
    required String description,
    required String amountCents,
  }) async {
    try {
      final procedureModel = await remoteDataSource.createProcedure(
        name: name,
        code: code,
        description: description,
        amountCents: amountCents,
      );

      return Right(procedureModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProcedureEntity>> updateProcedure({
    required int id,
    required String name,
    required String code,
    required String description,
    required String amountCents,
  }) async {
    try {
      final procedureModel = await remoteDataSource.updateProcedure(
        id: id,
        name: name,
        code: code,
        description: description,
        amountCents: amountCents,
      );

      return Right(procedureModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
}
