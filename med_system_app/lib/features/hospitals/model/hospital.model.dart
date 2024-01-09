class HospitalModel {
  List<Hospital>? hospitalList;

  HospitalModel({this.hospitalList});

  HospitalModel.fromJson(List<dynamic> jsonList) {
    hospitalList = jsonList.map((json) => Hospital.fromJson(json)).toList();
  }

  List<dynamic> toJsonList() {
    return hospitalList?.map((hospital) => hospital.toJson()).toList() ?? [];
  }
}

class Hospital {
  int? id;
  String? name;
  String? address;

  Hospital({this.id, this.name, this.address});

  Hospital.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    return data;
  }
}
