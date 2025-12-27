import 'package:distrito_medico/features/hospitals/domain/entities/hospital_entity.dart';

/// Model para serialização/deserialização do Hospital
class HospitalModel extends HospitalEntity {
  const HospitalModel({
    required super.id,
    required super.name,
    required super.address,
  });

  /// Cria um HospitalModel a partir de JSON
  factory HospitalModel.fromJson(Map<String, dynamic> json) {
    return HospitalModel(
      id: json['id'] as int,
      name: json['name'] as String,
      address: json['address'] as String,
    );
  }

  /// Converte o HospitalModel para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
    };
  }

  /// Converte o Model para Entity
  HospitalEntity toEntity() {
    return HospitalEntity(
      id: id,
      name: name,
      address: address,
    );
  }

  /// Cria um HospitalModel a partir de uma Entity
  factory HospitalModel.fromEntity(HospitalEntity entity) {
    return HospitalModel(
      id: entity.id,
      name: entity.name,
      address: entity.address,
    );
  }
}
