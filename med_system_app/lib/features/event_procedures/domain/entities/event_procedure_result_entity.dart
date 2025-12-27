import 'package:equatable/equatable.dart';
import 'event_procedure_entity.dart';

class EventProcedureResultEntity extends Equatable {
  final List<EventProcedureEntity> items;
  final String? total;
  final String? totalPaid;
  final String? totalUnpaid;

  const EventProcedureResultEntity({
    required this.items,
    this.total,
    this.totalPaid,
    this.totalUnpaid,
  });

  @override
  List<Object?> get props => [items, total, totalPaid, totalUnpaid];
}
