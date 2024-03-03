import 'dart:convert';

import 'package:distrito_medico/core/api/api.dart';
import 'package:distrito_medico/core/api/api_result.dart';
import 'package:distrito_medico/core/api/error.model.dart';
import 'package:distrito_medico/core/api/network_exceptions.dart';
import 'package:distrito_medico/core/storage/constants/preferences.dart';
import 'package:distrito_medico/core/storage/shared_preference_helper.dart';
import 'package:distrito_medico/features/signin/model/signin_request.model.dart';
import 'package:distrito_medico/features/signin/model/user.model.dart';

class SignInRepository {
  final SharedPreferenceHelper _sharedPrefsHelper;

  SignInRepository(this._sharedPrefsHelper);

  Future<Result<dynamic>> signIn(String email, String password) async {
    try {
      SignInRequest? signInRequest = SignInRequest(
        email: email,
        password: password,
      );
      final requestLogin =
          await signInService.signIn(json.encode(signInRequest.toJson()));
      if (requestLogin.isSuccessful) {
        UserModel? userModelResponse =
            UserModel.fromJson(json.decode(requestLogin.body));
        saveUserStorage(userModelResponse);
        return Result.success(userModelResponse);
      } else {
        ErrorModelResponse? errorModelResponse =
            ErrorModelResponse(message: "E-mail ou Senha inválidos.");
        return Result.success(errorModelResponse);
      }
    } catch (e) {
      return Result.failure(NetworkExceptions.getException(e));
    }
  }

  saveUserStorage(UserModel user) async {
    await _sharedPrefsHelper.saveUserData(user);
  }

  getUserStorage() async {
    return await _sharedPrefsHelper.userData;
  }

  clearUserStorage() async {
    return await _sharedPrefsHelper.deleteSecureData(Preferences.isUser);
  }
}
