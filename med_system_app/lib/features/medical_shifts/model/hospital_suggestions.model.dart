class HospitalSuggestionModel {
  List<String>? names;

  HospitalSuggestionModel({this.names});

  HospitalSuggestionModel.fromJson(Map<String, dynamic> json) {
    if (json['names'] != null) {
      names = List<String>.from(json['names']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (names != null) {
      data['names'] = names;
    }
    return data;
  }
}
