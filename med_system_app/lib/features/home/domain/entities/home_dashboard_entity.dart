import 'package:equatable/equatable.dart';

/// Entidade que representa dados do dashboard da Home
class HomeDashboardEntity extends Equatable {
  final List<dynamic> latestEventProcedures;
  final List<dynamic> latestMedicalShifts;
  final String? totalEventProcedures;
  final String? totalMedicalShifts;

  const HomeDashboardEntity({
    required this.latestEventProcedures,
    required this.latestMedicalShifts,
    this.totalEventProcedures,
    this.totalMedicalShifts,
  });

  @override
  List<Object?> get props => [
        latestEventProcedures,
        latestMedicalShifts,
        totalEventProcedures,
        totalMedicalShifts,
      ];

  @override
  String toString() {
    return 'HomeDashboardEntity(eventProcedures: ${latestEventProcedures.length}, '
        'medicalShifts: ${latestMedicalShifts.length})';
  }
}
