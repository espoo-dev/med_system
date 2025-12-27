import 'package:distrito_medico/features/event_procedures/domain/entities/event_procedure_list_entity.dart';
import 'package:distrito_medico/features/medical_shifts/domain/entities/medical_shift_list_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';

/// Interface do repositório da Home
abstract class HomeRepository {
  /// Busca os últimos procedimentos
  Future<Either<Failure, EventProcedureListEntity>> getLatestEventProcedures({
    int page = 1,
    int perPage = 3,
  });

  /// Busca os últimos plantões médicos
  Future<Either<Failure, MedicalShiftListEntity>> getLatestMedicalShifts({
    int page = 1,
    int perPage = 3,
  });
}
