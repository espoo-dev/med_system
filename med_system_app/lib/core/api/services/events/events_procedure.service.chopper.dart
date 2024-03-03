// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_procedure.service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: type=lint
final class _$EventsService extends EventsService {
  _$EventsService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = EventsService;

  @override
  Future<Response<dynamic>> getAllProcedures() {
    final Uri $url = Uri.parse('/api/v1/event_procedures');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
