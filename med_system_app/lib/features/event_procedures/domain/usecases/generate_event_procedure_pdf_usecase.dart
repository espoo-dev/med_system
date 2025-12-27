import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/core/usecases/usecase.dart';
import 'package:distrito_medico/features/event_procedures/domain/repositories/event_procedure_repository.dart';
import 'package:equatable/equatable.dart';

class GenerateEventProcedurePdfUseCase implements UseCase<Uint8List, GenerateEventProcedurePdfParams> {
  final EventProcedureRepository _repository;

  GenerateEventProcedurePdfUseCase(this._repository);

  @override
  Future<Either<Failure, Uint8List>> call(GenerateEventProcedurePdfParams params) async {
    return await _repository.generatePdfReport(
      month: params.month,
      year: params.year,
      paid: params.paid,
      healthInsuranceName: params.healthInsuranceName,
      hospitalName: params.hospitalName,
    );
  }
}

class GenerateEventProcedurePdfParams extends Equatable {
  final int? month;
  final int? year;
  final bool? paid;
  final String? healthInsuranceName;
  final String? hospitalName;

  const GenerateEventProcedurePdfParams({
    this.month,
    this.year,
    this.paid,
    this.healthInsuranceName,
    this.hospitalName,
  });

  @override
  List<Object?> get props => [month, year, paid, healthInsuranceName, hospitalName];
}
