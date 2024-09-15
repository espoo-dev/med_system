class AmountSuggestionModel {
  List<String>? names;

  AmountSuggestionModel({this.names});

  AmountSuggestionModel.fromJson(Map<String, dynamic> json) {
    if (json['amounts_cents'] != null) {
      names = List<String>.from(json['amounts_cents']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (names != null) {
      data['amounts_cents'] = names;
    }
    return data;
  }
}
