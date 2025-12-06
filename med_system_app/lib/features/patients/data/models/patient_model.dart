import 'package:distrito_medico/features/patients/domain/entities/patient_entity.dart';

/// Model para serialização/deserialização do Patient
class PatientModel extends PatientEntity {
  const PatientModel({
    required super.id,
    required super.name,
    required super.deletable,
  });

  /// Cria um PatientModel a partir de JSON
  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['id'] as int,
      name: json['name'] as String,
      deletable: json['deletable'] as bool? ?? true,
    );
  }

  /// Converte o PatientModel para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'deletable': deletable,
    };
  }

  /// Converte o Model para Entity
  PatientEntity toEntity() {
    return PatientEntity(
      id: id,
      name: name,
      deletable: deletable,
    );
  }

  /// Cria um PatientModel a partir de uma Entity
  factory PatientModel.fromEntity(PatientEntity entity) {
    return PatientModel(
      id: entity.id,
      name: entity.name,
      deletable: entity.deletable,
    );
  }
}
