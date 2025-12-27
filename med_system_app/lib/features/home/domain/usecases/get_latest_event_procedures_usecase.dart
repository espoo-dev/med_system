import 'package:distrito_medico/features/event_procedures/domain/entities/event_procedure_list_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/home_repository.dart';

/// UseCase para buscar os últimos procedimentos
class GetLatestEventProceduresUseCase
    implements
        UseCase<EventProcedureListEntity, GetLatestEventProceduresParams> {
  final HomeRepository repository;

  GetLatestEventProceduresUseCase(this.repository);

  @override
  Future<Either<Failure, EventProcedureListEntity>> call(
      GetLatestEventProceduresParams params) async {
    return await repository.getLatestEventProcedures(
      page: params.page,
      perPage: params.perPage,
    );
  }
}

/// Parâmetros para buscar últimos procedimentos
class GetLatestEventProceduresParams extends Equatable {
  final int page;
  final int perPage;

  const GetLatestEventProceduresParams({
    this.page = 1,
    this.perPage = 3,
  });

  @override
  List<Object?> get props => [page, perPage];
}
