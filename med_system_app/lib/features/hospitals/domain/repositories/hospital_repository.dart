import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/hospitals/domain/entities/hospital_entity.dart';

/// Interface do repositório de hospitais
/// Define as operações que podem ser realizadas com hospitais
abstract class HospitalRepository {
  /// Obtém uma lista paginada de hospitais
  Future<Either<Failure, List<HospitalEntity>>> getAllHospitals({
    int page = 1,
    int perPage = 10000,
  });

  /// Cria um novo hospital
  Future<Either<Failure, HospitalEntity>> createHospital({
    required String name,
    required String address,
  });

  /// Atualiza um hospital existente
  Future<Either<Failure, HospitalEntity>> updateHospital({
    required int id,
    required String name,
    required String address,
  });
}
