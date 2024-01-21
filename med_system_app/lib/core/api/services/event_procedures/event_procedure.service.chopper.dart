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
  Future<Response<dynamic>> getAllEventProcedures(int page) {
    final Uri $url = Uri.parse('/api/v1/event_procedures');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> registerEventProcedure(dynamic body) {
    final Uri $url = Uri.parse('/api/v1/event_procedures');
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
