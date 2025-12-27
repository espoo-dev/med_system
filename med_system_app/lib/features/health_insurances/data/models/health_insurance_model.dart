import 'package:distrito_medico/features/health_insurances/domain/entities/health_insurance_entity.dart';

class HealthInsuranceModel extends HealthInsuranceEntity {
  const HealthInsuranceModel({
    required super.id,
    required super.name,
  });

  factory HealthInsuranceModel.fromJson(Map<String, dynamic> json) {
    return HealthInsuranceModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  HealthInsuranceEntity toEntity() {
    return HealthInsuranceEntity(
      id: id,
      name: name,
    );
  }
}
