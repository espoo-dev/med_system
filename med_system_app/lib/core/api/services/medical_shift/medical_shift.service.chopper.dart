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

  @override
  Future<Response<dynamic>> getAllMedicalShifts(
    int page,
    int perPage,
  ) {
    final Uri $url = Uri.parse('/api/v1/medical_shifts');
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
  Future<Response<dynamic>> getAllMedicalShiftsByPaid(
    int page,
    int perPage,
    bool payd,
  ) {
    final Uri $url = Uri.parse('/api/v1/medical_shifts');
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
  Future<Response<dynamic>> getAllMedicalShiftsByMonth(
    int page,
    int perPage,
    int month,
    int year,
  ) {
    final Uri $url = Uri.parse('/api/v1/medical_shifts');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'per_page': perPage,
      'month': month,
      'year': year,
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
  Future<Response<dynamic>> editPaymentMedicalShift(
    dynamic id,
    dynamic body,
  ) {
    final Uri $url = Uri.parse('/api/v1/medical_shifts/${id}');
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
  Future<Response<dynamic>> editMedicalShift(
    dynamic id,
    dynamic body,
  ) {
    final Uri $url = Uri.parse('/api/v1/medical_shifts/${id}');
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
  Future<Response<dynamic>> deleteEventMedicalShifts(dynamic id) {
    final Uri $url = Uri.parse('/api/v1/medical_shifts/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getAmountSuggetions() {
    final Uri $url = Uri.parse('/api/v1/medical_shifts/amount_suggestions');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getHospitalSuggetions() {
    final Uri $url =
        Uri.parse('/api/v1/medical_shifts/hospital_name_suggestion');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getLatestMedicalShifts(
    int page,
    int perPage,
  ) {
    final Uri $url = Uri.parse('/api/v1/medical_shifts');
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
}
