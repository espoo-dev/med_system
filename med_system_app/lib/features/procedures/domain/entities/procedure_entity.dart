import 'package:equatable/equatable.dart';

/// Entidade de negócio que representa um procedimento médico
class ProcedureEntity extends Equatable {
  final int id;
  final String name;
  final String code;
  final String description;
  final String amountCents;

  const ProcedureEntity({
    required this.id,
    required this.name,
    required this.code,
    required this.description,
    required this.amountCents,
  });

  @override
  List<Object?> get props => [id, name, code, description, amountCents];

  @override
  String toString() =>
      'ProcedureEntity(id: $id, name: $name, code: $code, description: $description, amountCents: $amountCents)';

  /// Cria uma cópia com campos modificados
  ProcedureEntity copyWith({
    int? id,
    String? name,
    String? code,
    String? description,
    String? amountCents,
  }) {
    return ProcedureEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      description: description ?? this.description,
      amountCents: amountCents ?? this.amountCents,
    );
  }
}
