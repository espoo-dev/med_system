class PatientModel {
  List<Patient>? patientList;

  PatientModel({this.patientList});

  PatientModel.fromJson(List<dynamic> jsonList) {
    patientList = jsonList.map((json) => Patient.fromJson(json)).toList();
  }

  List<dynamic> toJsonList() {
    return patientList?.map((procedure) => procedure.toJson()).toList() ?? [];
  }
}

class Patient {
  int? id;
  String? name;
  bool? deletable;

  Patient({this.id, this.name});

  Patient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    deletable = json['deletable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['deletable'] = deletable;
    return data;
  }
}
