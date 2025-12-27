import 'dart:convert';
import 'package:distrito_medico/core/api/api.dart';
import 'package:distrito_medico/core/errors/exceptions.dart';
import 'package:distrito_medico/features/doctor_registration/data/models/signup_model.dart';
import 'package:distrito_medico/features/doctor_registration/data/models/signup_request_model.dart';

/// Interface do Remote Data Source para cadastro
abstract class SignUpRemoteDataSource {
  Future<SignUpModel> signUp({
    required String email,
    required String password,
  });
}

/// Implementação do Remote Data Source para cadastro
class SignUpRemoteDataSourceImpl implements SignUpRemoteDataSource {
  @override
  Future<SignUpModel> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final request = SignUpRequestModel(
        email: email,
        password: password,
      );

      final response = await signUpService.signUp(
        json.encode(request.toJson()),
      );

      if (response.isSuccessful) {
        return const SignUpModel(
          success: true,
          message: 'Cadastro realizado com sucesso',
        );
      } else if (response.statusCode == 422) {
        throw const ServerException(
          message: 'Usuário já cadastrado',
        );
      } else if (response.statusCode == 400) {
        throw const ServerException(
          message: 'Dados inválidos',
        );
      } else {
        throw ServerException(
          message: 'Erro ao realizar cadastro: ${response.statusCode}',
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
