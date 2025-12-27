import 'package:distrito_medico/features/procedures/domain/entities/procedure_entity.dart';

class ProcedureModel extends ProcedureEntity {
  const ProcedureModel({
    required super.id,
    required super.name,
    required super.code,
    required super.description,
    required super.amountCents,
  });

  factory ProcedureModel.fromJson(Map<String, dynamic> json) {
    return ProcedureModel(
      id: json['id'] as int,
      name: json['name'] as String,
      code: json['code'] as String,
      description: json['description'] as String? ?? '',
      amountCents: json['amount_cents']?.toString() ?? '0',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'description': description,
      'amount_cents': amountCents,
    };
  }

  ProcedureEntity toEntity() {
    return ProcedureEntity(
      id: id,
      name: name,
      code: code,
      description: description,
      amountCents: amountCents,
    );
  }

  factory ProcedureModel.fromEntity(ProcedureEntity entity) {
    return ProcedureModel(
      id: entity.id,
      name: entity.name,
      code: entity.code,
      description: entity.description,
      amountCents: entity.amountCents,
    );
  }
}
