class MedicalShiftModel {
  int? id;
  String? hospitalName;
  String? workload;
  String? startDate;
  String? startHour;
  String? amountCents;
  bool? payd;

  MedicalShiftModel({
    this.id,
    this.hospitalName,
    this.workload,
    this.startDate,
    this.startHour,
    this.amountCents,
    this.payd,
  });

  MedicalShiftModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hospitalName = json['hospital_name'];
    workload = json['workload'];
    startDate = json['start_date'];
    startHour = json['start_hour'];
    amountCents = json['amount_cents'];
    payd = json['payd'];
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
    return data;
  }

  MedicalShiftModel copyWith({
    int? id,
    String? hospitalName,
    String? workload,
    String? startDate,
    String? startHour,
    String? amountCents,
    bool? payd,
  }) {
    return MedicalShiftModel(
      id: id ?? this.id,
      hospitalName: hospitalName ?? this.hospitalName,
      workload: workload ?? this.workload,
      startDate: startDate ?? this.startDate,
      startHour: startHour ?? this.startHour,
      amountCents: amountCents ?? this.amountCents,
      payd: payd ?? this.payd,
    );
  }
}
