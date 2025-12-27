import 'package:distrito_medico/features/medical_shifts/domain/entities/medical_shift_entity.dart';

class MedicalShiftModel extends MedicalShiftEntity {
  const MedicalShiftModel({
    super.id,
    super.hospitalName,
    super.workload,
    super.startDate,
    super.startHour,
    super.amountCents,
    super.paid,
    super.title,
    super.shift,
    super.date,
    super.hour,
    super.medicalShiftRecurrenceId,
    super.color,
  });

  factory MedicalShiftModel.fromJson(Map<String, dynamic> json) {
    return MedicalShiftModel(
      id: json['id'],
      hospitalName: json['hospital_name'],
      workload: json['workload'],
      startDate: json['start_date'],
      startHour: json['start_hour'],
      amountCents: json['amount_cents']?.toString(), // Ensure type safety if needed. Origin was String?
      paid: json['paid'],
      title: json['title'],
      shift: json['shift'],
      date: json['date'],
      hour: json['hour'],
      medicalShiftRecurrenceId: json['medical_shift_recurrence_id'],
      color: json['color'],
    );
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
    data['date'] = date;
    data['hour'] = hour;
    data['medical_shift_recurrence_id'] = medicalShiftRecurrenceId;
    data['color'] = color;
    return data;
  }
}

