import 'package:distrito_medico/features/event_procedures/data/models/event_procedure_model.dart';
import 'package:distrito_medico/features/event_procedures/domain/entities/event_procedure_list_entity.dart';

class EventProcedureListModel extends EventProcedureListEntity {
  const EventProcedureListModel({
    required List<EventProcedureModel> items,
    super.total,
    super.totalPaid,
    super.totalUnpaid,
  }) : super(items: items);

  factory EventProcedureListModel.fromJson(Map<String, dynamic> json) {
    List<EventProcedureModel> items = [];
    if (json['event_procedures'] != null) {
      json['event_procedures'].forEach((v) {
        items.add(EventProcedureModel.fromJson(v));
      });
    }
    return EventProcedureListModel(
      items: items,
      total: json['total']?.toString() ?? "",
      totalPaid: json['total_paid']?.toString() ?? "",
      totalUnpaid: json['total_unpaid']?.toString() ?? "",
    );
  }
}
