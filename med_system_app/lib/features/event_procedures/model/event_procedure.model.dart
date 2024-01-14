class EventProcedureModel {
  List<EventProcedures>? eventProceduresList;
  String? total;
  String? totalPayd;
  String? totalUnpayd;

  EventProcedureModel(
      {this.eventProceduresList, this.total, this.totalPayd, this.totalUnpayd});

  EventProcedureModel.fromJson(Map<String, dynamic> json) {
    if (json['event_procedures'] != null) {
      eventProceduresList = <EventProcedures>[];
      json['event_procedures'].forEach((v) {
        eventProceduresList!.add(EventProcedures.fromJson(v));
      });
    }
    total = json['total'];
    totalPayd = json['total_payd'];
    totalUnpayd = json['total_unpayd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (eventProceduresList != null) {
      data['event_procedures'] =
          eventProceduresList!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['total_payd'] = totalPayd;
    data['total_unpayd'] = totalUnpayd;
    return data;
  }
}

class EventProcedures {
  int? id;
  int? procedureId;
  int? patientId;
  int? hospitalId;
  int? healthInsuranceId;
  String? patientServiceNumber;
  String? date;
  bool? urgency;
  String? paydAt;
  String? roomType;
  String? createdAt;
  String? updatedAt;

  EventProcedures(
      {this.id,
      this.procedureId,
      this.patientId,
      this.hospitalId,
      this.healthInsuranceId,
      this.patientServiceNumber,
      this.date,
      this.urgency,
      this.paydAt,
      this.roomType,
      this.createdAt,
      this.updatedAt});

  EventProcedures.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    procedureId = json['procedure_id'];
    patientId = json['patient_id'];
    hospitalId = json['hospital_id'];
    healthInsuranceId = json['health_insurance_id'];
    patientServiceNumber = json['patient_service_number'];
    date = json['date'];
    urgency = json['urgency'];
    paydAt = json['payd_at'];
    roomType = json['room_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['procedure_id'] = procedureId;
    data['patient_id'] = patientId;
    data['hospital_id'] = hospitalId;
    data['health_insurance_id'] = healthInsuranceId;
    data['patient_service_number'] = patientServiceNumber;
    data['date'] = date;
    data['urgency'] = urgency;
    data['payd_at'] = paydAt;
    data['room_type'] = roomType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
