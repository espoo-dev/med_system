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
  Future<Response<dynamic>> getAllHospitals() {
    final Uri $url = Uri.parse('/api/v1/hospitals');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
