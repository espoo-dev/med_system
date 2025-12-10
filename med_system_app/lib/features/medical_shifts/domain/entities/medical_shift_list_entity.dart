import 'package:equatable/equatable.dart';
import 'package:distrito_medico/features/medical_shifts/domain/entities/medical_shift_entity.dart';

class MedicalShiftListEntity extends Equatable {
  final List<MedicalShiftEntity> items;
  final String total;
  final String totalPaid;
  final String totalUnpaid;

  const MedicalShiftListEntity({
    required this.items,
    this.total = "",
    this.totalPaid = "",
    this.totalUnpaid = "",
  });

  @override
  List<Object?> get props => [items, total, totalPaid, totalUnpaid];
}
