import 'package:distrito_medico/features/event_procedures/domain/entities/event_procedure_list_entity.dart';
import 'package:distrito_medico/features/medical_shifts/domain/entities/medical_shift_list_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_datasource.dart';

/// Implementação do repositório da Home
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, EventProcedureListEntity>>
      getLatestEventProcedures({
    int page = 1,
    int perPage = 3,
  }) async {
    try {
      final result = await remoteDataSource.getLatestEventProcedures(
        page: page,
        perPage: perPage,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, MedicalShiftListEntity>> getLatestMedicalShifts({
    int page = 1,
    int perPage = 3,
  }) async {
    try {
      final result = await remoteDataSource.getLatestMedicalShifts(
        page: page,
        perPage: perPage,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
