import 'package:equatable/equatable.dart';

/// Entidade de negócio que representa um hospital
class HospitalEntity extends Equatable {
  final int id;
  final String name;
  final String address;

  const HospitalEntity({
    required this.id,
    required this.name,
    required this.address,
  });

  @override
  List<Object?> get props => [id, name, address];

  @override
  String toString() => 'HospitalEntity(id: $id, name: $name, address: $address)';

  /// Cria uma cópia com campos modificados
  HospitalEntity copyWith({
    int? id,
    String? name,
    String? address,
  }) {
    return HospitalEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
    );
  }
}
