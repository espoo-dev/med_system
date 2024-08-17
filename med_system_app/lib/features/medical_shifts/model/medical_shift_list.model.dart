import 'package:distrito_medico/features/medical_shifts/model/medical_shift.model.dart';

class MedicalShiftList {
  List<MedicalShiftModel>? medicalShiftModelList;
  String? total = "";
  String? totalPayd = "";
  String? totalUnpayd = "";

  MedicalShiftList(
      {this.medicalShiftModelList,
      this.total,
      this.totalPayd,
      this.totalUnpayd});

  MedicalShiftList.fromJson(Map<String, dynamic> json) {
    if (json['medical_shifts'] != null) {
      medicalShiftModelList = <MedicalShiftModel>[];
      json['medical_shifts'].forEach((v) {
        medicalShiftModelList!.add(MedicalShiftModel.fromJson(v));
      });
    }
    total = json['total'];
    totalPayd = json['total_payd'];
    totalUnpayd = json['total_unpaid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (medicalShiftModelList != null) {
      data['medical_shifts'] =
          medicalShiftModelList!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['total_payd'] = totalPayd;
    data['total_unpaid'] = totalUnpayd;
    return data;
  }
}
