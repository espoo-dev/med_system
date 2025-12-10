class HospitalSuggestionModel {
  List<String>? names;

  HospitalSuggestionModel({this.names});

  HospitalSuggestionModel.fromJson(Map<String, dynamic> json) {
    names = json['names'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['names'] = names;
    return data;
  }
}
