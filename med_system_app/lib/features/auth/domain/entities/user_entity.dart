import 'package:equatable/equatable.dart';

/// Entidade de negócio que representa o proprietário do recurso (usuário logado)
class ResourceOwner extends Equatable {
  final int id;
  final String email;
  final String createdAt;
  final String updatedAt;

  const ResourceOwner({
    required this.id,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [id, email, createdAt, updatedAt];

  @override
  String toString() {
    return 'ResourceOwner(id: $id, email: $email)';
  }
}

/// Entidade de negócio que representa um usuário autenticado
class UserEntity extends Equatable {
  final String token;
  final String refreshToken;
  final int expiresIn;
  final String tokenType;
  final ResourceOwner resourceOwner;

  const UserEntity({
    required this.token,
    required this.refreshToken,
    required this.expiresIn,
    required this.tokenType,
    required this.resourceOwner,
  });

  @override
  List<Object?> get props => [
        token,
        refreshToken,
        expiresIn,
        tokenType,
        resourceOwner,
      ];

  @override
  String toString() {
    return 'UserEntity(token: ${token.substring(0, 10)}..., email: ${resourceOwner.email})';
  }
}
