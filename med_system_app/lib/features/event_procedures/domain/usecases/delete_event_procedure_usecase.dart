import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/event_procedure_repository.dart';

class DeleteEventProcedureUseCase
    implements UseCase<void, DeleteEventProcedureParams> {
  final EventProcedureRepository repository;

  DeleteEventProcedureUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteEventProcedureParams params) async {
    return await repository.deleteEventProcedure(params.id);
  }
}

class DeleteEventProcedureParams extends Equatable {
  final int id;

  const DeleteEventProcedureParams({required this.id});

  @override
  List<Object?> get props => [id];
}
