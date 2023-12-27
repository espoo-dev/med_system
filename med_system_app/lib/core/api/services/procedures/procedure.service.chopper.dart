// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'procedure.service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: type=lint
final class _$ProcedureService extends ProcedureService {
  _$ProcedureService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ProcedureService;

  @override
  Future<Response<dynamic>> getAllProcedures() {
    final Uri $url = Uri.parse('/api/v1/procedures');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
