class EditPaymentMedicalShiftModel {
  bool? payd;

  EditPaymentMedicalShiftModel({this.payd});

  EditPaymentMedicalShiftModel.fromJson(Map<String, dynamic> json) {
    payd = json['payd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payd'] = payd;
    return data;
  }
}
