class AddEventProcedureRequestModel {
  int? hospitalId;
  HealthInsuranceAttributes? healthInsuranceAttributes;
  String? patientServiceNumber;
  String? date;
  String? paidAt;
  bool? paid;
  bool? urgency;
  String? payment;
  String? roomType;
  PatientAttributes? patientAttributes;
  ProcedureAttributes? procedureAttributes;

  AddEventProcedureRequestModel({
    this.hospitalId,
    this.healthInsuranceAttributes,
    this.patientServiceNumber,
    this.date,
    this.paidAt,
    this.paid,
    this.urgency,
    this.payment,
    this.roomType,
    this.patientAttributes,
    this.procedureAttributes,
  });

  AddEventProcedureRequestModel.fromJson(Map<String, dynamic> json) {
    hospitalId = json['hospital_id'];
    healthInsuranceAttributes = json['health_insurance_attributes'] != null
        ? HealthInsuranceAttributes.fromJson(
            json['health_insurance_attributes'])
        : null;
    patientServiceNumber = json['patient_service_number'];
    date = json['date'];
    paidAt = json['paid_at'];
    paid = json['paid'];
    urgency = json['urgency'];
    payment = json['payment'];
    roomType = json['room_type'];
    patientAttributes = json['patient_attributes'] != null
        ? PatientAttributes.fromJson(json['patient_attributes'])
        : null;
    procedureAttributes = json['procedure_attributes'] != null
        ? ProcedureAttributes.fromJson(json['procedure_attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hospital_id'] = hospitalId;
    if (healthInsuranceAttributes != null) {
      data['health_insurance_attributes'] = healthInsuranceAttributes!.toJson();
    }
    data['patient_service_number'] = patientServiceNumber;
    data['date'] = date;
    data['paid_at'] = paidAt;
    data['paid'] = paid;
    data['urgency'] = urgency;
    data['payment'] = payment;
    data['room_type'] = roomType;
    if (patientAttributes != null) {
      data['patient_attributes'] = patientAttributes!.toJson();
    }
    if (procedureAttributes != null) {
      data['procedure_attributes'] = procedureAttributes!.toJson();
    }
    return data;
  }
}

class HealthInsuranceAttributes {
  int? id;
  String? name;
  bool? custom;

  HealthInsuranceAttributes({this.id, this.name, this.custom});

  HealthInsuranceAttributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    custom = json['custom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['custom'] = custom;
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

class ProcedureAttributes {
  int? id;
  String? name;
  String? code;
  int? amountCents;
  String? description;
  bool? custom;

  ProcedureAttributes({
    this.id,
    this.name,
    this.code,
    this.amountCents,
    this.description,
    this.custom,
  });

  ProcedureAttributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    amountCents = json['amount_cents'];
    description = json['description'];
    custom = json['custom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['amount_cents'] = amountCents;
    data['description'] = description;
    data['custom'] = custom;
    return data;
  }
}
