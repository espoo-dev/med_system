class HealthInsuranceModel {
  List<HealthInsurance>? healthInsurancesList;

  HealthInsuranceModel({this.healthInsurancesList});

  HealthInsuranceModel.fromJson(List<dynamic> jsonList) {
    healthInsurancesList =
        jsonList.map((json) => HealthInsurance.fromJson(json)).toList();
  }

  List<dynamic> toJsonList() {
    return healthInsurancesList
            ?.map((healthInsurance) => healthInsurance.toJson())
            .toList() ??
        [];
  }
}

class HealthInsurance {
  int? id;
  String? name;

  HealthInsurance({this.id, this.name});

  HealthInsurance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
