import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/exceptions.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/doctor_registration/data/datasources/signup_remote_datasource.dart';
import 'package:distrito_medico/features/doctor_registration/domain/entities/signup_entity.dart';
import 'package:distrito_medico/features/doctor_registration/domain/repositories/signup_repository.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  final SignUpRemoteDataSource remoteDataSource;

  SignUpRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, SignUpEntity>> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final signUpModel = await remoteDataSource.signUp(
        email: email,
        password: password,
      );

      return Right(signUpModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
}
