import 'dart:convert';
import 'package:distrito_medico/core/errors/exceptions.dart';
import 'package:distrito_medico/features/auth/data/models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Interface do Local Data Source de autenticação
abstract class AuthLocalDataSource {
  /// Salva o usuário no storage local
  /// Lança [CacheException] em caso de erro
  Future<void> saveUser(UserModel user);

  /// Obtém o usuário do storage local
  /// Lança [CacheException] se não houver usuário salvo
  Future<UserModel> getUser();

  /// Limpa os dados do usuário do storage
  /// Lança [CacheException] em caso de erro
  Future<void> clearUser();

  /// Verifica se há um usuário salvo
  Future<bool> hasUser();
}

/// Implementação do Local Data Source usando FlutterSecureStorage
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage secureStorage;
  static const String _userKey = 'cached_user';

  AuthLocalDataSourceImpl({required this.secureStorage});

  @override
  Future<void> saveUser(UserModel user) async {
    try {
      final userJson = json.encode(user.toJson());
      await secureStorage.write(key: _userKey, value: userJson);
    } catch (e) {
      throw CacheException(
        message: 'Erro ao salvar usuário: ${e.toString()}',
      );
    }
  }

  @override
  Future<UserModel> getUser() async {
    try {
      final userJson = await secureStorage.read(key: _userKey);

      if (userJson == null) {
        throw const CacheException(
          message: 'Nenhum usuário encontrado no cache',
        );
      }

      final userMap = json.decode(userJson) as Map<String, dynamic>;
      return UserModel.fromJson(userMap);
    } catch (e) {
      if (e is CacheException) {
        rethrow;
      }
      throw CacheException(
        message: 'Erro ao obter usuário: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> clearUser() async {
    try {
      await secureStorage.delete(key: _userKey);
    } catch (e) {
      throw CacheException(
        message: 'Erro ao limpar usuário: ${e.toString()}',
      );
    }
  }

  @override
  Future<bool> hasUser() async {
    try {
      final userJson = await secureStorage.read(key: _userKey);
      return userJson != null;
    } catch (e) {
      return false;
    }
  }
}
