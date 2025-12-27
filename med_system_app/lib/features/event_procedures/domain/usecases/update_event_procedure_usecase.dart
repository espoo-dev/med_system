import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/event_procedure_entity.dart';
import '../repositories/event_procedure_repository.dart';

class UpdateEventProcedureUseCase
    implements UseCase<EventProcedureEntity, UpdateEventProcedureParams> {
  final EventProcedureRepository repository;

  UpdateEventProcedureUseCase(this.repository);

  @override
  Future<Either<Failure, EventProcedureEntity>> call(
      UpdateEventProcedureParams params) async {
    return await repository.updateEventProcedure(
      id: params.id,
      hospitalId: params.hospitalId,
      patientServiceNumber: params.patientServiceNumber,
      date: params.date,
      roomType: params.roomType,
      urgency: params.urgency,
      paidAt: params.paidAt,
      paid: params.paid,
      payment: params.payment,
      healthInsuranceAttributes: params.healthInsuranceAttributes,
      patientAttributes: params.patientAttributes,
      procedureAttributes: params.procedureAttributes,
    );
  }
}

class UpdateEventProcedureParams extends Equatable {
  final int id;
  final int hospitalId;
  final String patientServiceNumber;
  final String date;
  final String roomType;
  final bool urgency;
  final String? paidAt;
  final bool? paid;
  final String? payment;
  final Map<String, dynamic> healthInsuranceAttributes;
  final Map<String, dynamic> patientAttributes;
  final Map<String, dynamic> procedureAttributes;

  const UpdateEventProcedureParams({
    required this.id,
    required this.hospitalId,
    required this.patientServiceNumber,
    required this.date,
    required this.roomType,
    required this.urgency,
    this.paidAt,
    this.paid,
    this.payment,
    required this.healthInsuranceAttributes,
    required this.patientAttributes,
    required this.procedureAttributes,
  });

  @override
  List<Object?> get props => [
        id,
        hospitalId,
        patientServiceNumber,
        date,
        roomType,
        urgency,
        paidAt,
        paid,
        payment,
        healthInsuranceAttributes,
        patientAttributes,
        procedureAttributes,
      ];
}
