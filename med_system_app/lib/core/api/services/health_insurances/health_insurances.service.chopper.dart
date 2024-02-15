// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_insurances.service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: type=lint
final class _$HealthInsurancesService extends HealthInsurancesService {
  _$HealthInsurancesService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = HealthInsurancesService;

  @override
  Future<Response<dynamic>> getAllHealthInsurances() {
    final Uri $url = Uri.parse('/api/v1/health_insurances');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> registerHealthInsurances(dynamic body) {
    final Uri $url = Uri.parse('/api/v1/health_insurances');
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
