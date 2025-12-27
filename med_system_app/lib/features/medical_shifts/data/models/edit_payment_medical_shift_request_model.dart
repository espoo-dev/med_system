class EditPaymentMedicalShiftModel {
  bool? paid;

  EditPaymentMedicalShiftModel({this.paid});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paid'] = paid;
    return data;
  }
}
