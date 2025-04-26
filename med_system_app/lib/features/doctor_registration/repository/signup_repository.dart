import 'dart:convert';
import 'package:distrito_medico/core/api/api.dart';
import 'package:distrito_medico/core/api/api_result.dart';
import 'package:distrito_medico/core/api/network_exceptions.dart';
import 'package:distrito_medico/features/doctor_registration/model/signup_request.model.dart';

class SignUpRepository {
  Future<Result<bool>> signUp(String email, String password) async {
    try {
      final request = SignUpRequest(email: email, password: password);

      final response =
          await signUpService.signUp(json.encode(request.toJson()));

      if (response.isSuccessful) {
        return const Result.success(true);
      } else if (response.statusCode == 422) {
        return const Result.failure(
            NetworkExceptions.defaultError("Usuário já cadastrado."));
      } else {
        return const Result.failure(NetworkExceptions.badRequest());
      }
    } catch (e) {
      return Result.failure(NetworkExceptions.getException(e));
    }
  }
}
