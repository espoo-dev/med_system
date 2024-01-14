// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_procedure.service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: type=lint
final class _$EventProcedureService extends EventProcedureService {
  _$EventProcedureService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = EventProcedureService;

  @override
  Future<Response<dynamic>> getAllEventProcedures() {
    final Uri $url = Uri.parse('/api/v1/event_procedures');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
