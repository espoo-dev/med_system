class EditPaymentEventProcedureModel {
  bool? paid;

  EditPaymentEventProcedureModel({this.paid});

  EditPaymentEventProcedureModel.fromJson(Map<String, dynamic> json) {
    paid = json['paid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paid'] = paid;
    return data;
  }
}
