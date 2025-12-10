import 'package:distrito_medico/features/medical_shifts/domain/entities/medical_shift_list_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/home_repository.dart';

/// UseCase para buscar os últimos plantões médicos
class GetLatestMedicalShiftsUseCase
    implements UseCase<MedicalShiftListEntity, GetLatestMedicalShiftsParams> {
  final HomeRepository repository;

  GetLatestMedicalShiftsUseCase(this.repository);

  @override
  Future<Either<Failure, MedicalShiftListEntity>> call(
      GetLatestMedicalShiftsParams params) async {
    return await repository.getLatestMedicalShifts(
      page: params.page,
      perPage: params.perPage,
    );
  }
}

/// Parâmetros para buscar últimos plantões
class GetLatestMedicalShiftsParams extends Equatable {
  final int page;
  final int perPage;

  const GetLatestMedicalShiftsParams({
    this.page = 1,
    this.perPage = 3,
  });

  @override
  List<Object?> get props => [page, perPage];
}
