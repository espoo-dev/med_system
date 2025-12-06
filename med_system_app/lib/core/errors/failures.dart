import 'package:equatable/equatable.dart';

/// Classe base abstrata para todos os tipos de falhas
abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object?> get props => [message];

  @override
  String toString() => message;
}

/// Falha de servidor (erros da API)
class ServerFailure extends Failure {
  const ServerFailure({required super.message});
}

/// Falha de cache/storage local
class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}

/// Falha de rede (sem conexão, timeout, etc)
class NetworkFailure extends Failure {
  const NetworkFailure({required super.message});
}

/// Falha de validação (dados inválidos)
class ValidationFailure extends Failure {
  const ValidationFailure({required super.message});
}

/// Falha de autenticação (credenciais inválidas, token expirado, etc)
class AuthFailure extends Failure {
  const AuthFailure({required super.message});
}

/// Falha inesperada (erros não categorizados)
class UnexpectedFailure extends Failure {
  const UnexpectedFailure({required super.message});
}
