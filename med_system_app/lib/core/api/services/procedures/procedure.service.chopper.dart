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
  Future<Response<dynamic>> getAllProcedures(
    int page,
    int perPage,
  ) {
    final Uri $url = Uri.parse('/api/v1/procedures');
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
  Future<Response<dynamic>> registerProcedure(dynamic body) {
    final Uri $url = Uri.parse('/api/v1/procedures');
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
  Future<Response<dynamic>> editProcedure(
    dynamic id,
    dynamic body,
  ) {
    final Uri $url = Uri.parse('/api/v1/procedures/${id}');
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
