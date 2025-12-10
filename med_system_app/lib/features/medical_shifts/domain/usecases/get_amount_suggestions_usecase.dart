import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/core/usecases/usecase.dart';
import 'package:distrito_medico/features/medical_shifts/domain/repositories/medical_shift_repository.dart';

class GetAmountSuggestionsUseCase implements UseCase<List<String>, NoParams> {
  final IMedicalShiftRepository repository;

  GetAmountSuggestionsUseCase(this.repository);

  @override
  Future<Either<Failure, List<String>>> call(NoParams params) async {
    return await repository.getAmountSuggestions();
  }
}
