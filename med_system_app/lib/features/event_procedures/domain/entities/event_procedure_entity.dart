import 'package:equatable/equatable.dart';

class EventProcedureEntity extends Equatable {
  final int? id;
  final String? procedure;
  final String? patient;
  final String? hospital;
  final String? healthInsurance;
  final String? patientServiceNumber;
  final String? date;
  final String? roomType;
  final bool? urgency;
  final String? paidAt;
  final bool? paid;
  final String? totalAmountCents;
  final String? payment;
  final String? procedureValue;
  final String? procedureDescription;

  const EventProcedureEntity({
    this.id,
    this.procedure,
    this.patient,
    this.hospital,
    this.healthInsurance,
    this.patientServiceNumber,
    this.date,
    this.roomType,
    this.urgency,
    this.paidAt,
    this.paid,
    this.totalAmountCents,
    this.payment,
    this.procedureValue,
    this.procedureDescription,
  });

  @override
  List<Object?> get props => [
        id,
        procedure,
        patient,
        hospital,
        healthInsurance,
        patientServiceNumber,
        date,
        roomType,
        urgency,
        paidAt,
        paid,
        totalAmountCents,
        payment,
        procedureValue,
        procedureDescription,
      ];
}
