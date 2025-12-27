/// Model para a requisição de criar/atualizar paciente
class PatientRequestModel {
  final String name;

  const PatientRequestModel({required this.name});

  /// Converte o PatientRequestModel para JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
