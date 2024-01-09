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
  Future<Response<dynamic>> getAllPatients() {
    final Uri $url = Uri.parse('/api/v1/patients');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
