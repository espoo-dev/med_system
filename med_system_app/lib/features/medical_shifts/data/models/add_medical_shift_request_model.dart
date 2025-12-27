class AddMedicalShiftRequestModel {
  String? hospitalName;
  String? workload;
  String? startDate;
  String? startHour;
  int? amountCents;
  bool? paid;
  String? color;

  AddMedicalShiftRequestModel({
    this.hospitalName,
    this.workload,
    this.startDate,
    this.startHour,
    this.amountCents,
    this.paid,
    this.color,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hospital_name'] = hospitalName;
    data['workload'] = workload;
    data['start_date'] = startDate;
    data['start_hour'] = startHour;
    data['amount_cents'] = amountCents;
    data['paid'] = paid;
    data['color'] = color;
    return data;
  }
}

