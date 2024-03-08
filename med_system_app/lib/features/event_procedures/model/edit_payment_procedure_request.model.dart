class EditPaymentEventProcedureModel {
  String? paydAt;

  EditPaymentEventProcedureModel({this.paydAt});

  EditPaymentEventProcedureModel.fromJson(Map<String, dynamic> json) {
    paydAt = json['payd_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payd_at'] = paydAt;
    return data;
  }
}
