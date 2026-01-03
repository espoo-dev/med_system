class MedicalShiftRecurrenceModel {
  int? id;
  String? frequency;
  int? dayOfWeek;
  int? dayOfMonth;
  String? endDate;
  String? workload;
  String? startDate;
  int? amountCents;
  String? hospitalName;
  String? startHour;
  String? color;

  MedicalShiftRecurrenceModel({
    this.id,
    this.frequency,
    this.dayOfWeek,
    this.dayOfMonth,
    this.endDate,
    this.workload,
    this.startDate,
    this.amountCents,
    this.hospitalName,
    this.startHour,
    this.color,
  });

  MedicalShiftRecurrenceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    frequency = json['frequency'];
    dayOfWeek = json['day_of_week'];
    dayOfMonth = json['day_of_month'];
    endDate = json['end_date'];
    workload = json['workload'];
    startDate = json['start_date'];
    amountCents = json['amount_cents'];
    hospitalName = json['hospital_name'];
    startHour = json['start_hour'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['frequency'] = frequency;
    data['day_of_week'] = dayOfWeek;
    data['day_of_month'] = dayOfMonth;
    data['end_date'] = endDate;
    data['workload'] = workload;
    data['start_date'] = startDate;
    data['amount_cents'] = amountCents;
    data['hospital_name'] = hospitalName;
    data['start_hour'] = startHour;
    data['color'] = color;
    return data;
  }
}
