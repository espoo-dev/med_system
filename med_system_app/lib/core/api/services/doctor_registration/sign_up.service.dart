import "dart:async";
import 'package:chopper/chopper.dart';

part "sign_up.service.chopper.dart";

@ChopperApi(baseUrl: "/")
abstract class SignUpService extends ChopperService {
  static SignUpService create([ChopperClient? client]) =>
      _$SignUpService(client);
  @Post(path: 'users/tokens/sign_up')
  Future<Response> signUp(@Body() dynamic body);
}
