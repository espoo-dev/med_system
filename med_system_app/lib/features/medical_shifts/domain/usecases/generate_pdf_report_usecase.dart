import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/core/usecases/usecase.dart';
import 'package:distrito_medico/features/medical_shifts/domain/repositories/medical_shift_repository.dart';

class GeneratePdfReportUseCase implements UseCase<String, GeneratePdfReportParams> {
  final IMedicalShiftRepository repository;

  GeneratePdfReportUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(GeneratePdfReportParams params) async {
    return await repository.generatePdfReport(
      month: params.month,
      year: params.year,
      paid: params.paid,
      hospitalName: params.hospitalName,
    );
  }
}

class GeneratePdfReportParams extends Equatable {
  final int? month;
  final int? year;
  final bool? paid;
  final String? hospitalName;

  const GeneratePdfReportParams({
    this.month,
    this.year,
    this.paid,
    this.hospitalName,
  });

  @override
  List<Object?> get props => [month, year, paid, hospitalName];
}
