import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/doctor_registration/domain/entities/signup_entity.dart';

/// Interface do repositório de cadastro de médico
/// Define o contrato para operações de registro
abstract class SignUpRepository {
  /// Registra um novo médico no sistema
  ///
  /// [email] - Email do médico
  /// [password] - Senha do médico
  ///
  /// Retorna [SignUpEntity] em caso de sucesso
  /// Retorna [Failure] em caso de erro
  Future<Either<Failure, SignUpEntity>> signUp({
    required String email,
    required String password,
  });
}
