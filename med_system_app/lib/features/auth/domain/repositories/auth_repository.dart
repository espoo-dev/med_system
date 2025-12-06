import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/auth/domain/entities/user_entity.dart';

/// Interface do repositório de autenticação
/// Define o contrato que a camada de dados deve implementar
abstract class AuthRepository {
  /// Realiza o login com email e senha
  /// Retorna Either<Failure, UserEntity>
  /// - Left: Falha (erro)
  /// - Right: Sucesso (usuário autenticado)
  Future<Either<Failure, UserEntity>> signIn({
    required String email,
    required String password,
  });

  /// Obtém o usuário atual do storage local
  /// Retorna Either<Failure, UserEntity>
  Future<Either<Failure, UserEntity>> getCurrentUser();

  /// Realiza o logout (limpa dados do usuário)
  /// Retorna Either<Failure, Unit>
  /// Unit é usado quando não há valor de retorno significativo
  Future<Either<Failure, Unit>> logout();

  /// Verifica se o usuário está autenticado
  /// Retorna true se houver um usuário salvo localmente
  Future<bool> isAuthenticated();
}
