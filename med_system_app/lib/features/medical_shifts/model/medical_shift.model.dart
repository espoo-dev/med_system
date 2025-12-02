import 'package:flutter/material.dart';

class MedicalShiftModel {
  int? id;
  String? hospitalName;
  String? workload;
  String? startDate;
  String? startHour;
  String? amountCents;
  bool? paid;
  String? title;
  String? shift;
  String? date;
  String? hour;
  int? medicalShiftRecurrenceId;

  MedicalShiftModel(
      {this.id,
      this.hospitalName,
      this.workload,
      this.startDate,
      this.startHour,
      this.amountCents,
      this.paid,
      this.title,
      this.shift,
      this.date,
      this.hour,
      this.medicalShiftRecurrenceId});

  MedicalShiftModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hospitalName = json['hospital_name'];
    workload = json['workload'];
    startDate = json['start_date'];
    startHour = json['start_hour'];
    amountCents = json['amount_cents'];
    paid = json['paid'];
    title = json['title'];
    shift = json['shift'];
    date = json['date'];
    hour = json['hour'];
    medicalShiftRecurrenceId = json['medical_shift_recurrence_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['hospital_name'] = hospitalName;
    data['workload'] = workload;
    data['start_date'] = startDate;
    data['start_hour'] = startHour;
    data['amount_cents'] = amountCents;
    data['paid'] = paid;
    data['title'] = title;
    data['shift'] = shift;
    data['hour'] = hour;
    data['medical_shift_recurrence_id'] = medicalShiftRecurrenceId;
    return data;
  }

  MedicalShiftModel copyWith(
      {int? id,
      String? hospitalName,
      String? workload,
      String? startDate,
      String? startHour,
      String? amountCents,
      bool? paid,
      String? title,
      String? shift,
      String? date,
      String? hour,
      int? medicalShiftRecurrenceId}) {
    return MedicalShiftModel(
        id: id ?? this.id,
        hospitalName: hospitalName ?? this.hospitalName,
        workload: workload ?? this.workload,
        startDate: startDate ?? this.startDate,
        startHour: startHour ?? this.startHour,
        amountCents: amountCents ?? this.amountCents,
        paid: paid ?? this.paid,
        title: title ?? this.title,
        shift: shift ?? this.shift,
        date: date ?? this.date,
        hour: hour ?? this.hour,
        medicalShiftRecurrenceId:
            medicalShiftRecurrenceId ?? this.medicalShiftRecurrenceId);
  }

  Icon get shiftIcon {
    if (shift == "Daytime") {
      return const Icon(size: 24.0, Icons.wb_sunny, color: Colors.orange);
    } else {
      return const Icon(
          size: 24.0, Icons.nightlight_round, color: Colors.blueGrey);
    }
  }

  String get shiftDescription {
    return (shift == "Daytime") ? "Diurno" : "Noturno";
  }
}
