import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/core/usecases/usecase.dart';
import 'package:distrito_medico/features/event_procedures/domain/repositories/event_procedure_repository.dart';
import 'package:distrito_medico/features/event_procedures/domain/usecases/delete_event_procedure_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockEventProcedureRepository extends Mock
    implements EventProcedureRepository {}

void main() {
  late DeleteEventProcedureUseCase usecase;
  late MockEventProcedureRepository mockRepository;

  setUp(() {
    mockRepository = MockEventProcedureRepository();
    usecase = DeleteEventProcedureUseCase(mockRepository);
  });

  const tId = 1;
  const tParams = DeleteEventProcedureParams(id: tId);

  test('should delete event procedure from repository', () async {
    // arrange
    when(() => mockRepository.deleteEventProcedure(any()))
        .thenAnswer((_) async => const Right(unit));

    // act
    final result = await usecase(tParams);

    // assert
    expect(result, const Right(unit));
    verify(() => mockRepository.deleteEventProcedure(tId)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return failure when repository fails', () async {
    // arrange
    const tFailure = ServerFailure(message: 'Failed to delete');
    when(() => mockRepository.deleteEventProcedure(any()))
        .thenAnswer((_) async => const Left(tFailure));

    // act
    final result = await usecase(tParams);

    // assert
    expect(result, const Left(tFailure));
    verify(() => mockRepository.deleteEventProcedure(tId)).called(1);
  });
}
