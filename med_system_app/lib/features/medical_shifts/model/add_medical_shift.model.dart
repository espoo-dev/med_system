class AddMedicalShiftRequestModel {
  String? hospitalName;
  String? workload;
  String? startDate;
  String? startHour;
  int? amountCents;
  bool? payd;

  AddMedicalShiftRequestModel({
    this.hospitalName,
    this.workload,
    this.startDate,
    this.startHour,
    this.amountCents,
    this.payd,
  });

  AddMedicalShiftRequestModel.fromJson(Map<String, dynamic> json) {
    hospitalName = json['hospital_name'];
    workload = json['workload'];
    startDate = json['start_date'];
    startHour = json['start_hour'];
    amountCents = json['amount_cents'];
    payd = json['payd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hospital_name'] = hospitalName;
    data['workload'] = workload;
    data['start_date'] = startDate;
    data['start_hour'] = startHour;
    data['amount_cents'] = amountCents;
    data['payd'] = payd;
    return data;
  }
}
