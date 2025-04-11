class EventProcedureModel {
  List<EventProcedures>? eventProceduresList;
  String? total = "";
  String? totalpaid = "";
  String? totalUnpaid = "";

  EventProcedureModel(
      {this.eventProceduresList, this.total, this.totalpaid, this.totalUnpaid});

  EventProcedureModel.fromJson(Map<String, dynamic> json) {
    if (json['event_procedures'] != null) {
      eventProceduresList = <EventProcedures>[];
      json['event_procedures'].forEach((v) {
        eventProceduresList!.add(EventProcedures.fromJson(v));
      });
    }
    total = json['total'];
    totalpaid = json['total_paid'];
    totalUnpaid = json['total_unpaid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (eventProceduresList != null) {
      data['event_procedures'] =
          eventProceduresList!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['total_paid'] = totalpaid;
    data['total_unpaid'] = totalUnpaid;
    return data;
  }
}

class EventProcedures {
  int? id;
  String? procedure;
  String? patient;
  String? hospital;
  String? healthInsurance;
  String? patientServiceNumber;
  String? date;
  String? roomType;
  bool? urgency;
  String? paidAt;
  bool? paid;
  String? totalAmountCents;
  String? payment;
  String? procedureValue;
  String? precedureDescription;

  EventProcedures copyWith(
      {int? id,
      String? procedure,
      String? patient,
      String? hospital,
      String? healthInsurance,
      String? patientServiceNumber,
      String? date,
      String? roomType,
      bool? urgency,
      String? paidAt,
      bool? paid,
      String? totalAmountCents,
      String? payment,
      String? procedureValue,
      String? precedureDescription}) {
    return EventProcedures(
      id: id ?? this.id,
      procedure: procedure ?? this.procedure,
      patient: patient ?? this.patient,
      hospital: hospital ?? this.hospital,
      healthInsurance: healthInsurance ?? this.healthInsurance,
      patientServiceNumber: patientServiceNumber ?? this.patientServiceNumber,
      date: date ?? this.date,
      roomType: roomType ?? this.roomType,
      urgency: urgency ?? this.urgency,
      paidAt: paidAt ?? this.paidAt,
      paid: paid ?? this.paid,
      totalAmountCents: totalAmountCents ?? this.totalAmountCents,
      payment: payment ?? this.payment,
      procedureValue: procedureValue ?? this.procedureValue,
      precedureDescription: precedureDescription ?? this.precedureDescription,
    );
  }

  EventProcedures(
      {this.id,
      this.procedure,
      this.patient,
      this.hospital,
      this.healthInsurance,
      this.patientServiceNumber,
      this.date,
      this.roomType,
      this.urgency,
      this.paidAt,
      this.paid,
      this.totalAmountCents,
      this.payment,
      this.procedureValue,
      this.precedureDescription});

  EventProcedures.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    procedure = json['procedure'];
    patient = json['patient'];
    hospital = json['hospital'];
    healthInsurance = json['health_insurance'];
    patientServiceNumber = json['patient_service_number'];
    date = json['date'];
    roomType = json['room_type'];
    urgency = json['urgency'];
    paidAt = json['paid_at'];
    paid = json['paid'];
    payment = json['payment'];
    totalAmountCents = json['total_amount_cents'];
    procedureValue = json['precedure_value'];
    precedureDescription = json['precedure_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['procedure'] = procedure;
    data['patient'] = patient;
    data['hospital'] = hospital;
    data['health_insurance'] = healthInsurance;
    data['patient_service_number'] = patientServiceNumber;
    data['date'] = date;
    data['room_type'] = roomType;
    data['urgency'] = urgency;
    data['paid_at'] = paidAt;
    data['paid'] = paid;
    data['payment'] = payment;
    data['total_amount_cents'] = totalAmountCents;
    data['precedure_value'] = procedureValue;
    data['precedure_description'] = precedureDescription;
    return data;
  }
}
