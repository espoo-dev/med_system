import 'dart:convert' show json;

import 'package:distrito_medico/core/storage/constants/preferences.dart';
import 'package:distrito_medico/features/signin/model/user.model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SharedPreferenceHelper {
  final FlutterSecureStorage _sharedPreference;

  SharedPreferenceHelper(this._sharedPreference);

  Future<void> saveUserData(UserModel user) async {
    await _sharedPreference.write(
        key: Preferences.isUser, value: json.encode(user));
  }

  Future<UserModel> get userData async {
    String? user = await _sharedPreference.read(key: Preferences.isUser);
    if (user != null) {
      return UserModel.fromJson(json.decode(user));
    }
    return UserModel();
  }

  Future deleteSecureData(String key) async {
    var deleteData = await _sharedPreference.delete(key: key);
    return deleteData;
  }
}
