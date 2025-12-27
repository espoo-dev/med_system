import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/core/usecases/usecase.dart';
import 'package:distrito_medico/features/procedures/domain/entities/procedure_entity.dart';
import 'package:distrito_medico/features/procedures/domain/repositories/procedure_repository.dart';
import 'package:equatable/equatable.dart';

class UpdateProcedureParams extends Equatable {
  final int id;
  final String name;
  final String code;
  final String description;
  final String amountCents;

  const UpdateProcedureParams({
    required this.id,
    required this.name,
    required this.code,
    required this.description,
    required this.amountCents,
  });

  @override
  List<Object?> get props => [id, name, code, description, amountCents];
}

class UpdateProcedureUseCase
    implements UseCase<ProcedureEntity, UpdateProcedureParams> {
  final ProcedureRepository repository;

  UpdateProcedureUseCase(this.repository);

  @override
  Future<Either<Failure, ProcedureEntity>> call(
    UpdateProcedureParams params,
  ) async {
    if (params.id <= 0) {
      return const Left(
        ValidationFailure(message: 'ID do procedimento inválido'),
      );
    }

    if (params.name.isEmpty) {
      return const Left(
        ValidationFailure(message: 'Nome do procedimento não pode ser vazio'),
      );
    }

    if (params.code.isEmpty) {
      return const Left(
        ValidationFailure(message: 'Código do procedimento não pode ser vazio'),
      );
    }

    if (params.amountCents.isEmpty) {
      return const Left(
        ValidationFailure(message: 'Valor do procedimento não pode ser vazio'),
      );
    }

    return await repository.updateProcedure(
      id: params.id,
      name: params.name.trim(),
      code: params.code.trim(),
      description: params.description.trim(),
      amountCents: params.amountCents.trim(),
    );
  }
}
