import 'dart:convert';
import 'dart:typed_data';
import 'package:distrito_medico/core/api/api.dart';
import 'package:distrito_medico/core/errors/exceptions.dart';
import 'package:distrito_medico/features/medical_shifts/data/models/add_medical_shift_request_model.dart';
import 'package:distrito_medico/features/medical_shifts/data/models/amount_suggestions_model.dart';
import 'package:distrito_medico/features/medical_shifts/data/models/edit_payment_medical_shift_request_model.dart';
import 'package:distrito_medico/features/medical_shifts/data/models/hospital_suggestions_model.dart';
import 'package:distrito_medico/features/medical_shifts/data/models/medical_shift_list_model.dart';
import 'package:distrito_medico/features/medical_shifts/data/models/medical_shift_model.dart';
import 'package:distrito_medico/features/medical_shifts/data/models/medical_shift_recurrence_model.dart';

abstract class IMedicalShiftRemoteDataSource {
  Future<MedicalShiftListModel> getMedicalShifts({
    int page = 1,
    int? month,
    int? year,
    bool? paid,
    String? hospitalName,
  });

  Future<MedicalShiftModel> createMedicalShift(AddMedicalShiftRequestModel request);

  Future<MedicalShiftRecurrenceModel> createMedicalShiftRecurrence(MedicalShiftRecurrenceModel request);

  Future<MedicalShiftModel> editMedicalShift(int id, AddMedicalShiftRequestModel request);

  Future<MedicalShiftModel> updatePaymentStatus(int id, EditPaymentMedicalShiftModel request);

  Future<void> deleteMedicalShift(int id);

  Future<void> deleteMedicalShiftRecurrence(int recurrenceId);

  Future<List<String>> getHospitalSuggestions();

  Future<List<String>> getAmountSuggestions();

  Future<Uint8List> generatePdfReport({
    int? month,
    int? year,
    bool? paid,
    String? hospitalName,
  });
}

class MedicalShiftRemoteDataSource implements IMedicalShiftRemoteDataSource {
  @override
  Future<MedicalShiftListModel> getMedicalShifts({
    int page = 1,
    int? month,
    int? year,
    bool? paid,
    String? hospitalName,
  }) async {
    final response = await medicalShiftService.getMedicalShiftsByFilters(
      page: page,
      perPage: 10000,
      month: month,
      year: year,
      paid: paid,
      hospitalName: hospitalName,
    );

    if (response.isSuccessful) {
      return MedicalShiftListModel.fromJson(json.decode(response.body));
    } else {
      throw const ServerException(message: 'Erro ao carregar plantões');
    }
  }

  @override
  Future<MedicalShiftModel> createMedicalShift(AddMedicalShiftRequestModel request) async {
    final response = await medicalShiftService.registerMedicalShift(
      json.encode(request.toJson()),
    );

    if (response.isSuccessful) {
      return MedicalShiftModel.fromJson(json.decode(response.body));
    } else {
      throw const ServerException(message: 'Erro ao criar plantão');
    }
  }

  @override
  Future<MedicalShiftRecurrenceModel> createMedicalShiftRecurrence(MedicalShiftRecurrenceModel request) async {
    final response = await medicalShiftRecurrenceService.createMedicalShiftRecurrence(
      json.encode(request.toJson()),
    );

    if (response.isSuccessful) {
      return MedicalShiftRecurrenceModel.fromJson(json.decode(response.body));
    } else {
      throw const ServerException(message: 'Erro ao criar recorrência');
    }
  }

  @override
  Future<MedicalShiftModel> editMedicalShift(int id, AddMedicalShiftRequestModel request) async {
    final response = await medicalShiftService.editMedicalShift(
      id,
      json.encode(request.toJson()),
    );

    if (response.isSuccessful) {
      return MedicalShiftModel.fromJson(json.decode(response.body));
    } else {
      throw const ServerException(message: 'Erro ao editar plantão');
    }
  }

  @override
  Future<MedicalShiftModel> updatePaymentStatus(int id, EditPaymentMedicalShiftModel request) async {
    final response = await medicalShiftService.editPaymentMedicalShift(
      id,
      json.encode(request.toJson()),
    );

    if (response.isSuccessful) {
      return MedicalShiftModel.fromJson(json.decode(response.body));
    } else {
      throw const ServerException(message: 'Erro ao atualizar pagamento');
    }
  }

  @override
  Future<void> deleteMedicalShift(int id) async {
    final response = await medicalShiftService.deleteEventMedicalShifts(id);

    if (response.isSuccessful) {
      return;
    } else {
      throw const ServerException(message: 'Erro ao deletar plantão');
    }
  }

  @override
  Future<void> deleteMedicalShiftRecurrence(int recurrenceId) async {
    final response = await medicalShiftRecurrenceService.deleteMedicalShiftRecurrence(recurrenceId);

    if (response.isSuccessful) {
      return;
    } else {
      throw const ServerException(message: 'Erro ao deletar recorrência');
    }
  }

  @override
  Future<List<String>> getHospitalSuggestions() async {
    final response = await medicalShiftService.getHospitalSuggetions();

    if (response.isSuccessful) {
      final model = HospitalSuggestionModel.fromJson(json.decode(response.body));
      return model.names ?? [];
    } else {
      throw const ServerException(message: 'Erro ao carregar hospitais');
    }
  }

  @override
  Future<List<String>> getAmountSuggestions() async {
    final response = await medicalShiftService.getAmountSuggetions();

    if (response.isSuccessful) {
      final model = AmountSuggestionModel.fromJson(json.decode(response.body));
      return model.names ?? [];
    } else {
      throw const ServerException(message: 'Erro ao carregar valores');
    }
  }

  @override
  Future<Uint8List> generatePdfReport({
    int? month,
    int? year,
    bool? paid,
    String? hospitalName,
  }) async {
    final response = await medicalShiftService.generatePdfReport(
      entityName: 'medical_shifts',
      month: month,
      year: year,
      paid: paid,
      hospitalName: hospitalName,
    );

    if (response.isSuccessful) {
      return response.bodyBytes;
    } else {
      throw const ServerException(message: 'Erro ao gerar PDF');
    }
  }
}
