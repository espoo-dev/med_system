class HealthInsuranceRequestModel {
  final String name;

  const HealthInsuranceRequestModel({required this.name});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
