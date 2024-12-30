// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_procedure.service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$EventProcedureService extends EventProcedureService {
  _$EventProcedureService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = EventProcedureService;

  @override
  Future<Response<dynamic>> getAllEventProcedures(
    int page,
    int perPage,
  ) {
    final Uri $url = Uri.parse('/api/v1/event_procedures');
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
  Future<Response<dynamic>> getAllEventProceduresByPaid(
    int page,
    int perPage,
    bool payd,
  ) {
    final Uri $url = Uri.parse('/api/v1/event_procedures');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'per_page': perPage,
      'payd': payd,
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
  Future<Response<dynamic>> getAllEventProceduresByMonth(
    int page,
    int perPage,
    int month,
  ) {
    final Uri $url = Uri.parse('/api/v1/event_procedures');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'per_page': perPage,
      'month': month,
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
  Future<Response<dynamic>> getLatestEventProcedures(
    int page,
    int perPage,
  ) {
    final Uri $url = Uri.parse('/api/v1/event_procedures');
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

  @override
  Future<Response<dynamic>> editEventProcedure(
    dynamic id,
    dynamic body,
  ) {
    final Uri $url = Uri.parse('/api/v1/event_procedures/${id}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> editPaymentEventProcedure(
    dynamic id,
    dynamic body,
  ) {
    final Uri $url = Uri.parse('/api/v1/event_procedures/${id}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteEventProcedure(dynamic id) {
    final Uri $url = Uri.parse('/api/v1/event_procedures/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getEventProceduresByFilters({
    int? page,
    int? perPage,
    int? month,
    int? year,
    bool? payd,
    String? healthInsuranceName,
    String? hospitalName,
  }) {
    final Uri $url = Uri.parse('/api/v1/event_procedures');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'per_page': perPage,
      'month': month,
      'year': year,
      'payd': payd,
      'health_insurance[name]': healthInsuranceName,
      'hospital[name]': hospitalName,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
