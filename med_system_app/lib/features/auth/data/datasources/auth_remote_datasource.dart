import 'dart:convert';
import 'package:distrito_medico/core/api/api.dart';
import 'package:distrito_medico/core/errors/exceptions.dart';
import 'package:distrito_medico/features/auth/data/models/signin_request_model.dart';
import 'package:distrito_medico/features/auth/data/models/user_model.dart';

/// Interface do Remote Data Source de autenticação
abstract class AuthRemoteDataSource {
  /// Realiza o login na API
  /// Lança [ServerException] em caso de erro
  Future<UserModel> signIn({
    required String email,
    required String password,
  });
}

/// Implementação do Remote Data Source usando Chopper
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final request = SignInRequestModel(
        email: email,
        password: password,
      );

      final response = await signInService.signIn(
        json.encode(request.toJson()),
      );

      if (response.isSuccessful && response.body != null) {
        final userModel = UserModel.fromJson(
          json.decode(response.body),
        );
        return userModel;
      } else {
        throw const ServerException(
          message: 'E-mail ou senha inválidos',
        );
      }
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      throw ServerException(
        message: 'Erro ao conectar com o servidor: ${e.toString()}',
      );
    }
  }
}
