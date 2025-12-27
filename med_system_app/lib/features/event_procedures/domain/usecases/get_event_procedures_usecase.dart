import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/event_procedure_result_entity.dart';
import '../repositories/event_procedure_repository.dart';

class GetEventProceduresUseCase
    implements UseCase<EventProcedureResultEntity, GetEventProceduresParams> {
  final EventProcedureRepository repository;

  GetEventProceduresUseCase(this.repository);

  @override
  Future<Either<Failure, EventProcedureResultEntity>> call(
      GetEventProceduresParams params) async {
    return await repository.getEventProcedures(
      page: params.page,
      perPage: params.perPage,
      month: params.month,
      year: params.year,
      paid: params.paid,
      healthInsuranceName: params.healthInsuranceName,
      hospitalName: params.hospitalName,
    );
  }
}

class GetEventProceduresParams extends Equatable {
  final int page;
  final int perPage;
  final int? month;
  final int? year;
  final bool? paid;
  final String? healthInsuranceName;
  final String? hospitalName;

  const GetEventProceduresParams({
    this.page = 1,
    this.perPage = 10,
    this.month,
    this.year,
    this.paid,
    this.healthInsuranceName,
    this.hospitalName,
  });

  @override
  List<Object?> get props =>
      [page, perPage, month, year, paid, healthInsuranceName, hospitalName];
}
