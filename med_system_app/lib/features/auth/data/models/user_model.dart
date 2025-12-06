import 'package:distrito_medico/features/auth/domain/entities/user_entity.dart';

/// Model para serialização/deserialização do ResourceOwner
class ResourceOwnerModel extends ResourceOwner {
  const ResourceOwnerModel({
    required super.id,
    required super.email,
    required super.createdAt,
    required super.updatedAt,
  });

  /// Cria um ResourceOwnerModel a partir de JSON
  factory ResourceOwnerModel.fromJson(Map<String, dynamic> json) {
    return ResourceOwnerModel(
      id: json['id'] as int,
      email: json['email'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );
  }

  /// Converte o ResourceOwnerModel para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  /// Converte o Model para Entity
  ResourceOwner toEntity() {
    return ResourceOwner(
      id: id,
      email: email,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

/// Model para serialização/deserialização do User
class UserModel extends UserEntity {
  const UserModel({
    required super.token,
    required super.refreshToken,
    required super.expiresIn,
    required super.tokenType,
    required ResourceOwnerModel super.resourceOwner,
  });

  /// Cria um UserModel a partir de JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      token: json['token'] as String,
      refreshToken: json['refresh_token'] as String,
      expiresIn: json['expires_in'] as int,
      tokenType: json['token_type'] as String,
      resourceOwner: ResourceOwnerModel.fromJson(
        json['resource_owner'] as Map<String, dynamic>,
      ),
    );
  }

  /// Converte o UserModel para JSON
  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'refresh_token': refreshToken,
      'expires_in': expiresIn,
      'token_type': tokenType,
      'resource_owner': (resourceOwner as ResourceOwnerModel).toJson(),
    };
  }

  /// Converte o Model para Entity
  UserEntity toEntity() {
    return UserEntity(
      token: token,
      refreshToken: refreshToken,
      expiresIn: expiresIn,
      tokenType: tokenType,
      resourceOwner: (resourceOwner as ResourceOwnerModel).toEntity(),
    );
  }
}
