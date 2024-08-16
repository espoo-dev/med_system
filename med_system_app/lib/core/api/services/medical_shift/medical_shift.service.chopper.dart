// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medical_shift.service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$MedicalShiftService extends MedicalShiftService {
  _$MedicalShiftService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = MedicalShiftService;

  @override
  Future<Response<dynamic>> registerMedicalShift(dynamic body) {
    final Uri $url = Uri.parse('/api/v1/medical_shifts');
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
