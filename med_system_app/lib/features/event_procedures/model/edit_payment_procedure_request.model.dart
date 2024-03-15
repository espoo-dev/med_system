class EditPaymentEventProcedureModel {
  bool? payd;

  EditPaymentEventProcedureModel({this.payd});

  EditPaymentEventProcedureModel.fromJson(Map<String, dynamic> json) {
    payd = json['payd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payd'] = payd;
    return data;
  }
}
