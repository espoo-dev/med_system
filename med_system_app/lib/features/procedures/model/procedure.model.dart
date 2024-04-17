class ProcedureModel {
  List<Procedure>? procedureList;

  ProcedureModel({this.procedureList});

  ProcedureModel.fromJson(List<dynamic> jsonList) {
    procedureList = jsonList.map((json) => Procedure.fromJson(json)).toList();
  }

  List<dynamic> toJsonList() {
    return procedureList?.map((procedure) => procedure.toJson()).toList() ?? [];
  }
}

class Procedure {
  int? id;
  String? name;
  String? code;
  String? description;
  String? amountCents;

  Procedure({
    this.id,
    this.name,
    this.code,
    this.description,
    this.amountCents,
  });

  Procedure.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    description = json['description'];
    amountCents = json['amount_cents'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['description'] = description;
    data['amount_cents'] = amountCents;
    return data;
  }

  Procedure copyWith({
    int? id,
    String? name,
    String? code,
    String? description,
    String? amountCents,
  }) {
    return Procedure(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      description: description ?? this.description,
      amountCents: amountCents ?? this.amountCents,
    );
  }
}
