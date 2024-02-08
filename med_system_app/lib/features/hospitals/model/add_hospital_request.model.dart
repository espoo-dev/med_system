class AddHospitalRequestModel {
  String? name;
  String? address;

  AddHospitalRequestModel({
    this.name,
    this.address
  });

  AddHospitalRequestModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['address'] = address;
    return data;
  }
}
