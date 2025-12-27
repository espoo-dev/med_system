import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/core/usecases/usecase.dart';
import 'package:distrito_medico/features/medical_shifts/domain/entities/medical_shift_list_entity.dart';
import 'package:distrito_medico/features/medical_shifts/domain/repositories/medical_shift_repository.dart';

class GetMedicalShiftsUseCase implements UseCase<MedicalShiftListEntity, GetMedicalShiftsParams> {
  final IMedicalShiftRepository repository;

  GetMedicalShiftsUseCase(this.repository);

  @override
  Future<Either<Failure, MedicalShiftListEntity>> call(GetMedicalShiftsParams params) async {
    return await repository.getMedicalShifts(
      page: params.page,
      month: params.month,
      year: params.year,
      paid: params.paid,
      hospitalName: params.hospitalName,
    );
  }
}

class GetMedicalShiftsParams extends Equatable {
  final int page;
  final int? month;
  final int? year;
  final bool? paid;
  final String? hospitalName;

  const GetMedicalShiftsParams({
    this.page = 1,
    this.month,
    this.year,
    this.paid,
    this.hospitalName,
  });

  @override
  List<Object?> get props => [page, month, year, paid, hospitalName];
}
