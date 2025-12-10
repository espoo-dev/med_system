import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/event_procedure_entity.dart';
import '../repositories/event_procedure_repository.dart';

class UpdateEventProcedurePaymentUseCase
    implements
        UseCase<EventProcedureEntity, UpdateEventProcedurePaymentParams> {
  final EventProcedureRepository repository;

  UpdateEventProcedurePaymentUseCase(this.repository);

  @override
  Future<Either<Failure, EventProcedureEntity>> call(
      UpdateEventProcedurePaymentParams params) async {
    return await repository.updatePaymentStatus(
      id: params.id,
      paid: params.paid,
      paidAt: params.paidAt,
      payment: params.payment,
    );
  }
}

class UpdateEventProcedurePaymentParams extends Equatable {
  final int id;
  final bool paid;
  final String? paidAt;
  final String? payment;

  const UpdateEventProcedurePaymentParams({
    required this.id,
    required this.paid,
    this.paidAt,
    this.payment,
  });

  @override
  List<Object?> get props => [id, paid, paidAt, payment];
}
