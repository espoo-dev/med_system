class EventProcedureModel {
  List<EventProcedures>? eventProceduresList;
  String? total = "";
  String? totalPayd = "";
  String? totalUnpayd = "";

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
  String? procedure;
  String? patient;
  String? hospital;
  String? healthInsurance;
  String? patientServiceNumber;
  String? date;
  String? roomType;
  bool? urgency;
  String? paydAt;
  bool? payd;
  String? totalAmountCents;
  String? payment;

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
      String? paydAt,
      bool? payd,
      String? totalAmountCents,
      String? payment}) {
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
      paydAt: paydAt ?? this.paydAt,
      payd: payd ?? this.payd,
      totalAmountCents: totalAmountCents ?? this.totalAmountCents,
      payment: payment ?? this.payment,
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
      this.paydAt,
      this.payd,
      this.totalAmountCents,
      this.payment});

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
    paydAt = json['payd_at'];
    payd = json['payd'];
    payment = json['payment'];
    totalAmountCents = json['total_amount_cents'];
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
    data['payd_at'] = paydAt;
    data['payd'] = payd;
    data['payment'] = payment;
    data['total_amount_cents'] = totalAmountCents;
    return data;
  }
}
