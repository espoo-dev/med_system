/// Model para a requisição de criar/atualizar hospital
class HospitalRequestModel {
  final String name;
  final String address;

  const HospitalRequestModel({
    required this.name,
    required this.address,
  });

  /// Converte o HospitalRequestModel para JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
    };
  }
}
