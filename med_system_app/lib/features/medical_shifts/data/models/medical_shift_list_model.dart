import 'package:distrito_medico/features/medical_shifts/data/models/medical_shift_model.dart';
import 'package:distrito_medico/features/medical_shifts/domain/entities/medical_shift_list_entity.dart';

class MedicalShiftListModel extends MedicalShiftListEntity {
  const MedicalShiftListModel({
    required List<MedicalShiftModel> items,
    super.total,
    super.totalPaid,
    super.totalUnpaid,
  }) : super(items: items);

  factory MedicalShiftListModel.fromJson(Map<String, dynamic> json) {
    List<MedicalShiftModel> items = [];
    if (json['medical_shifts'] != null) {
      json['medical_shifts'].forEach((v) {
        items.add(MedicalShiftModel.fromJson(v));
      });
    }
    return MedicalShiftListModel(
      items: items,
      total: json['total'] ?? "",
      totalPaid: json['total_paid'] ?? "",
      totalUnpaid: json['total_unpaid'] ?? "",
    );
  }
}
