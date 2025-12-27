import 'package:equatable/equatable.dart';

class MedicalShiftEntity extends Equatable {
  final int? id;
  final String? hospitalName;
  final String? workload;
  final String? startDate;
  final String? startHour;
  final String? amountCents;
  final bool? paid;
  final String? title;
  final String? shift;
  final String? date;
  final String? hour;
  final int? medicalShiftRecurrenceId;
  final String? color;

  const MedicalShiftEntity({
    this.id,
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
    this.medicalShiftRecurrenceId,
    this.color,
  });

  @override
  List<Object?> get props => [
        id,
        hospitalName,
        workload,
        startDate,
        startHour,
        amountCents,
        paid,
        title,
        shift,
        date,
        hour,
        medicalShiftRecurrenceId,
        color,
      ];
      
  MedicalShiftEntity copyWith({
    int? id,
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
    int? medicalShiftRecurrenceId,
    String? color,
  }) {
    return MedicalShiftEntity(
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
          medicalShiftRecurrenceId ?? this.medicalShiftRecurrenceId,
      color: color ?? this.color,
    );
  }
}

