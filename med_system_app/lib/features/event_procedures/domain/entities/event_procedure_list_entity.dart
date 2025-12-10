import 'package:equatable/equatable.dart';
import 'package:distrito_medico/features/event_procedures/domain/entities/event_procedure_entity.dart';

class EventProcedureListEntity extends Equatable {
  final List<EventProcedureEntity> items;
  final String total;
  final String totalPaid;
  final String totalUnpaid;

  const EventProcedureListEntity({
    required this.items,
    this.total = "",
    this.totalPaid = "",
    this.totalUnpaid = "",
  });

  @override
  List<Object?> get props => [items, total, totalPaid, totalUnpaid];
}
