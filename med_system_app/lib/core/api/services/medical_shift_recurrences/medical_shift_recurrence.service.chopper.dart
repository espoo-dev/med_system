// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medical_shift_recurrence.service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$MedicalShiftRecurrenceService
    extends MedicalShiftRecurrenceService {
  _$MedicalShiftRecurrenceService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = MedicalShiftRecurrenceService;

  @override
  Future<Response<dynamic>> createMedicalShiftRecurrence(dynamic body) {
    final Uri $url = Uri.parse('/api/v1/medical_shift_recurrences');
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
  Future<Response<dynamic>> deleteMedicalShiftRecurrence(dynamic id) {
    final Uri $url = Uri.parse('/api/v1/medical_shift_recurrences/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
