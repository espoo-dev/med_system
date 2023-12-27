import "dart:async";
import 'package:chopper/chopper.dart';

part "sign_in.service.chopper.dart";

@ChopperApi(baseUrl: "/")
abstract class SignInService extends ChopperService {
  static SignInService create([ChopperClient? client]) =>
      _$SignInService(client);
  @Post(path: 'users/tokens/sign_in')
  Future<Response> signIn(@Body() dynamic body);
}
