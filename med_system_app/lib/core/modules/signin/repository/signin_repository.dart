import 'dart:convert';

import 'package:med_system_app/core/api/api.dart';
import 'package:med_system_app/core/api/api_result.dart';
import 'package:med_system_app/core/api/error.model.dart';
import 'package:med_system_app/core/api/network_exceptions.dart';
import 'package:med_system_app/core/modules/signin/model/signin_request.model.dart';
import 'package:med_system_app/core/modules/signin/model/user_dto.model.dart';
import 'package:med_system_app/core/storage/constants/preferences.dart';
import 'package:med_system_app/core/storage/shared_preference_helper.dart';

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
        UserDTO? userModelResponse =
            UserDTO.fromJson(json.decode(requestLogin.body));

        return Result.success(userModelResponse);
      } else {
        ErrorModelResponse? errorModelResponse = ErrorModelResponse.fromJson(
            json.decode(requestLogin.error.toString()));
        return Result.success(errorModelResponse);
      }
    } catch (e) {
      return Result.failure(NetworkExceptions.getException(e));
    }
  }

  saveUserStorage(UserDTO user) async {
    await _sharedPrefsHelper.saveUserData(user);
  }

  getUserStorage() async {
    return await _sharedPrefsHelper.userData;
  }

  clearUserStorage() async {
    return await _sharedPrefsHelper.deleteSecureData(Preferences.isUser);
  }
}
