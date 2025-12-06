import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/core/usecases/usecase.dart';
import 'package:distrito_medico/features/hospitals/domain/entities/hospital_entity.dart';
import 'package:distrito_medico/features/hospitals/domain/repositories/hospital_repository.dart';
import 'package:equatable/equatable.dart';

/// Parâmetros para CreateHospitalUseCase
class CreateHospitalParams extends Equatable {
  final String name;
  final String address;

  const CreateHospitalParams({
    required this.name,
    required this.address,
  });

  @override
  List<Object?> get props => [name, address];
}

/// Use Case responsável por criar um hospital
class CreateHospitalUseCase
    implements UseCase<HospitalEntity, CreateHospitalParams> {
  final HospitalRepository repository;

  CreateHospitalUseCase(this.repository);

  @override
  Future<Either<Failure, HospitalEntity>> call(
    CreateHospitalParams params,
  ) async {
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

    return await repository.createHospital(
      name: params.name.trim(),
      address: params.address.trim(),
    );
  }
}
