// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hospital.service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: type=lint
final class _$HospitalService extends HospitalService {
  _$HospitalService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = HospitalService;

  @override
  Future<Response<dynamic>> getAllHospitals(
    int page,
    int perPage,
  ) {
    final Uri $url = Uri.parse('/api/v1/hospitals');
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
  Future<Response<dynamic>> registerHospital(dynamic body) {
    final Uri $url = Uri.parse('/api/v1/hospitals');
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
  Future<Response<dynamic>> editHospital(
    dynamic id,
    dynamic body,
  ) {
    final Uri $url = Uri.parse('/api/v1/hospitals/${id}');
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
