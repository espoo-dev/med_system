import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/procedures/domain/entities/procedure_entity.dart';

/// Interface do repositório de procedimentos
abstract class ProcedureRepository {
  /// Obtém uma lista paginada de procedimentos
  Future<Either<Failure, List<ProcedureEntity>>> getAllProcedures({
    int page = 1,
    int perPage = 10,
  });

  /// Cria um novo procedimento
  Future<Either<Failure, ProcedureEntity>> createProcedure({
    required String name,
    required String code,
    required String description,
    required String amountCents,
  });

  /// Atualiza um procedimento existente
  Future<Either<Failure, ProcedureEntity>> updateProcedure({
    required int id,
    required String name,
    required String code,
    required String description,
    required String amountCents,
  });
}
