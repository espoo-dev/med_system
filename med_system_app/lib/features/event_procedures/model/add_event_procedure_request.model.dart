class AddEventProcedureRequestModel {
  int? procedureId;
  int? hospitalId;
  int? healthInsuranceId;
  String? patientServiceNumber;
  String? date;
  String? paydAt;
  bool? urgency;
  String? roomType;
  PatientAttributes? patientAttributes;

  AddEventProcedureRequestModel(
      {this.procedureId,
      this.hospitalId,
      this.healthInsuranceId,
      this.patientServiceNumber,
      this.date,
      this.paydAt,
      this.urgency,
      this.roomType,
      this.patientAttributes});

  AddEventProcedureRequestModel.fromJson(Map<String, dynamic> json) {
    procedureId = json['procedure_id'];
    hospitalId = json['hospital_id'];
    healthInsuranceId = json['health_insurance_id'];
    patientServiceNumber = json['patient_service_number'];
    date = json['date'];
    paydAt = json['payd_at'];
    urgency = json['urgency'];
    roomType = json['room_type'];
    patientAttributes = json['patient_attributes'] != null
        ? PatientAttributes.fromJson(json['patient_attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['procedure_id'] = procedureId;
    data['hospital_id'] = hospitalId;
    data['health_insurance_id'] = healthInsuranceId;
    data['patient_service_number'] = patientServiceNumber;
    data['date'] = date;
    data['payd_at'] = paydAt;
    data['urgency'] = urgency;
    data['room_type'] = roomType;
    if (patientAttributes != null) {
      data['patient_attributes'] = patientAttributes!.toJson();
    }
    return data;
  }
}

class PatientAttributes {
  int? id;
  String? name;

  PatientAttributes({this.id, this.name});

  PatientAttributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
