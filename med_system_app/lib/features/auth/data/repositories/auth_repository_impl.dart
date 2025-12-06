import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/exceptions.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:distrito_medico/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:distrito_medico/features/auth/domain/entities/user_entity.dart';
import 'package:distrito_medico/features/auth/domain/repositories/auth_repository.dart';

/// Implementação do AuthRepository
/// Coordena os data sources e converte exceções em failures
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, UserEntity>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      // 1. Chama o remote data source para fazer login
      final userModel = await remoteDataSource.signIn(
        email: email,
        password: password,
      );

      // 2. Salva o usuário localmente
      await localDataSource.saveUser(userModel);

      // 3. Converte Model → Entity e retorna sucesso
      return Right(userModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      final userModel = await localDataSource.getUser();
      return Right(userModel.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await localDataSource.clearUser();
      return const Right(unit);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    try {
      return await localDataSource.hasUser();
    } catch (e) {
      return false;
    }
  }
}
