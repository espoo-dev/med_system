class AddEventProcedureRequestModel {
  int? procedureId;
  int? patientId;
  int? hospitalId;
  int? healthInsuranceId;
  String? patientServiceNumber;
  String? date;
  String? paydAt;
  bool? urgency;
  String? roomType;

  AddEventProcedureRequestModel(
      {this.procedureId,
      this.patientId,
      this.hospitalId,
      this.healthInsuranceId,
      this.patientServiceNumber,
      this.date,
      this.paydAt,
      this.urgency,
      this.roomType});

  AddEventProcedureRequestModel.fromJson(Map<String, dynamic> json) {
    procedureId = json['procedure_id'];
    patientId = json['patient_id'];
    hospitalId = json['hospital_id'];
    healthInsuranceId = json['health_insurance_id'];
    patientServiceNumber = json['patient_service_number'];
    date = json['date'];
    paydAt = json['payd_at'];
    urgency = json['urgency'];
    roomType = json['room_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['procedure_id'] = procedureId;
    data['patient_id'] = patientId;
    data['hospital_id'] = hospitalId;
    data['health_insurance_id'] = healthInsuranceId;
    data['patient_service_number'] = patientServiceNumber;
    data['date'] = date;
    data['payd_at'] = paydAt;
    data['urgency'] = urgency;
    data['room_type'] = roomType;
    return data;
  }
}
