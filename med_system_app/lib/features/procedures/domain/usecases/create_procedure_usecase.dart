import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/core/usecases/usecase.dart';
import 'package:distrito_medico/features/procedures/domain/entities/procedure_entity.dart';
import 'package:distrito_medico/features/procedures/domain/repositories/procedure_repository.dart';
import 'package:equatable/equatable.dart';

class CreateProcedureParams extends Equatable {
  final String name;
  final String code;
  final String description;
  final String amountCents;

  const CreateProcedureParams({
    required this.name,
    required this.code,
    required this.description,
    required this.amountCents,
  });

  @override
  List<Object?> get props => [name, code, description, amountCents];
}

class CreateProcedureUseCase
    implements UseCase<ProcedureEntity, CreateProcedureParams> {
  final ProcedureRepository repository;

  CreateProcedureUseCase(this.repository);

  @override
  Future<Either<Failure, ProcedureEntity>> call(
    CreateProcedureParams params,
  ) async {
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

    return await repository.createProcedure(
      name: params.name.trim(),
      code: params.code.trim(),
      description: params.description.trim(),
      amountCents: params.amountCents.trim(),
    );
  }
}
