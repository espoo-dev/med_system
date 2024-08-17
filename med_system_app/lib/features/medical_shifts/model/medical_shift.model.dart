import 'package:flutter/material.dart';

class MedicalShiftModel {
  int? id;
  String? hospitalName;
  String? workload;
  String? startDate;
  String? startHour;
  String? amountCents;
  bool? payd;
  String? title;
  String? shift;
  String? date;
  String? hour;

  MedicalShiftModel(
      {this.id,
      this.hospitalName,
      this.workload,
      this.startDate,
      this.startHour,
      this.amountCents,
      this.payd,
      this.title,
      this.shift,
      this.date,
      this.hour});

  MedicalShiftModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hospitalName = json['hospital_name'];
    workload = json['workload'];
    startDate = json['start_date'];
    startHour = json['start_hour'];
    amountCents = json['amount_cents'];
    payd = json['payd'];
    title = json['title'];
    shift = json['shift'];
    date = json['date'];
    hour = json['hour'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['hospital_name'] = hospitalName;
    data['workload'] = workload;
    data['start_date'] = startDate;
    data['start_hour'] = startHour;
    data['amount_cents'] = amountCents;
    data['payd'] = payd;
    data['title'] = title;
    data['shift'] = shift;
    data['hour'] = hour;
    return data;
  }

  MedicalShiftModel copyWith(
      {int? id,
      String? hospitalName,
      String? workload,
      String? startDate,
      String? startHour,
      String? amountCents,
      bool? payd,
      String? title,
      String? shift,
      String? date,
      String? hour}) {
    return MedicalShiftModel(
        id: id ?? this.id,
        hospitalName: hospitalName ?? this.hospitalName,
        workload: workload ?? this.workload,
        startDate: startDate ?? this.startDate,
        startHour: startHour ?? this.startHour,
        amountCents: amountCents ?? this.amountCents,
        payd: payd ?? this.payd,
        title: title ?? this.title,
        shift: shift ?? this.shift,
        date: date ?? this.date,
        hour: hour ?? this.hour);
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
