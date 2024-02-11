class AddProcedureRequestModel {
  String? name;
  String? code;
  String? description;
  int? amountCents;

  AddProcedureRequestModel(
      {this.name, this.code, this.description, this.amountCents});

  AddProcedureRequestModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    description = json['description'];
    amountCents = json['amount_cents'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['code'] = code;
    data['description'] = description;
    data['amount_cents'] = amountCents;
    return data;
  }
}
