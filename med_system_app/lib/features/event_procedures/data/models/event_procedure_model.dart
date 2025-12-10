import '../../domain/entities/event_procedure_entity.dart';
import '../../domain/entities/event_procedure_result_entity.dart';

class EventProcedureModel extends EventProcedureEntity {
  const EventProcedureModel({
    super.id,
    super.procedure,
    super.patient,
    super.hospital,
    super.healthInsurance,
    super.patientServiceNumber,
    super.date,
    super.roomType,
    super.urgency,
    super.paidAt,
    super.paid,
    super.totalAmountCents,
    super.payment,
    super.procedureValue,
    super.procedureDescription,
  });

  factory EventProcedureModel.fromJson(Map<String, dynamic> json) {
    return EventProcedureModel(
      id: json['id'],
      procedure: json['procedure'],
      patient: json['patient'],
      hospital: json['hospital'],
      healthInsurance: json['health_insurance'],
      patientServiceNumber: json['patient_service_number'],
      date: json['date'],
      roomType: json['room_type'],
      urgency: json['urgency'],
      paidAt: json['paid_at'],
      paid: json['paid'],
      totalAmountCents: json['total_amount_cents']?.toString(), // Ensure String
      payment: json['payment'],
      procedureValue: json['precedure_value']?.toString(),
      procedureDescription: json['precedure_description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'procedure': procedure,
      'patient': patient,
      'hospital': hospital,
      'health_insurance': healthInsurance,
      'patient_service_number': patientServiceNumber,
      'date': date,
      'room_type': roomType,
      'urgency': urgency,
      'paid_at': paidAt,
      'paid': paid,
      'total_amount_cents': totalAmountCents,
      'payment': payment,
      'precedure_value': procedureValue,
      'precedure_description': procedureDescription,
    };
  }
}

class EventProcedureResultModel extends EventProcedureResultEntity {
  const EventProcedureResultModel({
    required super.items,
    super.total,
    super.totalPaid,
    super.totalUnpaid,
  });

  factory EventProcedureResultModel.fromJson(Map<String, dynamic> json) {
    List<EventProcedureEntity> items = [];
    if (json['event_procedures'] != null) {
      items = (json['event_procedures'] as List)
          .map((v) => EventProcedureModel.fromJson(v))
          .toList();
    }

    return EventProcedureResultModel(
      items: items,
      total: json['total']?.toString(), // Handle potential number or string
      totalPaid: json['total_paid']?.toString(),
      totalUnpaid: json['total_unpaid']?.toString(),
    );
  }
}
