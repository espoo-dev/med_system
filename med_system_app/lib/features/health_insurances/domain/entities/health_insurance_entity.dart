import 'package:equatable/equatable.dart';

class HealthInsuranceEntity extends Equatable {
  final int id;
  final String name;

  const HealthInsuranceEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
