import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/core/usecases/usecase.dart';
import 'package:distrito_medico/features/procedures/domain/entities/procedure_entity.dart';
import 'package:distrito_medico/features/procedures/domain/repositories/procedure_repository.dart';
import 'package:equatable/equatable.dart';

class GetAllProceduresParams extends Equatable {
  final int page;
  final int perPage;

  const GetAllProceduresParams({
    this.page = 1,
    this.perPage = 10,
  });

  @override
  List<Object?> get props => [page, perPage];
}

class GetAllProceduresUseCase
    implements UseCase<List<ProcedureEntity>, GetAllProceduresParams> {
  final ProcedureRepository repository;

  GetAllProceduresUseCase(this.repository);

  @override
  Future<Either<Failure, List<ProcedureEntity>>> call(
    GetAllProceduresParams params,
  ) async {
    if (params.page < 1) {
      return const Left(
        ValidationFailure(message: 'Página deve ser maior que 0'),
      );
    }
    return await repository.getAllProcedures(
      page: params.page,
      perPage: params.perPage,
    );
  }
}
