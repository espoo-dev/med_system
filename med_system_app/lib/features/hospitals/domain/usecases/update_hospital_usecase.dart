import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/core/usecases/usecase.dart';
import 'package:distrito_medico/features/hospitals/domain/repositories/hospital_repository.dart';
import 'package:distrito_medico/features/hospitals/domain/entities/hospital_entity.dart';
import 'package:equatable/equatable.dart';

/// Parâmetros para UpdateHospitalUseCase
class UpdateHospitalParams extends Equatable {
  final int id;
  final String name;
  final String address;

  const UpdateHospitalParams({
    required this.id,
    required this.name,
    required this.address,
  });

  @override
  List<Object?> get props => [id, name, address];
}

/// Use Case responsável por atualizar um hospital
class UpdateHospitalUseCase
    implements UseCase<HospitalEntity, UpdateHospitalParams> {
  final HospitalRepository repository;

  UpdateHospitalUseCase(this.repository);

  @override
  Future<Either<Failure, HospitalEntity>> call(
    UpdateHospitalParams params,
  ) async {
    // Validação do ID
    if (params.id <= 0) {
      return const Left(
        ValidationFailure(message: 'ID do hospital inválido'),
      );
    }

    // Validação do nome
    if (params.name.isEmpty) {
      return const Left(
        ValidationFailure(message: 'Nome do hospital não pode ser vazio'),
      );
    }

    if (params.name.trim().length < 3) {
      return const Left(
        ValidationFailure(
          message: 'Nome do hospital deve ter no mínimo 3 caracteres',
        ),
      );
    }

    // Validação do endereço
    if (params.address.isEmpty) {
      return const Left(
        ValidationFailure(message: 'Endereço do hospital não pode ser vazio'),
      );
    }

    if (params.address.trim().length < 5) {
      return const Left(
        ValidationFailure(
          message: 'Endereço do hospital deve ter no mínimo 5 caracteres',
        ),
      );
    }

    return await repository.updateHospital(
      id: params.id,
      name: params.name.trim(),
      address: params.address.trim(),
    );
  }
}
