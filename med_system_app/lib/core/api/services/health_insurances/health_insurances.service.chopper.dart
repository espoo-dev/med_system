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
  Future<Response<dynamic>> getAllHealthInsurances(
    int page,
    int perPage,
  ) {
    final Uri $url = Uri.parse('/api/v1/health_insurances');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'per_page': perPage,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
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

  @override
  Future<Response<dynamic>> editHealthInsurance(
    dynamic id,
    dynamic body,
  ) {
    final Uri $url = Uri.parse('/api/v1/health_insurances/${id}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
