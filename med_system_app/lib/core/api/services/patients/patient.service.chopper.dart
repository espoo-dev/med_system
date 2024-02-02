// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: type=lint
final class _$PatientService extends PatientService {
  _$PatientService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = PatientService;

  @override
  Future<Response<dynamic>> getAllPatients(
    int page,
    int perPage,
  ) {
    final Uri $url = Uri.parse('/api/v1/patients');
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
  Future<Response<dynamic>> registerPatient(dynamic body) {
    final Uri $url = Uri.parse('/api/v1/patients');
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
  Future<Response<dynamic>> editPatient(
    dynamic id,
    dynamic body,
  ) {
    final Uri $url = Uri.parse('/api/v1/patients/${id}');
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
