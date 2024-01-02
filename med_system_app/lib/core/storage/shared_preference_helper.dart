import 'dart:convert' show json;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:med_system_app/core/modules/signin/model/user_dto.model.dart';
import 'package:med_system_app/core/storage/constants/preferences.dart';

class SharedPreferenceHelper {
  final FlutterSecureStorage _sharedPreference;

  SharedPreferenceHelper(this._sharedPreference);

  Future<void> saveUserData(UserDTO user) async {
    await _sharedPreference.write(
        key: Preferences.isUser, value: json.encode(user));
  }

  Future<UserDTO> get userData async {
    String? user = await _sharedPreference.read(key: Preferences.isUser);
    if (user != null) {
      return UserDTO.fromJson(json.decode(user));
    }
    return UserDTO();
  }

  Future deleteSecureData(String key) async {
    var deleteData = await _sharedPreference.delete(key: key);
    return deleteData;
  }
}
