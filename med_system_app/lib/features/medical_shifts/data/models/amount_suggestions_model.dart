class AmountSuggestionModel {
  List<String>? names;

  AmountSuggestionModel({this.names});

  AmountSuggestionModel.fromJson(Map<String, dynamic> json) {
    names = json['names'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['names'] = names;
    return data;
  }
}
