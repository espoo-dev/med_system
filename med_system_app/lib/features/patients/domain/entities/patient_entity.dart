import 'package:equatable/equatable.dart';

/// Entidade de negócio que representa um paciente
class PatientEntity extends Equatable {
  final int id;
  final String name;
  final bool deletable;

  const PatientEntity({
    required this.id,
    required this.name,
    required this.deletable,
  });

  @override
  List<Object?> get props => [id, name, deletable];

  @override
  String toString() => 'PatientEntity(id: $id, name: $name, deletable: $deletable)';

  /// Cria uma cópia com campos modificados
  PatientEntity copyWith({
    int? id,
    String? name,
    bool? deletable,
  }) {
    return PatientEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      deletable: deletable ?? this.deletable,
    );
  }
}
