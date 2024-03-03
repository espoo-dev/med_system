// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in.service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: type=lint
final class _$SignInService extends SignInService {
  _$SignInService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = SignInService;

  @override
  Future<Response<dynamic>> signIn(dynamic body) {
    final Uri $url = Uri.parse('/users/tokens/sign_in');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
